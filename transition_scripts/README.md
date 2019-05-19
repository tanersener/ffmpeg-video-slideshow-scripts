# FFmpeg Video Slideshow Transition Scripts

Each script in this section demonstrates a different transition animation.

Transitions are implemented in -filter_complex blocks in the following execution order.

1. Prepare input streams
2. Generate static frames
3. Generate transition frames
4. Concat static and transition streams

Please note that sample animations used in this page are low in quality and does not represent full functionality of the scripts.

## Bars #1

New photo appears through growing bars, bars grow from one side to the other side

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, bar count 

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_bars_horizontal_one.gif" width="360">
  <img src="../docs/transition_bars_vertical_one.gif" width="360" hspace="60"> 
</p>


## Bars #2

New photo appears through growing bars, bars grow from center to the both sides

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, bar count

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_bars_horizontal_two.gif" width="360">
  <img src="../docs/transition_bars_vertical_two.gif" width="360" hspace="60"> 
</p>


## Box In

New photo appears as a box moving in and out

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, direction

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_box_in_horizontal.gif" width="360">
  <img src="../docs/transition_box_in_vertical.gif" width="360" hspace="60"> 
</p>


## Checkerboard

New photo appears in growing square boxes

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, cell size

<img src="../docs/transition_checkerboard.gif" width="360">


## Clock

New photo is revealed by a clock like line swiping across the screen

**Options:** photo mode, width, height, fps, photo duration, background color

<img src="../docs/transition_clock.gif" width="360">


## Collapse

New photo appears as two lines move from sides to center

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_collapse_horizontal.gif" width="360">
  <img src="../docs/transition_collapse_vertical.gif" width="360" hspace="60"> 
</p>

## Collapse Both

Horizontal and vertical collapse at the same time

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_collapse_both.gif" width="360">

## Collapse Circular

Circular collapse

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_collapse_circular.gif" width="360">


## Cover

A line moving shows the new photo

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, direction

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_cover_horizontal.gif" width="360">
  <img src="../docs/transition_cover_vertical.gif" width="360" hspace="60"> 
</p>


## Expand

New photo appears as two lines move from center to sides

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_expand_horizontal.gif" width="360">
  <img src="../docs/transition_expand_vertical.gif" width="360" hspace="60"> 
</p>

## Expand Both

Horizontal and vertical expand at the same time

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_expand_both.gif" width="360">

## Expand Circular

Circular expand

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_expand_circular.gif" width="360">


## Fade In #1

New photo appears fading in

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_fade_in_one.gif" width="360">


## Fade In #2

New photo appears fading in while the previous one is fading out

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_fade_in_two.gif" width="360">


## Push

New photo pushes previous photo

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, direction

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_push_horizontal.gif" width="360">
  <img src="../docs/transition_push_vertical.gif" width="360" hspace="60"> 
</p>


## Rotate

New photo appears moving from left to right and rotating

**Options:** width, height, fps, photo duration, transition duration, photo mode, background color

<img src="../docs/transition_rotate.gif" width="360">


## Spin Blur Rotation

New photo appears with spin blur rotation effect

**Options:** width, height, fps, photo duration

<img src="../docs/transition_spin_blur_rotation.gif" width="360">


## Stack

Scrolls the photos horizontally or vertically

**Options:** width, height, fps, total duration, background color, direction, include intro, include outro  

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_stack_horizontal.gif" width="360">
  <img src="../docs/transition_stack_vertical.gif" width="360" hspace="60"> 
</p>


## Wipe In

New photo appears moving in

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, direction

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_wipe_in_horizontal.gif" width="360">
  <img src="../docs/transition_wipe_in_vertical.gif" width="360" hspace="60"> 
</p>


## Wipe Out

New photo disappears moving out

**Options:** photo mode, width, height, fps, photo duration, transition duration, background color, direction

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_wipe_out_horizontal.gif" width="360">
  <img src="../docs/transition_wipe_out_vertical.gif" width="360" hspace="60"> 
</p>