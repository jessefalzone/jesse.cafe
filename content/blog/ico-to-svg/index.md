+++
title = "Converting .ICO Icons to .SVGs"
date = 2024-06-04
draft = true
description = ""

[taxonomies]
tags = ['windows 95', 'icons', 'svg', 'pixel art']
+++

<style>
.pixelated {
  image-rendering:pixelated;
  -ms-interpolation-mode:nearest-neighbor;
}
</style>

Recently I re-discovered the beauty (no, that's not sarcasm) of Windows 95
icons. I enjoy the simplicity of their styling, which was somewhat necessitated
by the fact that icons in
[Win32](https://en.wikipedia.org/wiki/Windows_API#Major_versions) generally had
8-bit color depth (256 colors) and a resolution of 48, 32, or 16 pixels square.
I'm sure it was a challenge in some cases to convey what was needed on such a
small canvas.

As an exercise I decided to convert the icons to Scalable Vector Graphics (SVG)
because infinitely scalable images are cool.

## WTF is ICO?

.ICO is a pretty cool format that can contain multiple icon images (in this case
Windows BMPs) with different resolutions and color depths. In Windows 95 the
icon variants had different purposes and were used in different places; a large
variant on the desktop, a small variant in a window title bar, etc.

{{ post_figure(
  path="my-computer-desktop.png",
  caption='"My Computer" icon variants on the Windows 95 desktop.',
  alt="The Windows 95 desktop showing various icon sizes."
) }}

As an example, let's take a look at the "My Computer" icon more closely. I used
ImageMagick's `convert` tool to extract each variant from the .ICO file and spit
out a couple .PNGs.

```bash
# Note: your command might be different.
# I was forced to use ImageMagick@6 on my old MacBook.
convert my_computer.ico my_computer.png
```

Here's what we get (enlarged 4x to show detail):

<img src="/static_images/my-computer-0.png" class="img--plain" width="128"
height="128"> <img src="/static_images/my-computer-1.png" class="img--plain"
width="64" height="64">

Notice that the smaller variant isn't just a scaled down version of the larger one
-- it's missing some details! That's pretty neat.

# Rasterization and Interpolation

The resulting PNGs are blurry. That's because these are
[raster graphics](https://en.wikipedia.org/wiki/Raster_graphics) and I've
upscaled them to 4 times their original size. Raster graphics are basically
pixels on a grid, so the pixels get stretched when an image is enlarged; a
browser, image editor, or operating system must "interpolate" or add missing
pixels into the empty spaces to create a cohesive image.

Firefox, for instance, uses a method called
[bilinear interpolation](https://en.wikipedia.org/wiki/Bilinear_interpolation),
in which an unknown pixel's color is determined by the weighted average of the
values of the nearest 2x2 grid of known pixels. That's
