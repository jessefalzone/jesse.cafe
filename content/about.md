+++
title = "About"
description = "About me and jesse.cafe."
+++

Howdy. On this page you can learn a bit more about me and how I've configured
jesse.cafe.

{{ toc() }}

## About Me

{{ resize_image(path="/static_images/avatar.jpeg", alt="A picture of me.", width=150,
height=150, op="scale", format="webp", quality=50, class="img--shadow") }}

### Interests

I'm a curious person by nature so I have lots of interests. Here are a few:

- 90s computing (e.g. Windows 95)
- Traditional hand-tool woodworking
- Semantic HTML
- Exploring old graveyards
- Environmental protection
- Watches
- Various [90s aesthetics](https://www.are.na/evan-collins-1522646491/channels)
- Baking bread and pizza
- The ocean
- [Solar power](https://solar.lowtechmagazine.com/)
- German beer
- Hiking

Maybe someday I'll blog about those.

### Work Stuff

- **Chief Technology Officer** @ Dapt, 2023 - 2024
- **Director of Application Development** @ Critical Mention, 2020 - 2023
- **Team Lead, Senior Software Engineer** @ Critical Mention, 2016 - 2020
- **Full-Stack Software Engineer** @ Critical Mention, 2014 - 2016
- **Software Engineer Intern** @ Logikcull, 2013

## About This Site

This site is my small contribution to the free and open internet. Originally I
set out to create a simple resume page, but I came across some awesome personal
blogs that inspired me to have a go at writing down my thoughts. I found most of
them through [the 250KB Club](https://250kb.club/) and [the 512KB
Club](https://512kb.club/). They're like-minded people who feel the web has
become too bloated and want to prioritize performance and accessibility.

### Tech

I built jesse.cafe with a Rust library called [Zola](https://getzola.org) and it
is hosted on [Cloudflare Pages](https://pages.cloudflare.com/). My goal is to
make each page as small and fast as possible. There are no bloated CSS or
JavaScript libraries.

The only JavaScript is a small snippet on the [Contact](@/contact.md) page that
hides my email address from bots. Feel free to disable JavaScript! I might
remove this in the future.

I did my best to adhere to best practices and respect visitors. It's a living
document, so I'm always tweaking and improving. Below are a few highlights so
far.

#### Performance

It's fast.

- [PageSpeed Insights](https://pagespeed.web.dev/analysis/https-jesse-cafe/w4vhakv0yw?form_factor=desktop)
- [Yellow Lab Tools report](https://yellowlab.tools/result/gwxqdi0scw)

Most images in the blog are in WebP format at 50% quality to keep file sizes
low. You can click on an image to see it in full quality and in the original
format.

#### Sustainability

The carbon footprint is low.

- [Website Carbon](https://www.websitecarbon.com/website/jesse-cafe/)
- [Ecograder](https://ecograder.com/report/rWv0s51g4yZ9VbMWNV75FAcX)
- Hosted using [green
  energy](https://www.thegreenwebfoundation.org/green-web-check/?url=https%3A%2F%2Fjesse.cafe).

<img
src="https://app.greenweb.org/api/v3/greencheckimage/jesse.cafe?nocache=true"
alt="This website runs on green hosting - verified by thegreenwebfoundation.org"
width="200px" height="95px">

#### Security and Privacy

- There are no
  [trackers](https://themarkup.org/blacklight?url=jesse.cafe&device=desktop&location=us&force=false),
  cookies,
  or ads.
- I've added the recommended [security
  headers](https://securityheaders.com/?q=jesse.cafe&followRedirects=on).
- It's
  [HTTPS-only](https://radar.cloudflare.com/scan/6556cbec-1297-4a12-ad89-c75849a45ddf/technology).

### Styling and Other Choices

#### Domain Name

I chose the `.cafe` top-level domain to reflect the early internet's utopian
ideals of community, accessibility, and the free exchange of ideas. Also I like
coffee.

#### Favicon

<img src="/icon.svg" alt="This site's favicon, a desktop icon."
width="128" height="128">

The favicon is an SVG of a desktop icon from Windows 95. As I intend to use this
site as a creative outlet, and I have a similar [Luxo
lamp](<https://en.wikipedia.org/wiki/Luxo_Jr._(character)>) on my desk, I
thought it was fitting.

#### Color and Font

The color scheme is loosely based on [Dracula](https://draculatheme.com/)
(especially dark mode). Light/dark mode follows your system preference.

The font stack for normal text is `'Lucida Grande', 'Lucida Sans Unicode',
  'Lucida Sans', Geneva, 'Gill Sans Nova', Verdana, Ubuntu, system-ui,
sans-serif`. On most Macs and PCs you'll see one of the Lucida variations, which
is my preference. I think Lucida Grande is more interesting than other
sans-serif fonts and elicits fun memories of computing; it was the system font
on macOS from 1999 to 2014. Monospace fonts are `'Lucida Console', Menlo, Monaco,
monospace`. There are no external fonts that would slow down page load.
