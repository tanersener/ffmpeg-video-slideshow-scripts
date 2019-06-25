#!/bin/bash
#
# ffmpeg video slideshow script with advanced push vertical film v5 (25.05.2019)
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
SCREEN_MODE=2               # 1=CENTER, 2=CROP, 3=SCALE, 4=BLUR
BACKGROUND_COLOR="#00000000"
DIRECTION=1                 # 1=TOP TO BOTTOM, 2=BOTTOM TO TOP

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
TOTAL_DURATION=$(( (TRANSITION_DURATION)*IMAGE_COUNT + TRANSITION_DURATION ))
TOTAL_FRAME_COUNT=$(( TOTAL_DURATION*FPS ))

echo -e "\nVideo Slideshow Info\n------------------------\nImage count: ${IMAGE_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: ${FPS}\nTransition duration: ${TRANSITION_DURATION} s\n\
Total duration: ${TOTAL_DURATION} s\n"

START_TIME=$SECONDS

# 1. START COMMAND
FULL_SCRIPT="ffmpeg -y "

# 2. ADD INPUTS
for IMAGE in ${FILES[@]}; do
    FULL_SCRIPT+="-loop 1 -i '${IMAGE}' "
done

# 3. ADD FILM STRIP IMAGE INPUT
FULL_SCRIPT+="-loop 1 -i ../objects/film_strip_vertical.png "

# 4. ADD BACKGROUND COLOR SCREEN INPUT
FULL_SCRIPT+="-f lavfi -i color=${BACKGROUND_COLOR}:s=${WIDTH}x${HEIGHT},fps=${FPS} "

# 5. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 6. PREPARE INPUTS
for (( c=0; c<${IMAGE_COUNT}; c++ ))
do
    case ${SCREEN_MODE} in
        1)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=#00000000,setsar=sar=1/1,fps=${FPS}[stream$((c+1))];"
        ;;
        2)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',[${IMAGE_COUNT}:v]overlay,crop=${WIDTH}:${HEIGHT},setsar=sar=1/1,fps=${FPS}[stream$((c+1))];"
        ;;
        3)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=${WIDTH}:${HEIGHT},setsar=sar=1/1,fps=${FPS}[stream$((c+1))];"
        ;;
        4)
            FULL_SCRIPT+="[${c}:v]scale=${WIDTH}x${HEIGHT},setsar=sar=1/1,fps=${FPS},format=rgba,boxblur=100,setsar=sar=1/1[stream${c}blurred];"
            FULL_SCRIPT+="[${c}:v]scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,fps=${FPS},format=rgba[stream${c}raw];"
            FULL_SCRIPT+="[stream${c}blurred][stream${c}raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,setsar=sar=1/1[stream$((c+1))];"
        ;;
    esac
done

# 7. PREPARE FILM STRIP IMAGE
FULL_SCRIPT+="[${IMAGE_COUNT}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=${IMAGE_COUNT}"

for (( c=1; c<=${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[frame${c}]"
done

FULL_SCRIPT+=";"

# 8. OVERLAY FILM STRIP ON TOP OF INPUTS
for (( c=1; c<=${IMAGE_COUNT}; c++ ))
do

    FULL_SCRIPT+="[stream${c}][frame${c}]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT}),split=2[stream${c}starting][stream${c}ending];"

    case ${DIRECTION} in
        1)
            FULL_SCRIPT+="[$(( IMAGE_COUNT+1 )):v][stream${c}ending]overlay=y='t/${TRANSITION_DURATION}*${HEIGHT}':x=0,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}moving];"

            if [[ ${c} -eq 1 ]]; then
                FULL_SCRIPT+="[$(( IMAGE_COUNT+1 )):v]"
            else
                FULL_SCRIPT+="[stream$(( c-1 ))moving]"
            fi

            FULL_SCRIPT+="[stream${c}starting]overlay=y='-h+t/${TRANSITION_DURATION}*${HEIGHT}':x=0:shortest=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}blended];"
        ;;
        *)
            FULL_SCRIPT+="[$(( IMAGE_COUNT+1 )):v][stream${c}ending]overlay=y='-t/${TRANSITION_DURATION}*${HEIGHT}':x=0,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}moving];"

            if [[ ${c} -eq 1 ]]; then
                FULL_SCRIPT+="[$(( IMAGE_COUNT+1 )):v]"
            else
                FULL_SCRIPT+="[stream$(( c-1 ))moving]"
            fi

            FULL_SCRIPT+="[stream${c}starting]overlay=y='h-t/${TRANSITION_DURATION}*${HEIGHT}':x=0:shortest=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}blended];"
        ;;
    esac
done

# 9. BEGIN CONCAT
for (( c=1; c<=${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}blended]"
done

# 10. END CONCAT
FULL_SCRIPT+="[stream${IMAGE_COUNT}moving]concat=n=$((IMAGE_COUNT+1)):v=1:a=0,format=yuv420p[video]\""

# 11. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../advanced_push_vertical_film.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'

unset $IFS