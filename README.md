# Mpv-Script

Add audio and subtitles from subfolders to a video in mpv.

## How to install

Copy the `scripts` folder from this repository into your mpv configuration directory.

## Default configuration directories

**Linux**
```
~/.config/mpv/
```

**Windows**
```
%APPDATA%\mpv\
```

**macOS**
```
~/Library/Application Support/mpv/
```

## How it works

The script searches for audio and subtitle tracks in separate folders and automatically loads the matching files.

### Folder structure

<p align="center">
  <img src="screenshots/1.png" width="700">
</p>

### Result in mpv

| Before | After |
|--------|-------|
| <img src="screenshots/before.png"> | <img src="screenshots/after.png"> |
