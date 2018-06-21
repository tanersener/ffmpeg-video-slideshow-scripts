#!/bin/bash
#
# ffmpeg video slideshow script with vertical panning option for photos (21.06.2018)
#
# Copyright (c) 2018, Taner Sener (https://github.com/tanersener)
#
# This work is licensed under the terms of the MIT license. For a copy, see <https://opensource.org/licenses/MIT>.
#

START_TIME=$SECONDS

ffmpeg -y \
-loop 1 -i ../photos/1.jpg \
-loop 1 -i ../photos/2.jpg \
-loop 1 -i ../photos/3.jpg \
-loop 1 -i ../photos/4.jpg \
-loop 1 -i ../photos/5.jpg \
-f lavfi -i color=black:s=640x360 \
-filter_complex "\
[0:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba[stream1out1];\
[1:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba[stream2out1];\
[2:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba[stream3out1];\
[3:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba[stream4out1];\
[4:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba[stream5out1];\
[5:v][stream1out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=3,select=lte(n\,90)[stream1panning];\
[5:v][stream2out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=3,select=lte(n\,90)[stream2panning];\
[5:v][stream3out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=3,select=lte(n\,90)[stream3panning];\
[5:v][stream4out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=3,select=lte(n\,90)[stream4panning];\
[5:v][stream5out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=3,select=lte(n\,90)[stream5panning];\
[stream1panning][stream2panning][stream3panning][stream4panning][stream5panning]concat=n=5:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../display_options_panning_vertical.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'