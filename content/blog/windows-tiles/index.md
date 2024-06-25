+++
title = "Classic Windows Wallpaper Tiles"
description = "Appreciating tiled wallpaper from classic Windows."
date = 2024-06-25
draft = false

[taxonomies]
tags = ['projects','ui','windows']
+++

I have slapped together a [small demo](https://tiles.jesse.cafe) of the various
tiled and patterned wallpapers that were available in classic versions of the
Windows operating system.

If you weren't aware, Windows (XP and below, I think) used to ship with
tessellated wallpapers -- small images that were repeated along the X and Y axes
to cover your desktop, rather than one large hi-resolution image. I think
they're pretty cool.

{{ post_figure(path="party.png", alt="A screenshot of the Party wallpaper.",
caption='"Party" from Windows 3.0. Wild!') }}

{{ post_figure(path="arcade.png", alt="A screenshot of the Arcade wallpaper.",
caption='"Arcade" from Windows 3.1.') }}

As an exercise, I decided to set the background image of `<body>` and switch it
with only CSS by taking advantage of the `:has()` and `:checked` pseudo-classes.
And of course, tessellation is achieved with the `background-repeat` property,
which is set to `repeat` by default.

```scss
body:has(option[value="Windows_30_Party"]:checked) {
  background-image: url("./images/Windows_3.0/Party.webp");
}
```

That's all. [Check out the demo here](https://tiles.jesse.cafe).
