#!/bin/bash
#
# ffmpeg video slideshow script for advanced moving text v5 (25.05.2019)
#
# Copyright (c) 2017-2019, Taner Sener (https://github.com/tanersener)
#
# This work is licensed under the terms of the MIT license. For a copy, see <https://opensource.org/licenses/MIT>.
#

# SCRIPT OPTIONS - CAN BE MODIFIED
WIDTH=1280
HEIGHT=720
FPS=30
TRANSITION_DURATION=1
IMAGE_DURATION=2
SCREEN_MODE=3                # 1=CENTER, 2=CROP, 3=SCALE, 4=BLUR
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

IFS=$'\t\n'                 # REQUIRED TO SUPPORT SPACES IN FILE NAMES

# FILE OPTIONS
# FILES=`find ../media/*.jpg | sort -r`             # USE ALL IMAGES UNDER THE media FOLDER SORTED
# FILES=('../media/1.jpg' '../media/2.jpg')         # USE ONLY THESE IMAGE FILES
FILES=`find ../media/*.jpg`                         # USE ALL IMAGES UNDER THE media FOLDER

############################
# DO NO MODIFY LINES BELOW
############################

# CALCULATE LENGTH MANUALLY
let IMAGE_COUNT=0
for IMAGE in ${FILES[@]}; do (( IMAGE_COUNT+=1 )); done

if [[ ${IMAGE_COUNT} -lt 2 ]]; then
    echo "Error: media folder should contain at least two images"
    exit 1;
fi

# INTERNAL VARIABLES
TRANSITION_FRAME_COUNT=$(( TRANSITION_DURATION*FPS ))
IMAGE_FRAME_COUNT=$(( IMAGE_DURATION*FPS ))
TOTAL_DURATION=$(( (IMAGE_DURATION+TRANSITION_DURATION)*IMAGE_COUNT - TRANSITION_DURATION ))
TOTAL_FRAME_COUNT=$(( TOTAL_DURATION*FPS ))

echo -e "\nVideo Slideshow Info\n------------------------\nImage count: ${IMAGE_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: ${FPS}\nImage duration: ${IMAGE_DURATION} s\n\
Transition duration: ${TRANSITION_DURATION} s\nTotal duration: ${TOTAL_DURATION} s\n"

START_TIME=$SECONDS

# 1. START COMMAND
FULL_SCRIPT="ffmpeg -y "

# 2. ADD INPUTS
for IMAGE in ${FILES[@]}; do
    FULL_SCRIPT+="-loop 1 -i '${IMAGE}' "
done

# 3. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 4. PREPARE INPUTS
for (( c=0; c<${IMAGE_COUNT}; c++ ))
do
    case ${SCREEN_MODE} in
        1)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,fps=${FPS},format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        2)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',crop=${WIDTH}:${HEIGHT},setsar=sar=1/1,fps=${FPS},format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        3)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=${WIDTH}:${HEIGHT},setsar=sar=1/1,fps=${FPS},format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        4)
            FULL_SCRIPT+="[${c}:v]scale=${WIDTH}x${HEIGHT},setsar=sar=1/1,fps=${FPS},format=rgba,boxblur=100,setsar=sar=1/1[stream${c}blurred];"
            FULL_SCRIPT+="[${c}:v]scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,fps=${FPS},format=rgba[stream${c}raw];"
            FULL_SCRIPT+="[stream${c}blurred][stream${c}raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
    esac
done

# 5. APPLY PADDING
for (( c=1; c<=${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}out1]pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=${BACKGROUND_COLOR},trim=duration=${IMAGE_DURATION},select=lte(n\,${IMAGE_FRAME_COUNT})[stream${c}overlaid];"
    if [[ ${c} -eq 1 ]]; then
        if  [[ ${IMAGE_COUNT} -gt 1 ]]; then
            FULL_SCRIPT+="[stream${c}out2]pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=${BACKGROUND_COLOR},trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}ending];"
        fi
    elif [[ ${c} -lt ${IMAGE_COUNT} ]]; then
        FULL_SCRIPT+="[stream${c}out2]pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=${BACKGROUND_COLOR},trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT}),split=2[stream${c}starting][stream${c}ending];"
    elif [[ ${c} -eq ${IMAGE_COUNT} ]]; then
        FULL_SCRIPT+="[stream${c}out2]pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=${BACKGROUND_COLOR},trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}starting];"
    fi
done

# 6. CREATE TRANSITION FRAMES
for (( c=1; c<${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream$((c+1))starting][stream${c}ending]blend=all_expr='A*(if(gte(T,${TRANSITION_DURATION}),${TRANSITION_DURATION},T/${TRANSITION_DURATION}))+B*(1-(if(gte(T,${TRANSITION_DURATION}),${TRANSITION_DURATION},T/${TRANSITION_DURATION})))',select=lte(n\,${TRANSITION_FRAME_COUNT})[stream$((c+1))blended];"
done

# 7. BEGIN CONCAT
for (( c=1; c<${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}overlaid][stream$((c+1))blended]"
done

# 8. END CONCAT
FULL_SCRIPT+="[stream${IMAGE_COUNT}overlaid]concat=n=$((2*IMAGE_COUNT-1)):v=1:a=0,format=yuv420p[videowithouttext];"

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

unset $IFS