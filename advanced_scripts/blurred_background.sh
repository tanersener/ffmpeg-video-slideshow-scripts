#!/bin/bash
#
# ffmpeg video slideshow script with advanced blurred background v1 (01.10.2017)
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
-filter_complex "\
[0:v]scale=1280x720,setsar=sar=1/1,format=rgba,boxblur=100,setsar=sar=1/1[stream1blurred];\
[1:v]scale=1280x720,setsar=sar=1/1,format=rgba,boxblur=100,setsar=sar=1/1[stream2blurred];\
[2:v]scale=1280x720,setsar=sar=1/1,format=rgba,boxblur=100,setsar=sar=1/1[stream3blurred];\
[3:v]scale=1280x720,setsar=sar=1/1,format=rgba,boxblur=100,setsar=sar=1/1[stream4blurred];\
[4:v]scale=1280x720,setsar=sar=1/1,format=rgba,boxblur=100,setsar=sar=1/1[stream5blurred];\
[0:v]scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream1raw];\
[1:v]scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream2raw];\
[2:v]scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream3raw];\
[3:v]scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream4raw];\
[4:v]scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream5raw];\
[stream1blurred][stream1raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,split=2[stream1out1][stream1out2];\
[stream2blurred][stream2raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,split=2[stream2out1][stream2out2];\
[stream3blurred][stream3raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,split=2[stream3out1][stream3out2];\
[stream4blurred][stream4raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,split=2[stream4out1][stream4out2];\
[stream5blurred][stream5raw]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,setpts=PTS-STARTPTS,split=2[stream5out1][stream5out2];\
[stream1out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=3,select=lte(n\,90)[stream1overlaid];\
[stream1out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30)[stream1ending];\
[stream2out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=2,select=lte(n\,60)[stream2overlaid];\
[stream2out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=2[stream2starting][stream2ending];\
[stream3out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=2,select=lte(n\,60)[stream3overlaid];\
[stream3out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=2[stream3starting][stream3ending];\
[stream4out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=2,select=lte(n\,60)[stream4overlaid];\
[stream4out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=2[stream4starting][stream4ending];\
[stream5out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=2,select=lte(n\,60)[stream5overlaid];\
[stream5out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30)[stream5starting];\
[stream2starting][stream1ending]blend=all_expr='A*(if(gte(T,1),1,T/1))+B*(1-(if(gte(T,1),1,T/1)))',select=lte(n\,30)[stream2blended];\
[stream3starting][stream2ending]blend=all_expr='A*(if(gte(T,1),1,T/1))+B*(1-(if(gte(T,1),1,T/1)))',select=lte(n\,30)[stream3blended];\
[stream4starting][stream3ending]blend=all_expr='A*(if(gte(T,1),1,T/1))+B*(1-(if(gte(T,1),1,T/1)))',select=lte(n\,30)[stream4blended];\
[stream5starting][stream4ending]blend=all_expr='A*(if(gte(T,1),1,T/1))+B*(1-(if(gte(T,1),1,T/1)))',select=lte(n\,30)[stream5blended];\
[stream1overlaid][stream2blended][stream2overlaid][stream3blended][stream3overlaid][stream4blended][stream4overlaid][stream5blended][stream5overlaid]concat=n=9:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../advanced_blurred_background.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'