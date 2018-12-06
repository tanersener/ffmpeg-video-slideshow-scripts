# FFmpeg Video Slideshow Scripts [![Join the chat at https://gitter.im/ffmpeg-video-slideshow-scripts/Lobby](https://badges.gitter.im/ffmpeg-video-slideshow-scripts/Lobby.svg)](https://gitter.im/ffmpeg-video-slideshow-scripts/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

Configurable shell scripts to create video slideshows from images using [FFmpeg](https://www.ffmpeg.org/).

<img src="https://github.com/tanersener/ffmpeg-video-slideshow-scripts/blob/master/docs/ffmpeg-video-slideshow-scripts-logo-v1.png" width="240">

## Features
- [Transition scripts](transition_scripts) 
- [Advanced scripts](advanced_scripts)


## Requirements

- `ffmpeg 2.8.x` or later

`Advanced Moving Text` script needs `FFmpeg` to be build with `freetype`. If you compile FFmpeg from source you need to provide `--enable-libfreetype` flag on `./configure`. 


## Description

Each script creates a video slideshow using photos inside `photos` folder. Transition scripts implements different transition effects and advanced scripts implements more complex animation like transitions/transformations.

Output of all scripts is an `h264` encoded `MPEG-4` video.


## Customization

- There is a `# SCRIPT OPTIONS - CAN BE MODIFIED` section at the top of each script. That section lists all customizable options for that individual file. Below you can see the list of common options. Please note that supported options are not limited to the list below and some of the scripts define options only valid for themselves.

    - **WIDTH:** Width of the slideshow, in pixels
    - **HEIGHT:** Height of the slideshow, in pixels
    - **FPS:** Frames per second value for the output video
    - **PHOTO DURATION:** Defines how long each photo will be displayed, excluding transition, in seconds
    - **TRANSITION DURATION:** Defines transition duration, in seconds
    - **BACKGROUND COLOR:** Defines background color. You can use short names like `black`, `white`; hex values in `0xYYYYYY` format like `0x265074`, `0xc4cdd4` or transparent color with `#00000000`. Refer to [color-syntax documentation](https://ffmpeg.org/ffmpeg-utils.html#color-syntax) for the details.

- `# PHOTO OPTIONS` section defines a command to select which photos will be included in the slideshow and in which order. Default value is `find ../photos/*`, which selects all files found in the `photos` directory. Order is not defined in default selection. To provide ordering it is possible to append `sort` at the end of `find` as in `find ../photos/* | sort`. Please refer to man pages of [find](http://man7.org/linux/man-pages/man1/find.1.html) and [sort](http://man7.org/linux/man-pages/man1/sort.1.html) for additional information.

If you want to learn more about how a specific script works refer to [v1.x](https://github.com/tanersener/ffmpeg-video-slideshow-scripts/tree/v1.x) branch of this repository. Scripts in `v1.x` branch are not customizable but easier to understand.


## Versions

- **v1.x branch:** Main focus of this branch is to show how `ffmpeg` filters work and how they can be used to implement a transition or animation. So scripts in this branch are mostly static and hard to customize.  
 
- **v2.x branch:** Scripts are optimized/rearranged in order to be customized. They are hard to understand but easy to customize.


## Updates

Refer to [Changelog](CHANGELOG.md) for updates.

## Known Issues

You may notice the following warnings when executing the scripts. Below you can find their reasons and possible fixes.

##### 1. 
>[swscaler @ 0x............] deprecated pixel format used, make sure you did set range correctly

This warning is printed because input image streams are decoded with `yuvj444p` pixel format, which is deprecated. 
You can safely ignore it, `ffmpeg` users are not effected from this warning.

##### 2.
>[out_0_0 @ 0x............] 100 buffers queued in out_0_0, something may be wrong.s dup=. drop=. speed=...

>[Parsed_overlay_80 @ 0x............] [framesync @ 0x............] Buffer queue overflow, dropping.

Statements inside `filter_complex` are ordered into logical groups to give a better understanding of how they work. 
In this ordering scheme too many streams/statements wait in the buffer queue, which generates these two warnings. 
If you want to resolve them change the order of statements inside `filter_complex` and use new streams immediately 
after they are created.

##### 3.
>Past duration 0.xyz too large

Currently `push_box` and `box_in` transitions print this warning. `setpts=0.5*PTS` statements used inside the scripts 
cause this. If you know how to remove it safely please submit an issue.


## Useful Links

[How to prevent shake effect for zoompan filter](https://trac.ffmpeg.org/ticket/4298)


## Contributing

Feel free to submit issues or pull requests.


## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) with the following exceptions.

Photos inside `photos` folder are published in the public domain. These photos are:

- [Colosseum](https://www.flickr.com/photos/134331036@N08/35674227104/) by [Klaus Berdiin Jensen](https://www.flickr.com/photos/134331036@N08/)

- [The Great Pyramid & Sphinx Eygpt](https://www.flickr.com/photos/130817154@N04/24211972286/) by [Dave Bright](https://www.flickr.com/photos/130817154@N04/)

- [Leaning Tower of Pisa](https://www.flickr.com/photos/image-catalog/19897194376/) by [Image Catalog](https://www.flickr.com/photos/image-catalog/)

- [Taj Mahal](https://www.flickr.com/photos/149013784@N08/32862668233/) by [juancolado3](https://www.flickr.com/photos/149013784@N08/)

- [chichen itza](https://www.flickr.com/photos/kanvc/15398655930/) by [kan_v_c](https://www.flickr.com/photos/kanvc/)

Snow flake and heart images inside `objects` folder are downloaded from [pngimg.com](http://pngimg.com/download/7553) and [pngimg.com](http://pngimg.com/download/687), both licensed under the [Creative Commons 4.0 BY-NC](https://creativecommons.org/licenses/by-nc/4.0).

Film strip images inside `objects` folder are modified from [Film Strip](https://commons.wikimedia.org/wiki/File:Film_strip.svg) by [Nevit Dilmen](https://commons.wikimedia.org/wiki/User:Nevit) and licensed under [Creative Commons Attribution-Share Alike 3.0 Unported](https://creativecommons.org/licenses/by-sa/3.0/deed.en).

Falling Sky font inside `fonts` folder is licensed under the [SIL Open Font License (OFL)](https://opensource.org/licenses/OFL-1.1).


## See Also

- [FFmpeg Filters](https://ffmpeg.org/ffmpeg-filters.html)
- [FFmpeg Filtering Guide](https://trac.ffmpeg.org/wiki/FilteringGuide)