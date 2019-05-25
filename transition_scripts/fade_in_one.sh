#!/bin/bash
#
# ffmpeg video slideshow script with fade in #1 transition v4 (25.05.2019)
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
PHOTO_DURATION=2
SCREEN_MODE=2                # 1=CENTER, 2=CROP, 3=SCALE, 4=BLUR
BACKGROUND_COLOR="black"

IFS=$'\t\n'                 # REQUIRED TO SUPPORT SPACES IN FILE NAMES

# FILE OPTIONS
# FILES=`find ../media/*.jpg | sort -r`                 # USE ALL IMAGES UNDER THE media FOLDER SORTED
# FILES=('../media/1.jpg' '../media/2.jpg')         # USE ONLY THESE IMAGE FILES
FILES=`find ../media/*.jpg`                         # USE ALL IMAGES UNDER THE media FOLDER

############################
# DO NO MODIFY LINES BELOW
############################

# CALCULATE LENGTH MANUALLY
let PHOTOS_COUNT=0
for photo in ${FILES[@]}; do (( PHOTOS_COUNT+=1 )); done

if [[ ${PHOTOS_COUNT} -lt 2 ]]; then
    echo "Error: photos folder should contain at least two photos"
    exit 1;
fi

# INTERNAL VARIABLES
TRANSITION_FRAME_COUNT=$(( TRANSITION_DURATION*FPS ))
PHOTO_FRAME_COUNT=$(( PHOTO_DURATION*FPS ))
TOTAL_DURATION=$(( (PHOTO_DURATION+TRANSITION_DURATION)*PHOTOS_COUNT - TRANSITION_DURATION ))
TOTAL_FRAME_COUNT=$(( TOTAL_DURATION*FPS ))

echo -e "\nVideo Slideshow Info\n------------------------\nPhoto count: ${PHOTOS_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: ${FPS}\nPhoto duration: ${PHOTO_DURATION} s\n\
Transition duration: ${TRANSITION_DURATION} s\nTotal duration: ${TOTAL_DURATION} s\n"

START_TIME=$SECONDS

# 1. START COMMAND
FULL_SCRIPT="ffmpeg -y "

# 2. ADD INPUTS
for photo in ${FILES[@]}; do
    FULL_SCRIPT+="-loop 1 -i '${photo}' "
done

# 3. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 4. PREPARE INPUTS
for (( c=0; c<${PHOTOS_COUNT}; c++ ))
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

# 6. CREATE TRANSITION FRAMES
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream$((c+1))starting][stream${c}ending]blend=all_expr='A*(if(gte(T,${TRANSITION_DURATION}),1,T/${TRANSITION_DURATION}))+B*(1-(if(gte(T,${TRANSITION_DURATION}),1,T/${TRANSITION_DURATION})))',select=lte(n\,${TRANSITION_FRAME_COUNT})[stream$((c+1))blended];"
done

# 7. BEGIN CONCAT
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}overlaid][stream$((c+1))blended]"
done

# 8. END CONCAT
FULL_SCRIPT+="[stream${PHOTOS_COUNT}overlaid]concat=n=$((2*PHOTOS_COUNT-1)):v=1:a=0,format=yuv420p[video]\""

# 9. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../transition_fade_in_one.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'

unset $IFS