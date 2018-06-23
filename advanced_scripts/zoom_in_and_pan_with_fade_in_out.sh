#!/bin/bash
#
# ffmpeg video slideshow script with zoom in and pan and fade in/out transition v1 (23.06.2018)
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
[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',crop=1280:720,setsar=sar=1/1,format=rgba,split=2[stream1out1][stream1out2];\
[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',crop=1280:720,setsar=sar=1/1,format=rgba,split=2[stream2out1][stream2out2];\
[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',crop=1280:720,setsar=sar=1/1,format=rgba,split=2[stream3out1][stream3out2];\
[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',crop=1280:720,setsar=sar=1/1,format=rgba,split=2[stream4out1][stream4out2];\
[4:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',crop=1280:720,setsar=sar=1/1,format=rgba,split=2[stream5out1][stream5out2];\
[stream1out1]trim=duration=1,select=lte(n\,30),split=2[stream1in][stream1out];\
[stream1out2]trim=duration=2,select=lte(n\,60)[stream1];\
[stream2out1]trim=duration=1,select=lte(n\,30),split=2[stream2in][stream2out];\
[stream2out2]trim=duration=2,select=lte(n\,60)[stream2];\
[stream3out1]trim=duration=1,select=lte(n\,30),split=2[stream3in][stream3out];\
[stream3out2]trim=duration=2,select=lte(n\,60)[stream3];\
[stream4out1]trim=duration=1,select=lte(n\,30),split=2[stream4in][stream4out];\
[stream4out2]trim=duration=2,select=lte(n\,60)[stream4];\
[stream5out1]trim=duration=1,select=lte(n\,30),split=2[stream5in][stream5out];\
[stream5out2]trim=duration=2,select=lte(n\,60)[stream5];\
[stream1in]fade=t=in:s=0:n=30[stream1fadein];\
[stream1out]fade=t=out:s=0:n=30[stream1fadeout];\
[stream2in]fade=t=in:s=0:n=30[stream2fadein];\
[stream2out]fade=t=out:s=0:n=30[stream2fadeout];\
[stream3in]fade=t=in:s=0:n=30[stream3fadein];\
[stream3out]fade=t=out:s=0:n=30[stream3fadeout];\
[stream4in]fade=t=in:s=0:n=30[stream4fadein];\
[stream4out]fade=t=out:s=0:n=30[stream4fadeout];\
[stream5in]fade=t=in:s=0:n=30[stream5fadein];\
[stream5out]fade=t=out:s=0:n=30[stream5fadeout];\
[stream1fadein][stream1][stream1fadeout]concat=n=3:v=1:a=0,scale=1280*5:-1,zoompan=z='min(pzoom+0.002,2)':d=1:x='iw/2-(iw/zoom/2)':s=1280x720[stream1panning];\
[stream2fadein][stream2][stream2fadeout]concat=n=3:v=1:a=0,scale=1280*5:-1,zoompan=z='min(pzoom+0.002,2)':d=1:x='iw/2':y='(ih/zoom/2)':s=1280x720[stream2panning];\
[stream3fadein][stream3][stream3fadeout]concat=n=3:v=1:a=0,scale=1280*5:-1,zoompan=z='min(pzoom+0.002,2)':d=1:x='1280-(iw/zoom/2)':y='-720-(ih/zoom/2)':s=1280x720[stream3panning];\
[stream4fadein][stream4][stream4fadeout]concat=n=3:v=1:a=0,scale=1280*5:-1,zoompan=z='min(pzoom+0.002,2)':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720[stream4panning];\
[stream5fadein][stream5][stream5fadeout]concat=n=3:v=1:a=0,scale=1280*5:-1,zoompan=z='min(pzoom+0.002,2)':d=1:x='-(iw/zoom/2)':y='ih/2-720':s=1280x720[stream5panning];\
[stream1panning][stream2panning][stream3panning][stream4panning][stream5panning]concat=n=5:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../advanced_zoom_in_and_pan_with_fade_in_out.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'