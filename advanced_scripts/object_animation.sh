#!/bin/bash
#
# ffmpeg video slideshow script with advanced object animation (formerly object move) v5 (25.05.2019)
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
SNOW_FLAKE_WIDTH=52
SNOW_FLAKE_HEIGHT=60
SNOW_FLAKE_ROTATE_SPEED=3                   # 1=FASTEST, 2=FASTER, 3=MODERATE, 4=SLOW, 5=SLOWEST
SNOW_FLAKE_FALL_SPEED=3                     # 1=FASTEST, 2=FASTER, 3=MODERATE, 4=SLOW, 5=SLOWEST
BACKGROUND_COLOR="#00000000"

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

# 3. ADD SNOW FLAKE IMAGE INPUT
FULL_SCRIPT+="-loop 1 -i ../objects/snow-flake.png "

# 4. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 5. PREPARE INPUTS
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

# 6. APPLY PADDING
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

# 7. CREATE TRANSITION FRAMES
for (( c=1; c<${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream$((c+1))starting][stream${c}ending]blend=all_expr='A*(if(gte(T,${TRANSITION_DURATION}),${TRANSITION_DURATION},T/${TRANSITION_DURATION}))+B*(1-(if(gte(T,${TRANSITION_DURATION}),${TRANSITION_DURATION},T/${TRANSITION_DURATION})))',select=lte(n\,${TRANSITION_FRAME_COUNT})[stream$((c+1))blended];"
done

# 8. BEGIN CONCAT
for (( c=1; c<${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}overlaid][stream$((c+1))blended]"
done

# 9. END CONCAT
FULL_SCRIPT+="[stream${IMAGE_COUNT}overlaid]concat=n=$((2*IMAGE_COUNT-1)):v=1:a=0,format=yuv420p[videowithoutobject];"

# 10. PREPARE SNOW FLAKE IMAGE INPUTS - NOTE THAT COUNT IS FIXED TO FIVE
for (( c=1; c<=5; c++ ))
do
    FULL_SCRIPT+="[${IMAGE_COUNT}:v]setpts=PTS-STARTPTS,scale=${SNOW_FLAKE_WIDTH}:${SNOW_FLAKE_HEIGHT},setsar=sar=1/1,rotate=PI/${c}+${SNOW_FLAKE_ROTATE_SPEED}*PI*t/${TRANSITION_DURATION}.$((c-1)):ow=hypot(iw\,ih):oh=ow:c=#00000000,trim=duration=${TOTAL_DURATION},select=lte(n\,${TOTAL_FRAME_COUNT})[flake${c}];"
done

# 11. OVERLAY SNOW FLAKES ON TOP OF SLIDESHOW
FULL_SCRIPT+="[videowithoutobject][flake1]overlay=y='mod(${SNOW_FLAKE_FALL_SPEED}*t/6*(main_h),main_h+2*overlay_h+10)-2*overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,random(1)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=${TOTAL_DURATION},select=lte(n\,${TOTAL_FRAME_COUNT})[videowith1flake];"
FULL_SCRIPT+="[videowith1flake][flake2]overlay=y='mod(${SNOW_FLAKE_FALL_SPEED}*t/4.2*(main_h),main_h+overlay_h+10)-overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,(main_w-overlay_w)/5+random(2)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=${TOTAL_DURATION},select=lte(n\,${TOTAL_FRAME_COUNT})[videowith2flakes];"
FULL_SCRIPT+="[videowith2flakes][flake3]overlay=y='mod(${SNOW_FLAKE_FALL_SPEED}*t/6*(main_h),main_h+8*overlay_h+10)-8*overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,2*(main_w-overlay_w)/5+random(3)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=${TOTAL_DURATION},select=lte(n\,${TOTAL_FRAME_COUNT})[videowith3flakes];"
FULL_SCRIPT+="[videowith3flakes][flake4]overlay=y='mod(${SNOW_FLAKE_FALL_SPEED}*t/4.5*(main_h),main_h+4*overlay_h+10)-4*overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,3*(main_w-overlay_w)/5+random(4)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=${TOTAL_DURATION},select=lte(n\,${TOTAL_FRAME_COUNT})[videowith4flakes];"
FULL_SCRIPT+="[videowith4flakes][flake5]overlay=y='mod(${SNOW_FLAKE_FALL_SPEED}*t/6*(main_h),main_h+6*overlay_h+10)-6*overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,4*(main_w-overlay_w)/5+random(5)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=${TOTAL_DURATION},select=lte(n\,${TOTAL_FRAME_COUNT}),format=yuv420p[video]\""

# 12. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../advanced_object_animation.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'

unset $IFS