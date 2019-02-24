#!/bin/bash
#
# ffmpeg video slideshow script with advanced horizontal push box v3 (10.12.2018)
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
DIRECTION=1                 # 1=LEFT TO RIGHT, 2=RIGHT TO LEFT

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
TOTAL_DURATION=$(( (PHOTO_DURATION+2*TRANSITION_DURATION)*PHOTOS_COUNT + (TRANSITION_DURATION*2*PHOTOS_COUNT/5) ))
TOTAL_FRAME_COUNT=$(( TOTAL_DURATION*FPS ))
if [[ $(( ((TRANSITION_DURATION*1000)/2)%1000 )) -eq 0 ]]; then
    TRANSITION_PHASE_DURATION="$((TRANSITION_DURATION/2)).0"
else
    TRANSITION_PHASE_DURATION="$((TRANSITION_DURATION/2)).$(( ((TRANSITION_DURATION*1000)/2)%1000 ))"
fi
if [[ $(( ((TRANSITION_DURATION*1000)/5)%1000 )) -eq 0 ]]; then
    CHECKPOINT_DURATION="$((TRANSITION_DURATION/5)).0"
else
    CHECKPOINT_DURATION="$((TRANSITION_DURATION/5)).$(( ((TRANSITION_DURATION*1000)/5)%1000 ))"
fi

echo -e "\nVideo Slideshow Info\n------------------------\nPhoto count: ${PHOTOS_COUNT}\nDimension: ${WIDTH}x${HEIGHT}\nFPS: 30\nPhoto duration: ${PHOTO_DURATION} s\n\
Transition duration: ${TRANSITION_DURATION} s\nTotal duration: ${TOTAL_DURATION} s\n"

START_TIME=$SECONDS

# 1. START COMMAND
FULL_SCRIPT="ffmpeg -y "

# 2. ADD INPUTS
for photo in ${PHOTOS}; do
    FULL_SCRIPT+="-loop 1 -i ${photo} "
done

# 3. ADD BACKGROUND COLOR SCREEN INPUT
FULL_SCRIPT+="-f lavfi -i color=${BACKGROUND_COLOR}:s=${WIDTH}x${HEIGHT} "

# 4. START FILTER COMPLEX
FULL_SCRIPT+="-filter_complex \""

# 5. PREPARING SCALED INPUTS
for (( c=0; c<${PHOTOS_COUNT}; c++ ))
do
    case ${PHOTO_MODE} in
        1)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=${WIDTH}:height=${HEIGHT}:x=(ow-iw)/2:y=(oh-ih)/2:color=${BACKGROUND_COLOR},setsar=sar=1/1,format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        2)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,${WIDTH})':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),${HEIGHT},-1)',[${PHOTOS_COUNT}:v]overlay,crop=${WIDTH}:${HEIGHT},setsar=sar=1/1,format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        3)
            FULL_SCRIPT+="[${c}:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=${WIDTH}:${HEIGHT},setsar=sar=1/1,format=rgba,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
        4)
            FULL_SCRIPT+="[${c}:v]scale=${WIDTH}x${HEIGHT},setsar=sar=1/1,format=rgba,boxblur=100,setsar=sar=1/1[stream${c}blurred];"
            FULL_SCRIPT+="[${c}:v]scale=w='if(gte(iw/ih,${WIDTH}/${HEIGHT}),min(iw,${WIDTH}),-1)':h='if(gte(iw/ih,${WIDTH}/${HEIGHT}),-1,min(ih,${HEIGHT}))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream${c}raw];"
            FULL_SCRIPT+="[stream${c}blurred][stream${c}raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,split=2[stream$((c+1))out1][stream$((c+1))out2];"
        ;;
    esac

    FULL_SCRIPT+="[stream$((c+1))out1]trim=duration=${PHOTO_DURATION},select=lte(n\,${PHOTO_FRAME_COUNT})[stream$((c+1))overlaid];"

    FULL_SCRIPT+="[stream$((c+1))out2]scale=w=${WIDTH}/2:-1,pad=width=${WIDTH}:height=${HEIGHT}:x=(ow-iw)/2:y=(oh-ih)/2:color=${BACKGROUND_COLOR},
    trim=duration=${TRANSITION_DURATION},select=lte(n\,${TRANSITION_FRAME_COUNT}),split=5[stream$((c+1))prephasein][stream$((c+1))checkpoint][stream$((c+1))prezoomin][stream$((c+1))prezoomout][stream$((c+1))prephaseout];"
