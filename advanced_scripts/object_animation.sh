#!/bin/bash
#
# ffmpeg video slideshow script with advanced object animation (formerly object move) v3 (02.12.2018)
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
SNOW_FLAKE_WIDTH=52
SNOW_FLAKE_HEIGHT=60
SNOW_FLAKE_ROTATE_SPEED=3                   # 1=FASTEST, 2=FASTER, 3=MODERATE, 4=SLOW, 5=SLOWEST
SNOW_FLAKE_FALL_SPEED=3                     # 1=FASTEST, 2=FASTER, 3=MODERATE, 4=SLOW, 5=SLOWEST
BACKGROUND_COLOR="#00000000"

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

# 3. ADD SNOW FLAKE PHOTO INPUT
FULL_SCRIPT+="-loop 1 -i ../objects/snow-flake.png "

# 4. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 5. PREPARING SCALED INPUTS
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

# 6. APPLYING PADDING
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

# 7. CREATING TRANSITION FRAMES
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream$((c+1))starting][stream${c}ending]blend=all_expr='A*(if(gte(T,${TRANSITION_DURATION}),${TRANSITION_DURATION},T/${TRANSITION_DURATION}))+B*(1-(if(gte(T,${TRANSITION_DURATION}),${TRANSITION_DURATION},T/${TRANSITION_DURATION})))',select=lte(n\,${TRANSITION_FRAME_COUNT})[stream$((c+1))blended];"
done

# 8. BEGIN CONCAT
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}overlaid][stream$((c+1))blended]"
done

# 9. END CONCAT
FULL_SCRIPT+="[stream${PHOTOS_COUNT}overlaid]concat=n=$((2*PHOTOS_COUNT-1)):v=1:a=0,format=yuv420p[videowithoutobject];"

# 10. PREPARE SNOW FLAKE PHOTO INPUTS - NOTE THAT COUNT IS FIXED TO FIVE
for (( c=1; c<=5; c++ ))
do
    FULL_SCRIPT+="[${PHOTOS_COUNT}:v]setpts=PTS-STARTPTS,scale=${SNOW_FLAKE_WIDTH}:${SNOW_FLAKE_HEIGHT},setsar=sar=1/1,rotate=PI/${c}+${SNOW_FLAKE_ROTATE_SPEED}*PI*t/${TRANSITION_DURATION}.$((c-1)):ow=hypot(iw\,ih):oh=ow:c=#00000000,trim=duration=${TOTAL_DURATION},select=lte(n\,${TOTAL_FRAME_COUNT})[flake${c}];"
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