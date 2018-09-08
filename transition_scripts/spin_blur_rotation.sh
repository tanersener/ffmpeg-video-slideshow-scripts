#!/bin/bash
#
# ffmpeg video slideshow script with spin blur rotation transition v1 (19.08.2018)
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
[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,trim=duration=3,crop=1280:720,split=2[stream1][stream1sample];\
[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,trim=duration=3,crop=1280:720,split=3[stream2][stream2sample][stream2sample2];\
[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,trim=duration=3,crop=1280:720,split=3[stream3][stream3sample][stream3sample2];\
[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,trim=duration=3,crop=1280:720,split=3[stream4][stream4sample][stream4sample2];\
[4:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,1280/720),-1,1280)':h='if(gte(iw/ih,1280/720),720,-1)',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,format=rgba,trim=duration=3,crop=1280:720,split=2[stream5][stream5sample];\
[stream1sample]split=2[stream1rotate_out_background][stream1pre_rotate_out];\
[stream1pre_rotate_out]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.4:c=none[stream1rotate_out];\
[stream1rotate_out_background][stream1rotate_out]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=1280:720,trim=duration=0.2,crop=1280:720[transition1part1];\
[stream2sample]rotate=PI,split=2[stream2rotate_in_background][stream2pre_rotate_in];\
[stream2pre_rotate_in]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.6:c=none[stream2rotate_in];\
[stream2rotate_in_background][stream2rotate_in]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=1280:720,trim=duration=0.3,crop=1280:720[transition1part2];\
[stream2sample2]split=2[stream2rotate_out_background][stream2pre_rotate_out];\
[stream2pre_rotate_out]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.4:c=none[stream2rotate_out];\
[stream2rotate_out_background][stream2rotate_out]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=1280:720,trim=duration=0.2,crop=1280:720[transition2part1];\
[stream3sample]rotate=PI,split=2[stream3rotate_in_background][stream3pre_rotate_in];\
[stream3pre_rotate_in]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.6:c=none[stream3rotate_in];\
[stream3rotate_in_background][stream3rotate_in]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=1280:720,trim=duration=0.3,crop=1280:720[transition2part2];\
[stream3sample2]split=2[stream3rotate_out_background][stream3pre_rotate_out];\
[stream3pre_rotate_out]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.4:c=none[stream3rotate_out];\
[stream3rotate_out_background][stream3rotate_out]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=1280:720,trim=duration=0.2,crop=1280:720[transition3part1];\
[stream4sample]rotate=PI,split=2[stream4rotate_in_background][stream4pre_rotate_in];\
[stream4pre_rotate_in]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.6:c=none[stream4rotate_in];\
[stream4rotate_in_background][stream4rotate_in]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=1280:720,trim=duration=0.3,crop=1280:720[transition3part2];\
[stream4sample2]split=2[stream4rotate_out_background][stream4pre_rotate_out];\
[stream4pre_rotate_out]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.4:c=none[stream4rotate_out];\
[stream4rotate_out_background][stream4rotate_out]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=1280:720,trim=duration=0.2,crop=1280:720[transition4part1];\
[stream5sample]rotate=PI,split=2[stream5rotate_in_background][stream5pre_rotate_in];\
[stream5pre_rotate_in]boxblur=luma_radius=10:luma_power=3,rotate=2*PI*t/0.6:c=none[stream5rotate_in];\
[stream5rotate_in_background][stream5rotate_in]overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2:format=rgb,crop=1280:720,trim=duration=0.3,crop=1280:720[transition4part2];\
[stream1][transition1part1][transition1part2][stream2][transition2part1][transition2part2][stream3][transition3part1][transition3part2][stream4][transition4part1][transition4part2][stream5]concat=n=13:v=1:a=0,format=yuv420p[video]"\
 -map [video] -vsync 2 -async 1 -rc-lookahead 0 -g 0 -profile:v main -level 42 -c:v libx264 -r 30 ../transition_spin_blur_rotation.mp4

ELAPSED_TIME=$(($SECONDS - $START_TIME))

echo 'Slideshow created in '$ELAPSED_TIME' seconds'