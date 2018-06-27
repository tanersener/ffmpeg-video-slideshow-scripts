# FFmpeg Video Slideshow Scripts

Shell scripts to create video slideshows from images using [ffmpeg](https://www.ffmpeg.org/).


## Features
- [Transition scripts](transition_scripts) 
- [Advanced scripts](advanced_scripts)


## Requirements

- `ffmpeg 2.8.x` or later

Advanced 'Moving Text' script needs ffmpeg to be build with freetype. 
If you compile ffmpeg from source you need to provide `--enable-libfreetype` flag on `./configure`. 
Under macOS, ffmpeg is available under [Homebrew](https://brew.sh/), 
you can install it using `--with-freetype` option, aka `brew install ffmpeg --with-freetype`.


## Description

Each script creates a video slideshow using 5 photos inside `photos` folder. 
Advanced scripts use additional objects & fonts from their respective folders. 
Output slideshow is an h264 encoded 1280x720 px MPEG-4 video.

Scripts use the following scene arrangement.
```
photo 1 - 3 seconds
- transition to photo 2 - 1 second
photo 2 - 2 seconds
- transition to photo 3 - 1 second
photo 3 - 2 seconds
- transition to photo 4 - 1 second
photo 4 - 2 seconds
- transition to photo 5 - 1 second
photo 5 - 2 seconds
=======
Total = 15 seconds
```

## Tips

- Input images are scaled to fit the screen using `scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))'` formula. 
As an alternative, cropping input images can be implemented by replacing the scale statement with `crop=min(iw\,1280):min(ih\,720)`.


## Known Issues

You may notice the following warnings when executing the scripts. Below you can find their reasons and possible fixes.

>[swscaler @ 0x............] deprecated pixel format used, make sure you did set range correctly

This warning is printed because input image streams are decoded with `yuvj444p` pixel format, which is deprecated. 
You can safely ignore it, `ffmpeg` users are not effected from this warning.

>[out_0_0 @ 0x............] 100 buffers queued in out_0_0, something may be wrong.s dup=. drop=. speed=...

>[Parsed_overlay_80 @ 0x............] [framesync @ 0x............] Buffer queue overflow, dropping.

Statements inside `filter_complex` are ordered into logical groups to give a better understanding of how they work. 
In this ordering scheme too many streams/statements wait in the buffer queue, which generates these two warnings. 
If you want to resolve them change the order of statements inside `filter_complex` and use new streams immediately 
after they are created.


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
