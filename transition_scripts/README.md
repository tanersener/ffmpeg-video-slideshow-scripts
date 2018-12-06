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

**Supported Options:** width, height, fps, photo duration, transition duration, background color, bar count 

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_bars_horizontal_one.gif" width="380">
  <img src="../docs/transition_bars_vertical_one.gif" width="380" hspace="60"> 
</p>


## Bars #2

New photo appears through growing bars, bars grow from center to the both sides

**Supported Options:** width, height, fps, photo duration, transition duration, background color, bar count

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_bars_horizontal_two.gif" width="380">
  <img src="../docs/transition_bars_vertical_two.gif" width="380" hspace="60"> 
</p>


## Box In

New photo appears as a box moving in and out

**Supported Options:** width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_box_in_horizontal.gif" width="380">
  <img src="../docs/transition_box_in_vertical.gif" width="380" hspace="60"> 
</p>


## Checkerboard

New photo appears in growing square boxes

**Supported Options:** width, height, fps, photo duration, transition duration, background color, cell size

<img src="../docs/transition_checkerboard.gif" width="380">


## Clock

New photo is revealed by a clock like line swiping across the screen

**Supported Options:** width, height, fps, photo duration, background color

<img src="../docs/transition_clock.gif" width="380">


## Collapse

New photo appears as two lines move from sides to center

**Supported Options:** width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_collapse_horizontal.gif" width="380">
  <img src="../docs/transition_collapse_vertical.gif" width="380" hspace="60"> 
</p>

## Collapse Both

Horizontal and vertical collapse at the same time

**Supported Options:** width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_collapse_both.gif" width="380">


## Cover

A line moving shows the new photo

**Supported Options:** width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_cover_horizontal.gif" width="380">
  <img src="../docs/transition_cover_vertical.gif" width="380" hspace="60"> 
</p>


## Expand

New photo appears as two lines move from center to sides

**Supported Options:** width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_expand_horizontal.gif" width="380">
  <img src="../docs/transition_expand_vertical.gif" width="380" hspace="60"> 
</p>

## Expand Both

Horizontal and vertical expand at the same time

**Supported Options:** width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_expand_both.gif" width="380">


## Fade In #1

New photo appears fading in

**Supported Options:** width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_fade_in_one.gif" width="380">


## Fade In #2

New photo appears fading in while the previous one is fading out

**Supported Options:** width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_fade_in_two.gif" width="380">


## Push

New photo pushes previous photo

**Supported Options:** width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_push_horizontal.gif" width="380">
  <img src="../docs/transition_push_vertical.gif" width="380" hspace="60"> 
</p>


## Push Box

`Box In` and `Push` transitions combined.

**Supported Options:** width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_push_box_horizontal.gif" width="380">
  <img src="../docs/transition_push_box_vertical.gif" width="380" hspace="60"> 
</p>


## Rotate

New photo appears moving from left to right and rotating

**Supported Options:** width, height, fps, photo duration, transition duration, background color

<img src="../docs/transition_rotate.gif" width="380">


## Spin Blur Rotation

New photo appears with spin blur rotation effect

**Supported Options:** width, height, fps, photo duration

<img src="../docs/transition_spin_blur_rotation.gif" width="380">


## Wipe In

New photo appears moving in

**Supported Options:** width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_wipe_in_horizontal.gif" width="380">
  <img src="../docs/transition_wipe_in_vertical.gif" width="380" hspace="60"> 
</p>


## Wipe Out

New photo disappears moving out

**Supported Options:** width, height, fps, photo duration, transition duration, background color

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_wipe_out_horizontal.gif" width="380">
  <img src="../docs/transition_wipe_out_vertical.gif" width="380" hspace="60"> 
</p>