# FFmpeg Video Slideshow Scripts

Shell scripts to create video slideshows from images using [ffmpeg](https://www.ffmpeg.org/).


## Features
- [Transition scripts](transition_scripts/README.md) 
- [Text scripts](text_scripts/README.md)
- [Special scripts](special_scripts/README.md)


## Requirements

Nearly all scripts should be working on `ffmpeg 2.8.x` or later. A few scripts use some new properties defined in `ffmpeg 3.x`.

**Note:** Text scripts need ffmpeg to be build with freetype. If you compile ffmpeg from source you need to provide `--enable-libfreetype` flag on `./configure`. Under macOS, ffmpeg is available under [Homebrew](https://brew.sh/), you can install it using `--with-freetype` option, aka `brew install ffmpeg --with-freetype`.


## Description

Each script under this project creates a video slideshow using 5 photos provided. Slideshow has 1280x720 dimensions and duration of 15 seconds (3 seconds for each photo).

Input images are scaled to fit into 1280x720 dimensions using `scale=w='if(gte(iw/ih,1280/720),min(iw,1280),-1)':h='if(gte(iw/ih,1280/720),-1,min(ih,720))'` formula. Alternatively cropping input images can be implemented by replacing scale statement with `crop=min(iw\,1280):min(ih\,720)`.


## Known Issues

You may notice the following warnings when executing the scripts. Below you can find their reasons and possible fixes.

- **[swscaler @ 0x............] deprecated pixel format used, make sure you did set range correctly**

This warning is printed because input image streams are decoded with "yuvj444p" pixel format, which is deprecated. You can safely ignore it, `ffmpeg` users are not effected from this warning.

- **[out_0_0 @ 0x............] 100 buffers queued in out_0_0, something may be wrong.s dup=. drop=. speed=...**

  **[Parsed_overlay_80 @ 0x............] [framesync @ 0x............] Buffer queue overflow, dropping.**

Statements inside filter_complex are ordered into logical groups to give a better understanding of how they work. In this ordering scheme, too many streams/statements wait in the buffer queue; which generates these two warnings. You can fix them by changing the order of statements inside filter_complex; by using new streams immediately after they are created.


## License
This project is licensed under the MIT License.
```
Copyright 2018 (c) Taner Sener

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

Scripts provided in this project use 5 photos (under `photos` folder) published in the ![Public Domain](https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Public_Domain_Mark_button.svg/88px-Public_Domain_Mark_button.svg.png "Public Domain"). These photos are:

- [Colosseum](https://www.flickr.com/photos/134331036@N08/35674227104/) by [Klaus Berdiin Jensen](https://www.flickr.com/photos/134331036@N08/)

- [The Great Pyramid & Sphinx Eygpt](https://www.flickr.com/photos/130817154@N04/24211972286/) by [Dave Bright](https://www.flickr.com/photos/130817154@N04/)

- [Leaning Tower of Pisa](https://www.flickr.com/photos/image-catalog/19897194376/) by [Image Catalog](https://www.flickr.com/photos/image-catalog/)

- [Taj Mahal](https://www.flickr.com/photos/149013784@N08/32862668233/) by [juancolado3](https://www.flickr.com/photos/149013784@N08/)

- [chichen itza](https://www.flickr.com/photos/kanvc/15398655930/) by [kan_v_c](https://www.flickr.com/photos/kanvc/)


## See Also

- [FFmpeg Filters](https://ffmpeg.org/ffmpeg-filters.html)
- [FFmpeg Filtering Guide](https://trac.ffmpeg.org/wiki/FilteringGuide)