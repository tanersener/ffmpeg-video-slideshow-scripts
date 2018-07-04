#!/bin/bash
#
# ffmpeg video slideshow script with vertical push box transition v1 (28.06.2018)
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
-f lavfi -i color=black:s=1280x720 \
-filter_complex "\
[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,setsar=sar=1/1,format=rgba,split=2[stream1out1][stream1out2];\
[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,setsar=sar=1/1,format=rgba,split=2[stream2out1][stream2out2];\
[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,setsar=sar=1/1,format=rgba,split=2[stream3out1][stream3out2];\
[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,setsar=sar=1/1,format=rgba,split=2[stream4out1][stream4out2];\
[4:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))',scale=trunc(iw/2)*2:trunc(ih/2)*2,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,setsar=sar=1/1,format=rgba,split=2[stream5out1][stream5out2];\
[stream1out1]trim=duration=2,select=lte(n\,60)[stream1overlaid];\
[stream2out1]trim=duration=2,select=lte(n\,60)[stream2overlaid];\
[stream3out1]trim=duration=2,select=lte(n\,60)[stream3overlaid];\
[stream4out1]trim=duration=2,select=lte(n\,60)[stream4overlaid];\
[stream5out1]trim=duration=2,select=lte(n\,60)[stream5overlaid];\
[stream1out2]scale=w=1280/2:-1,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=5[stream1prephasein][stream1checkpoint][stream1prezoomin][stream1prezoomout][stream1prephaseout];\
[stream2out2]scale=w=1280/2:-1,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=5[stream2prephasein][stream2checkpoint][stream2prezoomin][stream2prezoomout][stream2prephaseout];\
[stream3out2]scale=w=1280/2:-1,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=5[stream3prephasein][stream3checkpoint][stream3prezoomin][stream3prezoomout][stream3prephaseout];\
[stream4out2]scale=w=1280/2:-1,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=5[stream4prephasein][stream4checkpoint][stream4prezoomin][stream4prezoomout][stream4prephaseout];\
[stream5out2]scale=w=1280/2:-1,pad=width=1280:height=720:x=(ow-iw)/2:y=(oh-ih)/2:color=#00000000,trim=duration=1,select=lte(n\,30),split=5[stream5prephasein][stream5checkpoint][stream5prezoomin][stream5prezoomout][stream5prephaseout];\
[5:v][stream1prephasein]overlay=x=0:y='-h+t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream1phasein];\
[5:v][stream1prephaseout]overlay=x=0:y='t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream1phaseout];\
[stream1phaseout][stream2prephasein]overlay=x=0:y='-h+t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream2phasein];\
[5:v][stream2prephaseout]overlay=x=0:y='t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream2phaseout];\
[stream2phaseout][stream3prephasein]overlay=x=0:y='-h+t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream3phasein];\
[5:v][stream3prephaseout]overlay=x=0:y='t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream3phaseout];\
[stream3phaseout][stream4prephasein]overlay=x=0:y='-h+t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream4phasein];\
[5:v][stream4prephaseout]overlay=x=0:y='t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream4phaseout];\
[stream4phaseout][stream5prephasein]overlay=x=0:y='-h+t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream5phasein];\
[5:v][stream5prephaseout]overlay=x=0:y='t/0.5*720',trim=duration=0.5,select=lte(n\,15)[stream5phaseout];\
[stream1checkpoint]trim=duration=0.2,split=2[stream1checkin][stream1checkout];\
[stream2checkpoint]trim=duration=0.2,split=2[stream2checkin][stream2checkout];\
[stream3checkpoint]trim=duration=0.2,split=2[stream3checkin][stream3checkout];\
[stream4checkpoint]trim=duration=0.2,split=2[stream4checkin][stream4checkout];\
[stream5checkpoint]trim=duration=0.2,split=2[stream5checkin][stream5checkout];\
[stream1prezoomin]scale=iw*5:ih*5,zoompan=z='min(pzoom+0.04,2)':d=1:fps=30:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream1zoomin];\
[stream2prezoomin]scale=iw*5:ih*5,zoompan=z='min(pzoom+0.04,2)':d=1:fps=30:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream2zoomin];\
[stream3prezoomin]scale=iw*5:ih*5,zoompan=z='min(pzoom+0.04,2)':d=1:fps=30:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream3zoomin];\
[stream4prezoomin]scale=iw*5:ih*5,zoompan=z='min(pzoom+0.04,2)':d=1:fps=30:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream4zoomin];\
[stream5prezoomin]scale=iw*5:ih*5,zoompan=z='min(pzoom+0.04,2)':d=1:fps=30:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream5zoomin];\
[stream1prezoomout]scale=iw*5:ih*5,zoompan=z='2-in*0.04':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream1zoomout];\
[stream2prezoomout]scale=iw*5:ih*5,zoompan=z='2-in*0.04':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream2zoomout];\
[stream3prezoomout]scale=iw*5:ih*5,zoompan=z='2-in*0.04':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream3zoomout];\
[stream4prezoomout]scale=iw*5:ih*5,zoompan=z='2-in*0.04':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream4zoomout];\
[stream5prezoomout]scale=iw*5:ih*5,zoompan=z='2-in*0.04':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1280x720,setpts=0.5*PTS[stream5zoomout];\
[stream1phasein][stream1checkin][stream1zoomin][stream1overlaid][stream1zoomout][stream1checkout]\
[stream2phasein][stream2checkin][stream2zoomin][stream2overlaid][stream2zoomout][stream2checkout]\
[stream3phasein][stream3checkin][stream3zoomin][stream3overlaid][stream3zoomout][stream3checkout]\
[stream4phasein][stream4checkin][stream4zoomin][stream4overlaid][stream4zoomout][stream4checkout]\
[stream5phasein][stream5checkin][stream5zoomin][stream5overlaid][stream5zoomout][stream5checkout]\
[stream5phaseout]\
concat=n=31:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../transition_push_box_vertical.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'
