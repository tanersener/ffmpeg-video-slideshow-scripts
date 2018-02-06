#!/bin/bash
#
# ffmpeg video slideshow script with advanced push vertical film v1 (01.10.2017)
#
# Copyright (c) 2017, Taner Sener (https://github.com/tanersener)
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
-loop 1 -i ../objects/film_strip_vertical.png \
-f lavfi -i color=black:s=1280x720 \
-filter_complex "\
[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,setsar=sar=1/1[stream1];\
[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,setsar=sar=1/1[stream2];\
[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,setsar=sar=1/1[stream3];\
[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,setsar=sar=1/1[stream4];\
[4:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,setsar=sar=1/1[stream5];\
[5:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=5[frame1][frame2][frame3][frame4][frame5];\
[stream1][frame1]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,trim=duration=2,select=lte(n\,60),split=2[stream1starting][stream1ending];\
[stream2][frame2]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,trim=duration=2,select=lte(n\,60),split=2[stream2starting][stream2ending];\
[stream3][frame3]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,trim=duration=2,select=lte(n\,60),split=2[stream3starting][stream3ending];\
[stream4][frame4]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,trim=duration=2,select=lte(n\,60),split=2[stream4starting][stream4ending];\
[stream5][frame5]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,trim=duration=2,select=lte(n\,60),split=2[stream5starting][stream5ending];\
[6:v][stream1ending]overlay=y='t/2*(720/1)':x=0,trim=duration=2,select=lte(n\,60)[stream1moving];\
[6:v][stream2ending]overlay=y='t/2*(720/1)':x=0,trim=duration=2,select=lte(n\,60)[stream2moving];\
[6:v][stream3ending]overlay=y='t/2*(720/1)':x=0,trim=duration=2,select=lte(n\,60)[stream3moving];\
[6:v][stream4ending]overlay=y='t/2*(720/1)':x=0,trim=duration=2,select=lte(n\,60)[stream4moving];\
[6:v][stream5ending]overlay=y='t/2*(720/1)':x=0,trim=duration=2,select=lte(n\,60)[stream5moving];\
[6:v][stream1starting]overlay=y='-h+t/2*(720/1)':x=0:shortest=1,trim=duration=2,select=lte(n\,60)[stream1blended];\
[stream1moving][stream2starting]overlay=y='-h+t/2*(720/1)':x=0:shortest=1,trim=duration=2,select=lte(n\,60)[stream2blended];\
[stream2moving][stream3starting]overlay=y='-h+t/2*(720/1)':x=0:shortest=1,trim=duration=2,select=lte(n\,60)[stream3blended];\
[stream3moving][stream4starting]overlay=y='-h+t/2*(720/1)':x=0:shortest=1,trim=duration=2,select=lte(n\,60)[stream4blended];\
[stream4moving][stream5starting]overlay=y='-h+t/2*(720/1)':x=0:shortest=1,trim=duration=2,select=lte(n\,60)[stream5blended];\
[stream1blended][stream2blended][stream3blended][stream4blended][stream5blended][stream5moving]concat=n=6:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../advanced_push_vertical_film.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'