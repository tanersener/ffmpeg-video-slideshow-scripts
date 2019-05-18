#!/bin/bash
#
# ffmpeg video slideshow script with zoom in and pan and fade in/out #1 transition v3 (12.04.2019)
#
# Copyright (c) 2018, Taner Sener (https://github.com/tanersener)
#
# This work is licensed under the terms of the MIT license. For a copy, see <https://opensource.org/licenses/MIT>.
#

# SCRIPT OPTIONS - CAN BE MODIFIED
WIDTH=1280
HEIGHT=720
FPS=30
TRANSITION_DURATION=1
PHOTO_DURATION=2
ZOOM_SPEED=2                # 1=SLOWEST, 2=SLOW, 3=MODERATE, 4=FASTER, 5=FASTEST, ...

IFS=$'\t\n'                 # NECESSARY TO SUPPORT SPACE IN FILE NAMES

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
TOTAL_DURATION=$(( (PHOTO_DURATION+2*TRANSITION_DURATION)*PHOTOS_COUNT ))
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

# 3. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 4. PREPARING SCALED INPUTS & FADE IN/OUT PARTS
for (( c=0; c<${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',crop=${WIDTH}:${HEIGHT},setsar=sar=1/1,format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"

    FULL_SCRIPT+="[stream$((c+1))out1]trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT}),split=2[stream$((c+1))in][stream$((c+1))out];"
    FULL_SCRIPT+="[stream$((c+1))out2]trim=duration=${PHOTO_DURATION},select=lte(n\,${PHOTO_FRAME_COUNT})[stream$((c+1))];"

    FULL_SCRIPT+="[stream$((c+1))in]fade=t=in:s=0:n=${TRANSITION_FRAME_COUNT}[stream$((c+1))fadein];"
    FULL_SCRIPT+="[stream$((c+1))out]fade=t=out:s=0:n=${TRANSITION_FRAME_COUNT}[stream$((c+1))fadeout];"
done

# 5. ZOOM & PAN EACH STREAM
for (( c=0; c<${PHOTOS_COUNT}; c++ ))
do

    POSITION_NUMBER=$((RANDOM % 5));

    case ${POSITION_NUMBER} in
        0)
            POSITION_FORMULA="x='iw/2-(iw/zoom/2)':y=0"
        ;;
        1)
            POSITION_FORMULA="x='iw/2':y='(ih/zoom/2)'"
        ;;
        2)
            POSITION_FORMULA="x='${WIDTH}-(iw/zoom/2)':y='-${HEIGHT}-(ih/zoom/2)'"
        ;;
        3)
            POSITION_FORMULA="x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)'"
        ;;
        4)
            POSITION_FORMULA="x='-(iw/zoom/2)':y='ih/2-${HEIGHT}'"
        ;;
    esac

    FULL_SCRIPT+="[stream$((c+1))fadein][stream$((c+1))][stream$((c+1))fadeout]concat=n=3:v=1:a=0,scale=${WIDTH}*5:-1,zoompan=z='min(pzoom+0.001*${ZOOM_SPEED},2)':d=1:${POSITION_FORMULA}:fps=${FPS}:s=${WIDTH}x${HEIGHT}[stream$((c+1))panning];"
done

# 6. BEGIN CONCAT
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}panning]"
done

# 7. END CONCAT
FULL_SCRIPT+="concat=n=${PHOTOS_COUNT}:v=1:a=0,format=yuv420p[video]\""

# 8. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../advanced_zoom_in_and_pan_with_fade_in_out_one.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'

unset $IFS