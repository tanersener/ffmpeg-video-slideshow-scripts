# FFmpeg Video Slideshow Transition Scripts

Each script in this section demonstrates a different transition animation.

Transitions are implemented as custom filters in the following execution order.

1. Prepare input streams
2. Generate static frames
3. Generate transition frames
4. Concat static and transition streams

## Checkerboard

New photo appears in growing 128x128 boxes

![Checkerboard Transition](../docs/transition_checkerboard.gif)


## Collapse Horizontal

Two vertical lines move horizontally from sides to center

![Checkerboard Transition](../docs/transition_collapse_horizontal.gif)


## Collapse Vertical