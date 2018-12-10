#!/bin/bash
#
# ffmpeg video slideshow script for advanced moving text v4 (10.12.2018)
#
# Copyright (c) 2017-2018, Taner Sener (https://github.com/tanersener)
#
# This work is licensed under the terms of the MIT license. For a copy, see <https://opensource.org/licenses/MIT>.
#

# SCRIPT OPTIONS - CAN BE MODIFIED
WIDTH=1280
HEIGHT=720
FPS=30
TRANSITION_DURATION=1
PHOTO_DURATION=2
PHOTO_MODE=3                # 1=CENTER, 2=CROP, 3=SCALE, 4=BLUR
TEXT_FRAME_HEIGHT=60
TEXT_FRAME_Y=660
TEXT_Y=678
TEXT_FONT="../fonts/FallingSkyBd.otf"
TEXT="5 Wonders of the World\:   1. Colosseum   2. The Great Pyramid & Sphinx Eygpt   3. Leaning Tower of Pisa   4. Taj Mahal   5. Chichen Itza"
TEXT_FONT_SIZE=30
TEXT_FONT_COLOR=white
TEXT_SPEED=3                # 1=FASTEST, 2=FASTER, 3=MODERATE, 4=SLOW, 5=SLOWEST
BACKGROUND_COLOR="#00000000"
DIRECTION=2                 # 1=LEFT TO RIGHT, 2=RIGHT TO LEFT

# PHOTO OPTIONS - ALL FILES UNDER photos FOLDER ARE USED - USE sort TO SPECIFY A SORTING MECHANISM
# PHOTOS=`find ../photos/* | sort -r`
PHOTOS=`find ../photos/*`

############################
# DO NO MODIFY LINES BELOW
############################

# CALCULATE LENGTH MANUALLY
let PHOTOS_COUNT=0
for photo in ${PHOTOS}; do (( PHOTOS_COUNT+=1 )); done

if [[ ${PHOTOS_COUNT} -lt 2 ]]; then
    echo "Error: photos folder should contain at least two photos"
    exit 1;
fi

# INTERNAL VARIABLES
TRANSITION_FRAME_COUNT=$(( TRANSITION_DURATION*FPS ))
PHOTO_FRAME_COUNT=$(( PHOTO_DURATION*FPS ))
TOTAL_DURATION=$(( (PHOTO_DURATION+TRANSITION_DURATION)*PHOTOS_COUNT - TRANSITION_DURATION ))
TOTAL_FRAME_COUNT=$(( TOTAL_DURATION*FPS ))

echo -e "\nVideo Slideshow Info\n------------------------\nPhoto count: ${PHOTOS_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: 30\nPhoto duration: ${PHOTO_DURATION} s\n\
Transition duration: ${TRANSITION_DURATION} s\nTotal duration: ${TOTAL_DURATION} s\n"

START_TIME=$SECONDS

# 1. START COMMAND
FULL_SCRIPT="ffmpeg -y "

# 2. ADD INPUTS
for photo in ${PHOTOS}; do
    FULL_SCRIPT+="-loop 1 -i ${photo} "
done

# 3. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 4. PREPARING SCALED INPUTS
for (( c=0; c<${PHOTOS_COUNT}; c++ ))
do
    case ${PHOTO_MODE} in
        1)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        2)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',crop=${WIDTH}:${HEIGHT},setsar=sar=1/1,format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        3)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=${WIDTH}:${HEIGHT},setsar=sar=1/1,format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        4)
            FULL_SCRIPT+="[${c}:v]scale=${WIDTH}x${HEIGHT},setsar=sar=1/1,format=rgba,boxblur=100,setsar=sar=1/1[stream${c}blurred];"
            FULL_SCRIPT+="[${c}:v]scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream${c}raw];"
            FULL_SCRIPT+="[stream${c}blurred][stream${c}raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
    esac
done

# 5. APPLYING PADDING
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}out1]pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=${BACKGROUND_COLOR},trim=duration=${PHOTO_DURATION},select=lte(n\,${PHOTO_FRAME_COUNT})[stream${c}overlaid];"
    if [[ ${c} -eq 1 ]]; then
        if  [[ ${PHOTOS_COUNT} -gt 1 ]]; then
            FULL_SCRIPT+="[stream${c}out2]pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=${BACKGROUND_COLOR},trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}ending];"
        fi
    elif [[ ${c} -lt ${PHOTOS_COUNT} ]]; then
        FULL_SCRIPT+="[stream${c}out2]pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=${BACKGROUND_COLOR},trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT}),split=2[stream${c}starting][stream${c}ending];"
    elif [[ ${c} -eq ${PHOTOS_COUNT} ]]; then
        FULL_SCRIPT+="[stream${c}out2]pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=${BACKGROUND_COLOR},trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}starting];"
    fi
done

# 6. CREATING TRANSITION FRAMES
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream$((c+1))starting][stream${c}ending]blend=all_expr='A*(if(gte(T,${TRANSITION_DURATION}),${TRANSITION_DURATION},T/${TRANSITION_DURATION}))+B*(1-(if(gte(T,${TRANSITION_DURATION}),${TRANSITION_DURATION},T/${TRANSITION_DURATION})))',select=lte(n\,${TRANSITION_FRAME_COUNT})[stream$((c+1))blended];"
done

# 7. BEGIN CONCAT
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}overlaid][stream$((c+1))blended]"
done

# 8. END CONCAT
FULL_SCRIPT+="[stream${PHOTOS_COUNT}overlaid]concat=n=$((2*PHOTOS_COUNT-1)):v=1:a=0,format=yuv420p[videowithouttext];"

# 10. PREPARE TEXT BOX
FULL_SCRIPT+="[videowithouttext]drawbox=x=0:y=${TEXT_FRAME_Y}:w=${WIDTH}:h=${TEXT_FRAME_HEIGHT}:color=black@0.65:t=${TEXT_FRAME_HEIGHT},trim=duration=${TOTAL_DURATION}[videowithbox];"

# 11. OVERLAY TEXT ON TOP OF SLIDESHOW
case ${DIRECTION} in
    1)
        FULL_SCRIPT+="[videowithbox]drawtext=fontfile=${TEXT_FONT}:text='${TEXT}':fontsize=${TEXT_FONT_SIZE}:fontcolor=${TEXT_FONT_COLOR}:x='-text_w + mod(t/${TEXT_SPEED}*((${WIDTH}+text_w)/$((TEXT_SPEED))),${WIDTH}+text_w)':y=${TEXT_Y}[video]\""
    ;;
    *)
        FULL_SCRIPT+="[videowithbox]drawtext=fontfile=${TEXT_FONT}:text='${TEXT}':fontsize=${TEXT_FONT_SIZE}:fontcolor=${TEXT_FONT_COLOR}:x='${WIDTH} - mod(t/${TEXT_SPEED}*((${WIDTH}+text_w)/$((TEXT_SPEED))),${WIDTH}+text_w)':y=${TEXT_Y}[video]\""
    ;;
esac

# 12. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../advanced_moving_text.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'