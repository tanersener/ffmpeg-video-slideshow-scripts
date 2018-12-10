#!/bin/bash
#
# ffmpeg video slideshow script with advanced push vertical film v4 (10.12.2018)
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
PHOTO_MODE=2                # 1=CENTER, 2=CROP, 3=SCALE, 4=BLUR
BACKGROUND_COLOR="#00000000"
DIRECTION=1                 # 1=TOP TO BOTTOM, 2=BOTTOM TO TOP

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
TOTAL_DURATION=$(( (TRANSITION_DURATION)*PHOTOS_COUNT + TRANSITION_DURATION ))
TOTAL_FRAME_COUNT=$(( TOTAL_DURATION*FPS ))

echo -e "\nVideo Slideshow Info\n------------------------\nPhoto count: ${PHOTOS_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: 30\nTransition duration: ${TRANSITION_DURATION} s\n\
Total duration: ${TOTAL_DURATION} s\n"

START_TIME=$SECONDS

# 1. START COMMAND
FULL_SCRIPT="ffmpeg -y "

# 2. ADD INPUTS
for photo in ${PHOTOS}; do
    FULL_SCRIPT+="-loop 1 -i ${photo} "
done

# 3. ADD FILM STRIP PHOTO INPUT
FULL_SCRIPT+="-loop 1 -i ../objects/film_strip_vertical.png "

# 4. ADD BACKGROUND COLOR SCREEN INPUT
FULL_SCRIPT+="-f lavfi -i color=${BACKGROUND_COLOR}:s=${WIDTH}x${HEIGHT} "

# 5. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 6. PREPARING SCALED INPUTS
for (( c=0; c<${PHOTOS_COUNT}; c++ ))
do
    case ${PHOTO_MODE} in
        1)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=${WIDTH}:height=${HEIGHT}:x=(${WIDTH}-iw)/2:y=(${HEIGHT}-ih)/2:color=#00000000,setsar=sar=1/1[stream$((c+1))];"
        ;;
        2)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',crop=${WIDTH}:${HEIGHT},setsar=sar=1/1[stream$((c+1))];"
        ;;
        3)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=${WIDTH}:${HEIGHT},setsar=sar=1/1[stream$((c+1))];"
        ;;
        4)
            FULL_SCRIPT+="[${c}:v]scale=${WIDTH}x${HEIGHT},setsar=sar=1/1,format=rgba,boxblur=100,setsar=sar=1/1[stream${c}blurred];"
            FULL_SCRIPT+="[${c}:v]scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream${c}raw];"
            FULL_SCRIPT+="[stream${c}blurred][stream${c}raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,setsar=sar=1/1[stream$((c+1))];"
        ;;
    esac
done

# 7. PREPARING FILM STRIP PHOTO
FULL_SCRIPT+="[${PHOTOS_COUNT}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=${PHOTOS_COUNT}"

for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[frame${c}]"
done

FULL_SCRIPT+=";"

# 8. OVERLAY FILM STRIP ON TOP OF INPUTS
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do

    # NOTE THAT threads=1 is a workaround for ffmpeg v4.1

    FULL_SCRIPT+="[stream${c}][frame${c}]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:threads=1:format=rgb,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT}),split=2[stream${c}starting][stream${c}ending];"

    case ${DIRECTION} in
        1)
            FULL_SCRIPT+="[$(( PHOTOS_COUNT+1 )):v][stream${c}ending]overlay=y='t/${TRANSITION_DURATION}*${HEIGHT}':x=0:threads=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}moving];"

            if [[ ${c} -eq 1 ]]; then
                FULL_SCRIPT+="[$(( PHOTOS_COUNT+1 )):v]"
            else
                FULL_SCRIPT+="[stream$(( c-1 ))moving]"
            fi

            FULL_SCRIPT+="[stream${c}starting]overlay=y='-h+t/${TRANSITION_DURATION}*${HEIGHT}':x=0:shortest=1:threads=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}blended];"
        ;;
        *)
            FULL_SCRIPT+="[$(( PHOTOS_COUNT+1 )):v][stream${c}ending]overlay=y='-t/${TRANSITION_DURATION}*${HEIGHT}':x=0:threads=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}moving];"

            if [[ ${c} -eq 1 ]]; then
                FULL_SCRIPT+="[$(( PHOTOS_COUNT+1 )):v]"
            else
                FULL_SCRIPT+="[stream$(( c-1 ))moving]"
            fi

            FULL_SCRIPT+="[stream${c}starting]overlay=y='h-t/${TRANSITION_DURATION}*${HEIGHT}':x=0:shortest=1:threads=1,trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT})[stream${c}blended];"
        ;;
    esac
done

# 9. BEGIN CONCAT
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}blended]"
done

# 10. END CONCAT
FULL_SCRIPT+="[stream${PHOTOS_COUNT}moving]concat=n=$((PHOTOS_COUNT+1)):v=1:a=0,format=yuv420p[video]\""

# 11. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../advanced_push_vertical_film.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'