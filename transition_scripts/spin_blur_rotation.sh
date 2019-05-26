#!/bin/bash
#
# ffmpeg video slideshow script with spin blur rotation transition v3 (25.05.2019)
#
# Copyright (c) 2018-2019, Taner Sener (https://github.com/tanersener)
#
# This work is licensed under the terms of the MIT license. For a copy, see <https://opensource.org/licenses/MIT>.
#

# SCRIPT OPTIONS - CAN BE MODIFIED
WIDTH=1280
HEIGHT=720
FPS=30
IMAGE_DURATION=2

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
TRANSITION_FRAME_COUNT=$(( 1*FPS ))
IMAGE_FRAME_COUNT=$(( IMAGE_DURATION*FPS ))
TOTAL_DURATION=$(( (IMAGE_DURATION+1)*IMAGE_COUNT - 1 ))
TOTAL_FRAME_COUNT=$(( TOTAL_DURATION*FPS ))

echo -e "\nVideo Slideshow Info\n------------------------\nImage count: ${IMAGE_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: ${FPS}\nImage duration: ${IMAGE_DURATION} s\n\
Transition duration: 1 s\nTotal duration: ${TOTAL_DURATION} s\n"

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
    if [[ $((c+1)) -eq 1 ]] || [[ $((c+1)) -eq ${IMAGE_COUNT} ]]; then
        FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,fps=${FPS},format=rgba,trim=duration=$(( IMAGE_DURATION+1 )),crop=${WIDTH}:${HEIGHT},split=2[stream$((c+1))][stream$((c+1))sample];"
    else
        FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,fps=${FPS},format=rgba,trim=duration=$(( IMAGE_DURATION+1 )),crop=${WIDTH}:${HEIGHT},split=3[stream$((c+1))][stream$((c+1))sample][stream$((c+1))sample2];"
    fi
done

# 5. ROTATE & BLUR
for (( c=2; c<=${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}sample]rotate=PI,split=2[stream${c}rotate_in_background][stream${c}pre_rotate_in];"
    FULL_SCRIPT+="[stream${c}pre_rotate_in]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.6:c=none[stream${c}rotate_in];"
done

# 6. CREATE TRANSITION FRAMES
for (( c=1; c<${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}pre_rotate_out]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.4:c=none[stream${c}rotate_out];"

    if [[ ${c} -eq 1 ]]; then
        FULL_SCRIPT+="[stream${c}sample]split=2[stream${c}rotate_out_background][stream${c}pre_rotate_out];"
    else
        FULL_SCRIPT+="[stream${c}sample2]split=2[stream${c}rotate_out_background][stream${c}pre_rotate_out];"
    fi

    FULL_SCRIPT+="[stream${c}rotate_out_background][stream${c}rotate_out]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=${WIDTH}:${HEIGHT},trim=duration=0.2[transition${c}part1];"

    FULL_SCRIPT+="[stream$((c+1))rotate_in_background][stream$((c+1))rotate_in]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=${WIDTH}:${HEIGHT},trim=duration=0.3[transition${c}part2];"

done

# 7. BEGIN CONCAT
for (( c=1; c<${IMAGE_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}][transition${c}part1][transition${c}part2]"
done

# 8. END CONCAT
FULL_SCRIPT+="[stream${IMAGE_COUNT}]concat=n=$((3*IMAGE_COUNT-2)):v=1:a=0,format=yuv420p[video]\""

# 9. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../transition_spin_blur_rotation.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'

unset $IFS