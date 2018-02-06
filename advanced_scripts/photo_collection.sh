#!/bin/bash
#
# ffmpeg video slideshow script for advanced photo collection v1 (01.10.2017)
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
-f lavfi -i color=black:s=1280x720 \
-filter_complex "\
[5:v]trim=duration=15[background];\
[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,pad=width=5120:height=720:x=(5120-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=3,setpts=PTS-STARTPTS[stream1];\
[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,pad=width=5120:height=720:x=(5120-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=6,setpts=PTS-STARTPTS[stream2];\
[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,pad=width=5120:height=720:x=(5120-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=9,setpts=PTS-STARTPTS[stream3];\
[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,pad=width=5120:height=720:x=(5120-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=12,setpts=PTS-STARTPTS[stream4];\
[4:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,pad=width=5120:height=720:x=(5120-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=15,setpts=PTS-STARTPTS[stream5];\
[stream1]rotate=if(gt(t\,1)\,25*PI/180\,2*PI*t+25*PI/180):ow=5120:c=#00000000,[background]overlay=x=if(gt(t\,1)\,(main_w-overlay_w)/2\,'1920-w+t/1*1280'):y=(main_h-overlay_h)/2[stream1collected];\
[stream2]rotate=if(between(t\,3\,4)\,2*PI*t-15*PI/180\,-15*PI/180):ow=5120:c=#00000000,[stream1collected]overlay=x=if(gt(t\,3)\,if(lt(t\,4)\,1920-w+(t-3)/1*1280\,(main_w-overlay_w)/2)\,-w):(main_h-overlay_h)/2[stream2collected];\
[stream3]rotate=if(between(t\,6\,7)\,2*PI*t+10*PI/180\,10*PI/180):ow=5120:c=#00000000,[stream2collected]overlay=x=if(gt(t\,6)\,if(lt(t\,7)\,1920-w+(t-6)/1*1280\,(main_w-overlay_w)/2)\,-w):y=(main_h-overlay_h)/2[stream3collected];\
[stream4]rotate=if(between(t\,9\,10)\,2*PI*t-5*PI/180\,-5*PI/180):ow=5120:c=#00000000,[stream3collected]overlay=x=if(gt(t\,9)\,if(lt(t\,10)\,1920-w+(t-9)/1*1280\,(main_w-overlay_w)/2)\,-w):y=(main_h-overlay_h)/2[stream4collected];\
[stream5]rotate=if(between(t\,12\,13)\,2*PI*t+20*PI/180\,+20*PI/180):ow=5120:c=#00000000,[stream4collected]overlay=x=if(gt(t\,12)\,if(lt(t\,13)\,1920-w+(t-12)/1*1280\,(main_w-overlay_w)/2)\,-w):y=(main_h-overlay_h)/2,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../advanced_photo_collection.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'