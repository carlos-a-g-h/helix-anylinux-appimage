# Helix-Anylinux-AppImage

[![GitHub Downloads](https://img.shields.io/github/downloads/carlos-a-g-h/helix-anylinux-appimage/total?logo=github&label=GitHub%20Downloads)](https://github.com/carlos-a-g-h/helix-anylinux-appimage/releases/latest)

[![CI Build Status](https://github.com//carlos-a-g-h/helix-anylinux-appimage/actions/workflows/appimage.yml/badge.svg)](https://github.com/carlos-a-g-h/helix-anylinux-appimage/releases/latest)

## About Helix

[Helix](https://github.com/helix-editor/helix) is a terminal-based modal text editor similar to Vim/NeoVim, but it does not uses vim-motions, it uses its own set of motions similar to the Vim ones, but with an emphasis on more ergonomics

## About this specific AppImage

This AppImage is made using [official binaries](https://github.com/helix-editor/helix/releases) from the official releases

The appimages made on this repo are NON-OFFICIAL. Helix already releases their own appimages, but they do not run on older systems, and that is why I made this repository, because I use an older system that does not run newer versions of Helix. The AppImages is made using a set of tools called AnyLinux, more info about this at the end of this README file

## Internal commands

```
./Helix.AppImage [COMMAND] [ARGs...]
```

This AppImage has internal scripts and programs that can be launched by calling them as commandline arguments

|Program or script|Description|
|-|-|
| setup | An "installation" script for the appimage. It provides a nice config, a DESKTOP file in /usr/share/applications and an icon |
| details | Extracts the "details" directory from the AppImage |
| set-env-runtime | writes an ENV file for the appimage with the path to a different runtime directory |
| ext-def-runtime | extracts the contents of the default runtime directory to a different directory |

NOTE: The --config argument in the setup script copies the runtime and contrib directories to the config directory, the scripts "ext-def-runtime" and "ext-def-runtime" handle runtime paths that can be located elsewhere

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
