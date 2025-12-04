# Helix-Anylinux-AppImage

[![GitHub Downloads](https://img.shields.io/github/downloads/carlos-a-g-h/helix-anylinux-appimage/total?logo=github&label=GitHub%20Downloads)](https://github.com/carlos-a-g-h/helix-anylinux-appimage/releases/latest)

[![CI Build Status](https://github.com//carlos-a-g-h/helix-anylinux-appimage/actions/workflows/appimage.yml/badge.svg)](https://github.com/carlos-a-g-h/helix-anylinux-appimage/releases/latest)

Download the latest release [here](https://github.com/carlos-a-g-h/helix-anylinux-appimage/releases/latest)

## What is the AnyLinux project?

---

AppImage made using [sharun](https://github.com/VHSgunzo/sharun), which makes it extremely easy to turn any binary into a portable package without using containers or similar tricks.

**This AppImage bundles everything and should work on any linux distro, even on musl based ones.**

This AppImage can work **without FUSE** at all thanks to the [uruntime](https://github.com/VHSgunzo/uruntime)

More at: [AnyLinux-AppImages](https://carlos-a-g-h.github.io/Anylinux-AppImages/)

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
  </a>
</details>

## About Helix

Helix is a terminal-based modal text editor similar to Vim/NeoVim, but it does not uses vim-motions, it uses its own set of motions similar to the Vim ones, but with an emphasis on more ergonomics

The official repository is [this one](https://github.com/helix-editor/helix)

## About this specific appimage

The appimages are made using the official binaries from the official releases

The appimages made on this repo are NON-OFFICIAL. Helix already releases their own appimages, but they do not run on older systems, and that is why I made this repository, because I use an older system that does not run newer versions of Helix

## Internal commands

```
./Helix.AppImage [COMMAND] [ARGs...]
```

This appimage has 2 internal commands that handle Helix's runtime directory. By default, Helix will only use the runtime directory that is inside the AppImage

→ set-env-runtime

This command writes an ENV file for the appimage with the path to a different runtime directory

→ ext-def-runtime

This command extracts the contents of the default runtime directory to a different directory
