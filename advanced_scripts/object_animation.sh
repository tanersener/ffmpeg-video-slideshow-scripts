#!/bin/bash
#
# ffmpeg video slideshow script with advanced object animation (formerly object move) v2 (27.06.2018)
#
# Copyright (c) 2017-2018, Taner Sener (https://github.com/tanersener)
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
-loop 1 -i ../objects/snow-flake.png \
-filter_complex "\
[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream1out1][stream1out2];\
[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream2out1][stream2out2];\
[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream3out1][stream3out2];\
[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream4out1][stream4out2];\
[4:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream5out1][stream5out2];\
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
[stream1overlaid][stream2blended][stream2overlaid][stream3blended][stream3overlaid][stream4blended][stream4overlaid][stream5blended][stream5overlaid]concat=n=9:v=1:a=0[videowithoutobject];\
[5:v]setpts=PTS-STARTPTS,scale=64:-1,setsar=sar=1/1,rotate=PI/1+3*PI*t/1:ow=hypot(iw\,ih):oh=ow:c=#00000000,trim=duration=15,select=lte(n\,450)[flake1];\
[5:v]setpts=PTS-STARTPTS,scale=64:-1,setsar=sar=1/1,rotate=PI/2+4*PI*t/1.8:ow=hypot(iw\,ih):oh=ow:c=#00000000,trim=duration=15,select=lte(n\,450)[flake2];\
[5:v]setpts=PTS-STARTPTS,scale=64:-1,setsar=sar=1/1,rotate=PI/3+3*PI*t/1.5:ow=hypot(iw\,ih):oh=ow:c=#00000000,trim=duration=15,select=lte(n\,450)[flake3];\
[5:v]setpts=PTS-STARTPTS,scale=64:-1,setsar=sar=1/1,rotate=PI/4+4*PI*t/1.5:ow=hypot(iw\,ih):oh=ow:c=#00000000,trim=duration=15,select=lte(n\,450)[flake4];\
[5:v]setpts=PTS-STARTPTS,scale=64:-1,setsar=sar=1/1,rotate=PI/5+4*PI*t/1.6:ow=hypot(iw\,ih):oh=ow:c=#00000000,trim=duration=15,select=lte(n\,450)[flake5];\
[videowithoutobject][flake1]overlay=y='mod(t/2*(main_h),main_h+2*overlay_h+10)-2*overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,random(1)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=15,select=lte(n\,450)[videowith1flake];\
[videowith1flake][flake2]overlay=y='mod(t/1.4*(main_h),main_h+overlay_h+10)-overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,(main_w-overlay_w)/5+random(2)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=15,select=lte(n\,450)[videowith2flakes];\
[videowith2flakes][flake3]overlay=y='mod(t/2*(main_h),main_h+8*overlay_h+10)-8*overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,2*(main_w-overlay_w)/5+random(3)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=15,select=lte(n\,450)[videowith3flakes];\
[videowith3flakes][flake4]overlay=y='mod(t/1.5*(main_h),main_h+4*overlay_h+10)-4*overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,3*(main_w-overlay_w)/5+random(4)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=15,select=lte(n\,450)[videowith4flakes];\
[videowith4flakes][flake5]overlay=y='mod(t/2*(main_h),main_h+6*overlay_h+10)-6*overlay_h':x='if(not(between(y\,0-overlay_h\,main_h))\,4*(main_w-overlay_w)/5+random(5)*((main_w-overlay_w)/5)\,x)':format=rgb,trim=duration=15,select=lte(n\,450),format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../advanced_object_animation.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'