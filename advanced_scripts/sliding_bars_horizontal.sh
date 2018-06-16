#!/bin/bash
#
# ffmpeg video slideshow script with advanced horizontal sliding bars v1 (16.06.2018)
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
-filter_complex "\
[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream1out1][stream1out2];\
[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream2out1][stream2out2];\
[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream3out1][stream3out2];\
[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream4out1][stream4out2];\
[4:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,split=2[stream5out1][stream5out2];\
[stream1out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=3,select=lte(n\,90)[stream1overlaid];\
[stream1out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=1,select=lte(n\,30)[stream1ending];\
[stream2out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=2,select=lte(n\,60)[stream2overlaid];\
[stream2out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=1,select=lte(n\,30),split=2[stream2starting][stream2ending];\
[stream3out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=2,select=lte(n\,60)[stream3overlaid];\
[stream3out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=1,select=lte(n\,30),split=2[stream3starting][stream3ending];\
[stream4out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=2,select=lte(n\,60)[stream4overlaid];\
[stream4out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=1,select=lte(n\,30),split=2[stream4starting][stream4ending];\
[stream5out1]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=2,select=lte(n\,60)[stream5overlaid];\
[stream5out2]pad=width=1280:height=720:x=(1280-iw)/2:y=(720-ih)/2,trim=duration=1,select=lte(n\,30)[stream5starting];\
[stream2starting]split=5[stream2starting1][stream2starting2][stream2starting3][stream2starting4][stream2starting5];\
[stream3starting]split=5[stream3starting1][stream3starting2][stream3starting3][stream3starting4][stream3starting5];\
[stream4starting]split=5[stream4starting1][stream4starting2][stream4starting3][stream4starting4][stream4starting5];\
[stream5starting]split=5[stream5starting1][stream5starting2][stream5starting3][stream5starting4][stream5starting5];\
[stream2starting1]crop=out_w=iw:out_h=ih/5:x=0:y=0,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream2starting1cropped];\
[stream2starting2]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream2starting2cropped];\
[stream2starting3]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*2,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream2starting3cropped];\
[stream2starting4]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*3,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream2starting4cropped];\
[stream2starting5]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*4,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream2starting5cropped];\
[stream3starting1]crop=out_w=iw:out_h=ih/5:x=0:y=0,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream3starting1cropped];\
[stream3starting2]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream3starting2cropped];\
[stream3starting3]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*2,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream3starting3cropped];\
[stream3starting4]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*3,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream3starting4cropped];\
[stream3starting5]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*4,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream3starting5cropped];\
[stream4starting1]crop=out_w=iw:out_h=ih/5:x=0:y=0,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream4starting1cropped];\
[stream4starting2]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream4starting2cropped];\
[stream4starting3]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*2,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream4starting3cropped];\
[stream4starting4]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*3,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream4starting4cropped];\
[stream4starting5]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*4,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream4starting5cropped];\
[stream5starting1]crop=out_w=iw:out_h=ih/5:x=0:y=0,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream5starting1cropped];\
[stream5starting2]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream5starting2cropped];\
[stream5starting3]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*2,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream5starting3cropped];\
[stream5starting4]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*3,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream5starting4cropped];\
[stream5starting5]crop=out_w=iw:out_h=ih/5:x=0:y=ih/5*4,pad=w=1280:h=720:x=0:y=0:color=#00000000[stream5starting5cropped];\
[stream1ending][stream2starting1cropped]overlay=x='if(between(t,0,0.2),-w+1280*t/0.2,if(gte(t,0.2),0,-w))':y=0,select=lte(n\,30)[stream2starting1added];\
[stream2starting1added][stream2starting2cropped]overlay=x='if(between(t,0.2,0.4),-w+1280*(t-0.2)/0.2,if(gte(t,0.4),0,-w))':y=h/5,select=lte(n\,30)[stream2starting2added];\
[stream2starting2added][stream2starting3cropped]overlay=x='if(between(t,0.4,0.6),-w+1280*(t-0.4)/0.2,if(gte(t,0.6),0,-w))':y=h/5*2,select=lte(n\,30)[stream2starting3added];\
[stream2starting3added][stream2starting4cropped]overlay=x='if(between(t,0.6,0.8),-w+1280*(t-0.6)/0.2,if(gte(t,0.8),0,-w))':y=h/5*3,select=lte(n\,30)[stream2starting4added];\
[stream2starting4added][stream2starting5cropped]overlay=x='if(between(t,0.8,1),-w+1280*(t-0.8)/0.2,if(gte(t,1),0,-w))':y=h/5*4,select=lte(n\,30)[stream2blended];\
[stream2ending][stream3starting1cropped]overlay=x='if(between(t,0,0.2),-w+1280*t/0.2,if(gte(t,0.2),0,-w))':y=0,select=lte(n\,30)[stream3starting1added];\
[stream3starting1added][stream3starting2cropped]overlay=x='if(between(t,0.2,0.4),-w+1280*(t-0.2)/0.2,if(gte(t,0.4),0,-w))':y=h/5,select=lte(n\,30)[stream3starting2added];\
[stream3starting2added][stream3starting3cropped]overlay=x='if(between(t,0.4,0.6),-w+1280*(t-0.4)/0.2,if(gte(t,0.6),0,-w))':y=h/5*2,select=lte(n\,30)[stream3starting3added];\
[stream3starting3added][stream3starting4cropped]overlay=x='if(between(t,0.6,0.8),-w+1280*(t-0.6)/0.2,if(gte(t,0.8),0,-w))':y=h/5*3,select=lte(n\,30)[stream3starting4added];\
[stream3starting4added][stream3starting5cropped]overlay=x='if(between(t,0.8,1),-w+1280*(t-0.8)/0.2,if(gte(t,1),0,-w))':y=h/5*4,select=lte(n\,30)[stream3blended];\
[stream3ending][stream4starting1cropped]overlay=x='if(between(t,0,0.2),-w+1280*t/0.2,if(gte(t,0.2),0,-w))':y=0,select=lte(n\,30)[stream4starting1added];\
[stream4starting1added][stream4starting2cropped]overlay=x='if(between(t,0.2,0.4),-w+1280*(t-0.2)/0.2,if(gte(t,0.4),0,-w))':y=h/5,select=lte(n\,30)[stream4starting2added];\
[stream4starting2added][stream4starting3cropped]overlay=x='if(between(t,0.4,0.6),-w+1280*(t-0.4)/0.2,if(gte(t,0.6),0,-w))':y=h/5*2,select=lte(n\,30)[stream4starting3added];\
[stream4starting3added][stream4starting4cropped]overlay=x='if(between(t,0.6,0.8),-w+1280*(t-0.6)/0.2,if(gte(t,0.8),0,-w))':y=h/5*3,select=lte(n\,30)[stream4starting4added];\
[stream4starting4added][stream4starting5cropped]overlay=x='if(between(t,0.8,1),-w+1280*(t-0.8)/0.2,if(gte(t,1),0,-w))':y=h/5*4,select=lte(n\,30)[stream4blended];\
[stream4ending][stream5starting1cropped]overlay=x='if(between(t,0,0.2),-w+1280*t/0.2,if(gte(t,0.2),0,-w))':y=0,select=lte(n\,30)[stream5starting1added];\
[stream5starting1added][stream5starting2cropped]overlay=x='if(between(t,0.2,0.4),-w+1280*(t-0.2)/0.2,if(gte(t,0.4),0,-w))':y=h/5,select=lte(n\,30)[stream5starting2added];\
[stream5starting2added][stream5starting3cropped]overlay=x='if(between(t,0.4,0.6),-w+1280*(t-0.4)/0.2,if(gte(t,0.6),0,-w))':y=h/5*2,select=lte(n\,30)[stream5starting3added];\
[stream5starting3added][stream5starting4cropped]overlay=x='if(between(t,0.6,0.8),-w+1280*(t-0.6)/0.2,if(gte(t,0.8),0,-w))':y=h/5*3,select=lte(n\,30)[stream5starting4added];\
[stream5starting4added][stream5starting5cropped]overlay=x='if(between(t,0.8,1),-w+1280*(t-0.8)/0.2,if(gte(t,1),0,-w))':y=h/5*4,select=lte(n\,30)[stream5blended];\
[stream1overlaid][stream2blended][stream2overlaid][stream3blended][stream3overlaid][stream4blended][stream4overlaid][stream5blended][stream5overlaid]concat=n=9:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../advanced_sliding_bars_horizontal.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'