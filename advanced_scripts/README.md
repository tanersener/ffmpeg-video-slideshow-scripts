# FFmpeg Video Slideshow Advanced Scripts

Scripts in this section demonstrate complex animation like transitions/transformations.

Animations are implemented inside filter_complex blocks.

Please note that sample animations used in this page are low in quality and does not represent full functionality of the scripts.

## Blurred Background

Replaces empty areas from sides/top/bottom with blur effect

**Options:** width, height, fps, photo duration, transition duration

<img src="../docs/advanced_blurred_background.gif" width="360">


## Logo Overlay & Zoom

Overlays a beating heart animation (generated from a static heart image with zoom effect) at the right bottom corner of the slideshow

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, heart frame size, heart frame position

<img src="../docs/advanced_logo_overlay_and_zoom.gif" width="360">


## Moving Text

Moves text from right to the left or from left to the right on a slideshow

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, text, text font, text size, text color, text speed, text position, text frame height, text frame position, direction

<img src="../docs/advanced_moving_text.gif" width="360">


## Object Animation

Animates snow flakes falling (from random positions) and rotating around themselves

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, snow flake size, snow flake rotate speed, snow flake fall speed 

<img src="../docs/advanced_object_animation.gif" width="360">


## Photo Collection

Enhanced version of `Rotate` transition. Each photo stops rotating on a specific angle where some parts of the previous photos are still visible

**Options:** width, height, fps, photo duration, transition duration, background color, max photo angle 

<img src="../docs/advanced_photo_collection.gif" width="360">


## Push Box

`Box In` and `Push` transitions combined.

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, direction

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/advanced_push_box_horizontal.gif" width="360">
  <img src="../docs/advanced_push_box_vertical.gif" width="360" hspace="60"> 
</p>


## Push Film

Enhanced version of `Push` transition. Static parts are removed and a strip frame is used as overlay image to create film strip animation

**Options:** photo mode, width, height, fps, transition duration, background color, direction

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/advanced_push_horizontal_film.gif" width="360">
  <img src="../docs/advanced_push_vertical_film.gif" width="360" hspace="60"> 
</p>


## Sliding Bars

Enhanced version of `Wipe In` transition. Screen is divided into bars sliding from one to side to another

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, bar count, direction

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/advanced_sliding_bars_horizontal.gif" width="360">
  <img src="../docs/advanced_sliding_bars_vertical.gif" width="360" hspace="60"> 
</p>


## Zoom & Pan with Fade In/Out Transition #1

Each photo focuses towards a different area of the photo

**Options:** width, height, fps, photo duration, transition duration, zoom speed

**Scene Arrangement (for each photo): Zoom & Pan is applied during all three stages**
- fade in photo for `TRANSITION_DURATION` seconds
- show photo for `PHOTO_DURATION` seconds
- fade out photo for for `TRANSITION_DURATION` seconds

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Zoom In &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Zoom Out

<p float="left">
  <img src="../docs/advanced_zoom_in_and_pan_with_fade_in_out_one.gif" width="360">
  <img src="../docs/advanced_zoom_out_and_pan_with_fade_in_out_one.gif" width="360" hspace="60"> 
</p>


## Zoom & Pan with Fade In/Out Transition #2

Each photo focuses towards a different area of the photo

**Options:** width, height, fps, photo duration, transition duration

**Scene Arrangement (for each photo): Zoom & Pan is applied only during fade in stage**
- fade in photo for `TRANSITION_DURATION` seconds
- show photo for `PHOTO_DURATION` seconds
- fade out photo for for `TRANSITION_DURATION` seconds

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Zoom In &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Zoom Out

<p float="left">
  <img src="../docs/advanced_zoom_in_and_pan_with_fade_in_out_two.gif" width="360">
  <img src="../docs/advanced_zoom_out_and_pan_with_fade_in_out_two.gif" width="360" hspace="60"> 
</p>