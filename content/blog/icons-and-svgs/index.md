+++
title = "Windows 95 Icons and SVGs"
date = 2024-06-06
draft = false
description = "A dive into Windows 95 icons, ICO files, SVGs, and a tool I made to convert ICOs to SVGs on the command line."

[taxonomies]
tags = ['icons', 'projects', 'windows']
+++

<!-- markdownlint-disable MD033-->

(TL;DR; I made [a tool](https://github.com/jessefalzone/ico-to-svg) to batch
convert ICO icons to SVGs.)

{{ post_figure(
  path="my-computer-desktop.png",
  caption='"My Computer" icon variants on the Windows 95 desktop.',
  alt="The Windows 95 desktop showing various icon sizes."
) }}

Recently I re-discovered the beauty (no, that's not sarcasm) of Windows 95
icons. I enjoy the simplicity of their styling which, I assume, was somewhat
necessitated by the fact that icons in
[Win32](https://en.wikipedia.org/wiki/Windows_API#Major_versions) generally had
8-bit color depth (256 colors) and a resolution of 48, 32, or 16 pixels square.
I'm sure it was a challenge in some cases to convey what was needed on such a
small canvas.

To see more detail in the icons I set out to convert them to Scalable Vector
Graphics (SVG). As the name implies, SVGs are infinitely scalable with no
quality loss. At first I used [GIMP](https://www.gimp.org/) and
[Inkscape](https://inkscape.org/) with varying degrees of success. Those are
great programs but it was mostly a manual operation and I wanted to process over
600 icons. They both have command-line tools, but I found them pretty
unapproachable and not super fun to use.

I'd need to script my own solution! But before I get to that, let's talk about
icons and SVGs.

## An ICO Primer

Looking for some light reading? Microsoft still serves
[the original ICO docs](<https://learn.microsoft.com/en-us/previous-versions/ms997538(v=msdn.10)#whats-in-an-icon>)
from 1995.

ICO is a pretty cool format that can contain multiple icon images (in this case
Windows BMPs) with different resolutions and color depths. In Windows 95 the
icon variants had different purposes and were used in different places; a large
variant on the desktop, a small variant in a window title bar, etc.

Take the "My Computer" icon for example. I used
[ImageMagick](https://imagemagick.org/script/convert.php)'s `convert` tool to
extract each variant from the ICO file and spit out a couple PNGs. This command
will create a new image from each layer.

```bash
# Note: your command might be different.
# I was forced to use ImageMagick@6 on my old MacBook.
convert my_computer.ico my_computer.png
```

Now we have two PNG images (enlarged 4x to show detail):

<img src="/static_images/my-computer-0.png" width="128" height="128" alt="A
large, blurry My Computer icon." loading="lazy"> <img
src="/static_images/my-computer-1.png" width="64" height="64" alt="A small,
blurry My Computer icon." loading="lazy">

## Rasterization and Interpolation

But blast! The resulting PNGs are blurry. That's because these are
[raster graphics](https://en.wikipedia.org/wiki/Raster_graphics) and I've
upscaled them to 4 times their original size. Raster graphics are basically
pixels baked onto a grid. Those pixels get stretched apart when an image is
enlarged; a browser, image editor, or operating system must "interpolate" or add
missing pixels into the empty spaces to create a cohesive image.

Firefox, for instance, uses a method called
[bilinear interpolation](https://en.wikipedia.org/wiki/Bilinear_interpolation),
in which an unknown pixel's color is determined by the weighted average of the
values of the nearest 2x2 grid of known pixels.

## CSS Image Rendering

Interpolation is great for photographs but we're dealing with pixel art here.
Can we turn off interpolation in the browser and just tell it to make the pixels
"bigger"? Yes, with some CSS!

Let's add a class to those images and use the
[image-rendering](https://developer.mozilla.org/en-US/docs/Web/CSS/image-rendering)
property:

```css
.pixelated {
  image-rendering: pixelated; /* Modern browsers */
  -ms-interpolation-mode: nearest-neighbor; /* Internet Explorer, lol */
}
```

These should look much better now, assuming you're using a browser from this
decade. (They still might be blurry in RSS readers.)

<img src="/static_images/my-computer-0.png"
style="image-rendering:pixelated;-ms-interpolation-mode:nearest-neighbor;"
width="128" height="128" alt="A large My Computer icon." loading="lazy"> <img
src="/static_images/my-computer-1.png"
style="image-rendering:pixelated;-ms-interpolation-mode:nearest-neighbor;"
width="64" height="64" alt="A small My Computer icon." loading="lazy">

Nice and crisp. Zoom in your browser window and you'll see the image will never
get blurry. Notice that the smaller variant isn't just a scaled down version of
the larger one -- it's missing some details! That's pretty neat.

## SVGs are Pretty Rad

I suppose I could stop there but the goal was to end up with SVGs. As mentioned
above, SVG stands for Scalable Vector Graphics. As opposed to raster images that
use pixels, vectors use math to generate shapes.

There are several benefits:

- They are infinitely scalable, even with complex shapes and curves.
- SVG files are written in XML, which appeals to the web developer in me.
- They can be manipulated with CSS.
- They are easily compressed without quality loss.
- They can be animated with JavaScript or CSS.
- Their file sizes are usually smaller than their image counterparts and the
  file size stays the same even if you increase the size of the image.

A simple example...

```html
<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="50" fill="#008080" />
</svg>
```

...that generates a nice circle:

<svg width="100" height="100" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="50" fill="#008080" />
</svg>

## Scripting the Conversion

Back to the ICO -> SVG conversion. I wrote a quick Node.js script to batch
process the icons. My requirements were as follows:

1. Accept an ICO file and/or a directory as an argument.
1. If a directory was specified, recursively search that directory for ICOs.
1. Deconstruct each ICO into its icon variants.
1. Convert each variant to a pixel-perfect SVG.
1. Save SVGs to the specified directory.

So as not to reinvent the wheel, I leveraged some great NPM libraries to get
this done. I used [icojs](https://www.npmjs.com/package/icojs) to separate the
ICO variants into buffered PNGs. Why PNG? Because they're lossless and they
support an alpha channel for transparency. Then I fed that into
[pixel-perfect-svg](https://www.npmjs.com/package/pixel-perfect-svg) to extract
pixels from the PNG buffer and convert them to vectors.

I haven't published it to NPM yet, but for now head over to the
[GitHub repo](https://github.com/jessefalzone/ico-to-svg) to get the code.

## The Result

<img src="/static_images/my-computer-0.svg" width="128" height="128" alt="A
large SVG My Computer icon." loading="lazy"> <img
src="/static_images/my-computer-1.svg" width="64" height="64" alt="A small SVG
My Computer icon." loading="lazy">

Boom! This was a fun little project. Yes they look the same as the PNG without
interpolation, but now I don't need extra CSS to maintain the pixelated effect.
I can properly zoom in and appreciate each pixel. Stay tuned for more on that.