done

# 6. OVERLAY INPUTS ON TOP OF BACKGROUND COLOR SCREEN
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do
    case ${DIRECTION} in
        1)
            FULL_SCRIPT+="[${PHOTOS_COUNT}:v][stream${c}prephaseout]overlay=x='t/(${TRANSITION_DURATION}/2)*${WIDTH}':y=0,trim=duration=${TRANSITION_PHASE_DURATION},select=lte(n\,(${TRANSITION_FRAME_COUNT}/2))[stream${c}phaseout];"

            if [[ ${c} -eq 1 ]]; then
                FIRST_STREAM="[${PHOTOS_COUNT}:v]"
            else
                FIRST_STREAM="[stream$((c-1))phaseout]"
            fi

            FULL_SCRIPT+="${FIRST_STREAM}[stream${c}prephasein]overlay=x='-${WIDTH}+${WIDTH}*t/(${TRANSITION_DURATION}/2)':y=0,trim=duration=${TRANSITION_PHASE_DURATION},select=lte(n\,(${TRANSITION_FRAME_COUNT}/2))[stream${c}phasein];"
        ;;
        *)
            FULL_SCRIPT+="[${PHOTOS_COUNT}:v][stream${c}prephaseout]overlay=x='-t/(${TRANSITION_DURATION}/2)*${WIDTH}':y=0,trim=duration=${TRANSITION_PHASE_DURATION},select=lte(n\,(${TRANSITION_FRAME_COUNT}/2))[stream${c}phaseout];"

            if [[ ${c} -eq 1 ]]; then
                FIRST_STREAM="[${PHOTOS_COUNT}:v]"
            else
                FIRST_STREAM="[stream$((c-1))phaseout]"
            fi

            FULL_SCRIPT+="${FIRST_STREAM}[stream${c}prephasein]overlay=x='${WIDTH}-${WIDTH}*t/(${TRANSITION_DURATION}/2)':y=0,trim=duration=${TRANSITION_PHASE_DURATION},select=lte(n\,(${TRANSITION_FRAME_COUNT}/2))[stream${c}phasein];"
        ;;
    esac

    FULL_SCRIPT+="[stream${c}checkpoint]trim=duration=${CHECKPOINT_DURATION},split=2[stream${c}checkin][stream${c}checkout];"
done

# 7. CREATING TRANSITIONS 1
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}prezoomin]scale=iw*5:ih*5,zoompan=z='min(pzoom+0.04,2)':d=${TRANSITION_DURATION}:fps=${FPS}:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=${WIDTH}x${HEIGHT},setpts=0.5*PTS[stream${c}zoomin];"
done

# 8. CREATING TRANSITIONS 2
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}prezoomout]scale=iw*5:ih*5,zoompan=z='2-in*0.04':d=${TRANSITION_DURATION}:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=${WIDTH}x${HEIGHT},setpts=0.5*PTS[stream${c}zoomout];"
done

# 9. BEGIN CONCAT
for (( c=1; c<=${PHOTOS_COUNT}; c++ ))
do
    FULL_SCRIPT+="[stream${c}phasein][stream${c}checkin][stream${c}zoomin][stream${c}overlaid][stream${c}zoomout][stream${c}checkout]"
done

# 10. END CONCAT
FULL_SCRIPT+="[stream${PHOTOS_COUNT}phaseout]concat=n=$(( 6*PHOTOS_COUNT+1 )):v=1:a=0,format=yuv420p[video]\""

# 11. END
FULL_SCRIPT+=" -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r ${FPS} ../advanced_push_box_horizontal.mp4"

eval ${FULL_SCRIPT}

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo -e '\nSlideshow created in '$ELAPSED_TIME' seconds\n'