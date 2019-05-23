#!/bin/bash
#
# ffmpeg video slideshow script with vertical push transition v4 (10.12.2018)
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
PHOTO_MODE=2                # 1=CENTER, 2=CROP, 3=SCALE, 4=BLUR
BACKGROUND_COLOR="black"
DIRECTION=1                 # 1=TOP TO BOTTOM, 2=BOTTOM TO TOP

IFS=$'\t\n'                 # REQUIRED TO SUPPORT SPACES IN FILE NAMES

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

echo -e "\nVideo Slideshow Info\n------------------------\nPhoto count: ${PHOTOS_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: ${FPS}\nPhoto duration: ${PHOTO_DURATION} s\n\
Transition duration: ${TRANSITION_DURATION} s\nTotal duration: ${TOTAL_DURATION} s\n"

START_TIME=$SECONDS

# 1. START COMMAND
FULL_SCRIPT="ffmpeg -y "

# 2. ADD INPUTS
for photo in ${PHOTOS}; do
    FULL_SCRIPT+="-loop 1 -i '${photo}' "
done

# 3. ADD BACKGROUND COLOR SCREEN INPUT
FULL_SCRIPT+="-f lavfi -i color=${BACKGROUND_COLOR}:s=${WIDTH}x${HEIGHT},fps=${FPS} "

# 4. ADD TRANSPARENT SCREEN INPUT
FULL_SCRIPT+="-f lavfi -i nullsrc=s=${WIDTH}x${HEIGHT},fps=${FPS} "

# 5. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 6. PREPARING SCALED INPUTS
for (( c=0; c<${PHOTOS_COUNT}; c++ ))
do
    case ${PHOTO_MODE} in
        1)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,fps=${FPS},format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        2)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',[${PHOTOS_COUNT}:v]overlay,crop=${WIDTH}:${HEIGHT},setsar=sar=1/1,fps=${FPS},format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
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

# 7. OVERLAY INPUTS ON TOP OF BACKGROUND COLOR SCREEN
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do

    # NOTE THAT threads=1 is a workaround for ffmpeg v4.1

    FULL_SCRIPT+="[${PHOTOS_COUNT}:v][stream${c}out1]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:threads=1:format=rgb,trim=duration=${PHOTO_DURATION},select=lte(n\,${PHOTO_FRAME_COUNT})[stream${c}overlaid];"
    if [[ ${c} -eq 1 ]]; then
        if  [[ ${PHOTOS_COUNT} -gt 1 ]]; then
            FULL_SCRIPT+="[${PHOTOS_COUNT}:v][stream${c}out2]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:threads=1:format=rgb,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}ending];"
        fi
    elif [[ ${c} -lt ${PHOTOS_COUNT} ]]; then
        FULL_SCRIPT+="[${PHOTOS_COUNT}:v][stream${c}out2]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:threads=1:format=rgb,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT}),split=2[stream${c}starting][stream${c}ending];"
    elif [[ ${c} -eq ${PHOTOS_COUNT} ]]; then
        FULL_SCRIPT+="[${PHOTOS_COUNT}:v][stream${c}out2]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:threads=1:format=rgb,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}starting];"
    fi
done

# 8. CREATING TRANSITIONS 1
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    case ${DIRECTION} in
        1)
            FULL_SCRIPT+="[$((PHOTOS_COUNT+1)):v][stream${c}ending]overlay=y='t/${TRANSITION_DURATION}*${HEIGHT}':x=0:threads=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}moving];"
            FULL_SCRIPT+="[stream${c}moving][stream$((c+1))starting]overlay=y='-h+t/${TRANSITION_DURATION}*${HEIGHT}':x=0:threads=1:shortest=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream$((c+1))blended];"
        ;;
        *)
            FULL_SCRIPT+="[$((PHOTOS_COUNT+1)):v][stream${c}ending]overlay=y='-t/${TRANSITION_DURATION}*${HEIGHT}':x=0:threads=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}moving];"
            FULL_SCRIPT+="[stream${c}moving][stream$((c+1))starting]overlay=y='h-t/${TRANSITION_DURATION}*${HEIGHT}':x=0:threads=1:shortest=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream$((c+1))blended];"
        ;;
    esac
done

# 9. BEGIN CONCAT
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}overlaid][stream$((c+1))blended]"
done

# 10. END CONCAT
FULL_SCRIPT+="[stream${PHOTOS_COUNT}overlaid]concat=n=$((2*PHOTOS_COUNT-1)):v=1:a=0,format=yuv420p[video]\""

# 11. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../transition_push_vertical.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'

unset $IFS