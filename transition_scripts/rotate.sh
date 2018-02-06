#!/bin/bash
#
# ffmpeg video slideshow script with rotate transition v1 (01.10.2017)
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
[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream1];\
[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream2];\
[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream3];\
[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream4];\
[4:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba[stream5];\
[stream1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=4[stream1out1][stream1out2][stream1out3][stream1out4];\
[stream2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=4[stream2out1][stream2out2][stream2out3][stream2out4];\
[stream3]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=4[stream3out1][stream3out2][stream3out3][stream3out4];\
[stream4]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=4[stream4out1][stream4out2][stream4out3][stream4out4];\
[stream5]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=3[stream5out1][stream5out2][stream5out3];\
[stream1out1]rotate=2*PI*t:ow=5120:c=#00000000,[5:v]overlay=x='1920-w+t/1*1280':y=0,trim=duration=1,select=lte(n\,30)[stream1rotating];\
[stream2out1]rotate=2*PI*t:ow=5120:c=#00000000,[stream1out2]overlay=x='1920-w+t/1*1280':y=0,trim=duration=1,select=lte(n\,30)[stream2rotating];\
[stream3out1]rotate=2*PI*t:ow=5120:c=#00000000,[stream2out2]overlay=x='1920-w+t/1*1280':y=0,trim=duration=1,select=lte(n\,30)[stream3rotating];\
[stream4out1]rotate=2*PI*t:ow=5120:c=#00000000,[stream3out2]overlay=x='1920-w+t/1*1280':y=0,trim=duration=1,select=lte(n\,30)[stream4rotating];\
[stream5out1]rotate=2*PI*t:ow=5120:c=#00000000,[stream4out2]overlay=x='1920-w+t/1*1280':y=0,trim=duration=1,select=lte(n\,30)[stream5rotating];\
[stream1rotating][stream1out3][stream1out4][stream2rotating][stream2out3][stream2out4][stream3rotating][stream3out3][stream3out4][stream4rotating][stream4out3][stream4out4][stream5rotating][stream5out2][stream5out3]concat=n=15:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../transition_rotate.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'