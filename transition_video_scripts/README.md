# Transition Scripts with Video Support

:warning: `Transition Scripts with Video Support` are decommissioned and not distributed anymore.

Each script in this section demonstrates a different transition animation.

Both images and videos (with or without audio) are supported as input.

Scripts in this section are licensed under the `ARTHENICA Commercial License`. 

Please note that sample animations used in this page are low in quality and does not represent full functionality of the scripts.

## Bars #1

New image/video appears through growing bars, bars grow from one side to the other

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, bar count, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_bars_horizontal_one.gif" width="360">
  <img src="../docs/transition_media_bars_vertical_one.gif" width="360" hspace="60"> 
</p>


## Bars #2

New image/video appears through growing bars, bars grow from center to the both sides

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, bar count, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_bars_horizontal_two.gif" width="360">
  <img src="../docs/transition_media_bars_vertical_two.gif" width="360" hspace="60"> 
</p>


## Box In

New image/video appears as a box moving in and out

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, direction, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Box in Image #1 |   transition duration    |
|  2  | Show Image #1          |      image/video duration - 2*transition duration      |
|  3  | Box out Image #1 |   transition duration    |
|  4  | Box in Image #2 |   transition duration    |
|  5  | Show Image #2          |      image/video duration - 2*transition duration      |
|  6  | Box out Image #2 |   transition duration    |
| ... | ...                    |      ...                 |
|  n*3-2  | Box in Image #n |   transition duration    |
|  n*3-1  | Show Image #n  |      image/video duration - 2*transition duration      |
|  n*3  | Box out Image #n |   transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_box_in_horizontal.gif" width="360">
  <img src="../docs/transition_media_box_in_vertical.gif" width="360" hspace="60"> 
</p>


## Checkerboard

New image/video appears in growing square boxes

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, cell size, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_checkerboard.gif" width="360">


## Clock

New image/video is revealed by a clock like line swiping across the screen

**Options:** screen mode, width, height, fps, image duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_clock.gif" width="360">


## Collapse

New image/video appears as two lines move from both sides to the center

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_collapse_horizontal.gif" width="360">
  <img src="../docs/transition_media_collapse_vertical.gif" width="360" hspace="60"> 
</p>

## Collapse Both

Horizontal and vertical collapse at the same time

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_collapse_both.gif" width="360">

## Collapse Circular

Circular collapse

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_collapse_circular.gif" width="360">


## Cover

A moving line shows the new image/video

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, direction, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_cover_horizontal.gif" width="360">
  <img src="../docs/transition_media_cover_vertical.gif" width="360" hspace="60"> 
</p>


## Expand

New image/video appears as two lines move from center to the sides

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_expand_horizontal.gif" width="360">
  <img src="../docs/transition_media_expand_vertical.gif" width="360" hspace="60"> 
</p>

## Expand Both

Horizontal and vertical expand at the same time

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_expand_both.gif" width="360">

## Expand Circular

Circular expand

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_expand_circular.gif" width="360">


## Fade In #1

New image/video appears fading in

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_fade_in_one.gif" width="360">


## Fade In #2

New image/video appears fading in while the previous one is fading out

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_fade_in_two.gif" width="360">


## Moving Bars

Enhanced version of `Wipe In` transition. Screen is divided into bars moving from one side to the other

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, bar count, direction, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_moving_bars_horizontal.gif" width="360">
  <img src="../docs/transition_media_moving_bars_vertical.gif" width="360" hspace="60"> 
</p>


## Push

New image/video pushes the previous one

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, direction, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_push_horizontal.gif" width="360">
  <img src="../docs/transition_media_push_vertical.gif" width="360" hspace="60"> 
</p>


## Push Box

`Box In` and `Push` transitions combined.

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, direction, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Box in Image #1 |   transition duration    |
|  2  | Show Image #1          |      image/video duration - 2*transition duration      |
|  3  | Box out Image #1 |   transition duration    |
|  4  | Box in Image #2 |   transition duration/2    |
|  5  | Show Image #2          |      image/video duration - 2*transition duration      |
|  6  | Box out Image #2 |   transition duration    |
| ... | ...                    |      ...                 |
|  n*3-2  | Box in Image #n |   transition duration/2    |
|  n*3-1  | Show Image #n  |      image/video duration - 2*transition duration      |
|  n*3  | Box out Image #n |   transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_push_box_horizontal.gif" width="360">
  <img src="../docs/transition_media_push_box_vertical.gif" width="360" hspace="60"> 
</p>


## Rotate #1

New image/video appears moving from left to right and rotating

**Options:** width, height, fps, image duration, transition duration, screen mode, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Transition to file #1 |   transition duration    |
|  2  | Show file #1          |      image/video duration - transition duration    |
|  3  | Transition to file #2 |   transition duration    |
|  4  | Show file #2          |      image/video duration - 2*transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_rotate_one.gif" width="360">


## Rotate #2

New image/video appears rotating clockwise around the lower left corner

**Options:** width, height, fps, image duration, transition duration, screen mode, background color, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

<img src="../docs/transition_media_rotate_two.gif" width="360">


## Sliding Bars

Enhanced version of `Wipe In` transition. Screen is divided into bars sliding from one side to the other

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, bar count, direction, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_sliding_bars_horizontal.gif" width="360">
  <img src="../docs/transition_media_sliding_bars_vertical.gif" width="360" hspace="60"> 
</p>


## Spin Blur Rotation

New image/video appears with spin blur rotation effect

**Options:** width, height, fps, image duration, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration    |
|  2  | Transition to file #2 |   0.5    |
|  3  | Show file #2          |      image/video duration    |
|  4  | Transition to file #3 |   0.5    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration    |

<img src="../docs/transition_media_spin_blur_rotation.gif" width="360">


## Wipe In

New image/video appears moving in

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, direction, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_wipe_in_horizontal.gif" width="360">
  <img src="../docs/transition_media_wipe_in_vertical.gif" width="360" hspace="60"> 
</p>


## Wipe Out

New image/video appears as the previous one moves out

**Options:** screen mode, width, height, fps, image duration, transition duration, background color, direction, audio sample format, audio sample rate, audio channel layout

#### Scene Arrangement

|  #  |      Scene    |    Duration (seconds)    |
|:---:|:-------------:|:------------------------:|
|  1  | Show file #1          |      image/video duration - transition duration    |
|  2  | Transition to file #2 |   transition duration    |
|  3  | Show file #2          |      image/video duration - 2*transition duration    |
|  4  | Transition to file #3 |   transition duration    |
| ... | ...                    |      ...                 |  
|  (n-1)*2+1  | Show file #n  |      image/video duration - transition duration    |

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Horizontal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Vertical

<p float="left">
  <img src="../docs/transition_media_wipe_out_horizontal.gif" width="360">
  <img src="../docs/transition_media_wipe_out_vertical.gif" width="360" hspace="60"> 
</p>

### ARTHENICA Commercial License

ARTHENICA Commercial License

Copyright (c) 2019, Taner Sener (https://github.com/tanersener), All rights reserved.

Permission is hereby granted, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use, copy, modify, merge, distribute, sublicense, and/or sell copies of the Software, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.