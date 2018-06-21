#!/bin/bash
#
# ffmpeg video slideshow script for horizontal wipe in with vertical panning (21.06.2018)
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
-f lavfi -i nullsrc=s=640x360 \
-filter_complex "\
[0:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba,split=2[stream1out1][stream1out2];\
[1:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba,split=3[stream2out1][stream2out2][stream2out3];\
[2:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba,split=3[stream3out1][stream3out2][stream3out3];\
[3:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba,split=3[stream4out1][stream4out2][stream4out3];\
[4:v]setpts=PTS-STARTPTS,scale=640:-1,setsar=sar=1/1,format=rgba,split=2[stream5out1][stream5out2];\
[5:v][stream1out2]overlay=x=0:y=0:format=rgb,trim=duration=1,select=lte(n\,30)[stream1ending];\
[5:v][stream2out2]overlay=x=0:y=0:format=rgb,trim=duration=1,select=lte(n\,30)[stream2ending];\
[5:v][stream2out3]overlay=x=0:y=-(overlay_h-360):format=rgb,trim=duration=1,select=lte(n\,30)[stream2starting];\
[5:v][stream3out2]overlay=x=0:y=0:format=rgb,trim=duration=1,select=lte(n\,30)[stream3ending];\
[5:v][stream3out3]overlay=x=0:y=-(overlay_h-360):format=rgb,trim=duration=1,select=lte(n\,30)[stream3starting];\
[5:v][stream4out2]overlay=x=0:y=0:format=rgb,trim=duration=1,select=lte(n\,30)[stream4ending];\
[5:v][stream4out3]overlay=x=0:y=-(overlay_h-360):format=rgb,trim=duration=1,select=lte(n\,30)[stream4starting];\
[5:v][stream5out2]overlay=x=0:y=-(overlay_h-360):format=rgb,trim=duration=1,select=lte(n\,30)[stream5starting];\
[6:v][stream1ending]overlay=x='t/1*640':y=0,trim=duration=1,select=lte(n\,30)[stream1moving];\
[6:v][stream2ending]overlay=x='t/1*640':y=0,trim=duration=1,select=lte(n\,30)[stream2moving];\
[6:v][stream3ending]overlay=x='t/1*640':y=0,trim=duration=1,select=lte(n\,30)[stream3moving];\
[6:v][stream4ending]overlay=x='t/1*640':y=0,trim=duration=1,select=lte(n\,30)[stream4moving];\
[5:v][stream1out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=3,select=lte(n\,90)[stream1panning];\
[5:v][stream2out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=2,select=lte(n\,60)[stream2panning];\
[5:v][stream3out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=2,select=lte(n\,60)[stream3panning];\
[5:v][stream4out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=2,select=lte(n\,60)[stream4panning];\
[5:v][stream5out1]overlay=x=0:y='360-overlay_h+t/3*(overlay_h-360)':format=rgb,trim=duration=2,select=lte(n\,60)[stream5panning];\
[stream1moving][stream2starting]overlay=x='-w+t/1*640':y=0:shortest=1,trim=duration=1,select=lte(n\,30)[stream2blended];\
[stream2moving][stream3starting]overlay=x='-w+t/1*640':y=0:shortest=1,trim=duration=1,select=lte(n\,30)[stream3blended];\
[stream3moving][stream4starting]overlay=x='-w+t/1*640':y=0:shortest=1,trim=duration=1,select=lte(n\,30)[stream4blended];\
[stream4moving][stream5starting]overlay=x='-w+t/1*640':y=0:shortest=1,trim=duration=1,select=lte(n\,30)[stream5blended];\
[stream1panning][stream2blended][stream2panning][stream3blended][stream3panning][stream4blended][stream4panning][stream5blended][stream5panning]concat=n=9:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../advanced_wipe_in_horizontal_with_panning_vertical.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'