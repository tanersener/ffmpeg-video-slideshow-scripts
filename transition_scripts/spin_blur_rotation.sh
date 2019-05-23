#!/bin/bash
#
# ffmpeg video slideshow script with spin blur rotation transition v2 (05.12.2018)
#
# Copyright (c) 2018, Taner Sener (https://github.com/tanersener)
#
# This work is licensed under the terms of the MIT license. For a copy, see <https://opensource.org/licenses/MIT>.
#

# SCRIPT OPTIONS - CAN BE MODIFIED
WIDTH=1280
HEIGHT=720
FPS=30
PHOTO_DURATION=2

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
TRANSITION_FRAME_COUNT=$(( 1*FPS ))
PHOTO_FRAME_COUNT=$(( PHOTO_DURATION*FPS ))
TOTAL_DURATION=$(( (PHOTO_DURATION+1)*PHOTOS_COUNT - 1 ))
TOTAL_FRAME_COUNT=$(( TOTAL_DURATION*FPS ))

echo -e "\nVideo Slideshow Info\n------------------------\nPhoto count: ${PHOTOS_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: ${FPS}\nPhoto duration: ${PHOTO_DURATION} s\n\
Transition duration: 1 s\nTotal duration: ${TOTAL_DURATION} s\n"

START_TIME=$SECONDS

# 1. START COMMAND
FULL_SCRIPT="ffmpeg -y "

# 2. ADD INPUTS
for photo in ${PHOTOS}; do
    FULL_SCRIPT+="-loop 1 -i '${photo}' "
done

# 3. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 4. PREPARING SCALED INPUTS
for (( c=0; c<${PHOTOS_COUNT}; c++ ))
do
    if [[ $((c+1)) -eq 1 ]] || [[ $((c+1)) -eq ${PHOTOS_COUNT} ]]; then
        FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,fps=${FPS},format=rgba,trim=duration=$(( PHOTO_DURATION+1 )),crop=${WIDTH}:${HEIGHT},split=2[stream$((c+1))][stream$((c+1))sample];"
    else
        FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,fps=${FPS},format=rgba,trim=duration=$(( PHOTO_DURATION+1 )),crop=${WIDTH}:${HEIGHT},split=3[stream$((c+1))][stream$((c+1))sample][stream$((c+1))sample2];"
    fi
done

# 5. ROTATING & BLURRING
for (( c=2; c<=${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}sample]rotate=PI,split=2[stream${c}rotate_in_background][stream${c}pre_rotate_in];"
    FULL_SCRIPT+="[stream${c}pre_rotate_in]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.6:c=none[stream${c}rotate_in];"
done

# 6. CREATING TRANSITION FRAMES
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
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
for (( c=1; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}][transition${c}part1][transition${c}part2]"
done

# 8. END CONCAT
FULL_SCRIPT+="[stream${PHOTOS_COUNT}]concat=n=$((3*PHOTOS_COUNT-2)):v=1:a=0,format=yuv420p[video]\""

# 9. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../transition_spin_blur_rotation.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'

unset $IFS