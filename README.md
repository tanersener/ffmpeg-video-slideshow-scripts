# FFmpeg Video Slideshow Scripts [![Join the chat at https://gitter.im/ffmpeg-video-slideshow-scripts/Lobby](https://badges.gitter.im/ffmpeg-video-slideshow-scripts/Lobby.svg)](https://gitter.im/ffmpeg-video-slideshow-scripts/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

Shell scripts to create video slideshows from images using [FFmpeg](https://www.ffmpeg.org/).

<img src="https://github.com/tanersener/ffmpeg-video-slideshow-scripts/blob/master/docs/ffmpeg-video-slideshow-scripts-logo-v1.png" width="240">

## Features
- [Transition scripts](transition_scripts) 
- [Advanced scripts](advanced_scripts)


## Requirements

- `ffmpeg 2.8.x` or later

`Advanced Moving Text` script needs `FFmpeg` to be build with `freetype`. If you compile FFmpeg from source you need to provide `--enable-libfreetype` flag on `./configure`. 


## Description

Each script creates a video slideshow using 5 photos inside `photos` folder. Transition scripts 
implements different transition effects and advanced scripts implements more complex animation like 
transitions/transformations.

Output of all scripts is an `h264` encoded `1280x720` px `MPEG-4` video.


## Scene Arrangement
  
Most of the scripts use the following scene arrangement.
```
show photo 1 - 2 seconds
- transition to photo 2 - 1 second
show photo 2 - 2 seconds
- transition to photo 3 - 1 second
show photo 3 - 2 seconds
- transition to photo 4 - 1 second
show photo 4 - 2 seconds
- transition to photo 5 - 1 second
show photo 5 - 2 seconds
=======
Total = 15 seconds
```


## Customization

Scripts in this branch are mostly static and hard to customize. It is possible to change the photos used by replacing files under `photos` folder but other than that there are not any parameters/options defined to customize the slideshow.

If you need to customize scripts please refer to [v2.x](https://github.com/tanersener/ffmpeg-video-slideshow-scripts/tree/v2.x) branch of this repository.


## Versions

- **v1.x branch:** Main focus of this branch is to show how `ffmpeg` filters work and how they can be used to implement a transition or animation. So scripts in this branch are mostly static and hard to customize.  
 
- **v2.x branch:** Scripts are optimized/rearranged in order to be customized. They are hard to understand but easy to customize.


## Updates

Refer to [Changelog](CHANGELOG.md) for updates.


## Tips

- Input images are scaled to fit the screen using `scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))'` formula. 
As an alternative, cropping input images can be implemented by replacing the scale statement with `crop=min(iw\,1280):min(ih\,720)`.


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
