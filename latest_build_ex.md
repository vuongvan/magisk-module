24-07-2023

Patches: 2.186.1
 YouTube
==
- feat(youtube): add support version `v18.27.35`
- feat(youtube): add `hide-suggested-video-overlay` patch https://github.com/inotia00/ReVanced_Extended/issues/1197
- feat(youtube): change `video-speed` to `playback-speed` https://github.com/inotia00/revanced-patches/pull/13
- feat(youtube): generate an exception when an invalid options is entered
- feat(youtube/custom-seekbar-color): apply custom seekbar color to shorts https://github.com/inotia00/ReVanced_Extended/issues/1104
- feat(youtube/hide-general-ads): hide new type of ads
- feat(youtube/hide-layout-components): change the default value of `Hide expandable chip under video` https://github.com/inotia00/ReVanced_Extended/issues/1135
- feat(youtube/hide-shorts-components): shorts header is not blocked on some shorts shelves [ScreenShot](https://imgur.com/a/Z81TCYm)
- fix(youtube/custom-branding-youtube-name): takes too long to apply the patch in the RVX Manager
- fix(youtube/overlay-buttons): `Disable playlist autoplay` loops video in minimized and PiP mode https://github.com/inotia00/ReVanced_Extended/issues/1092
- fix(youtube/return-youtube-dislike): dislikes not showing in some situations https://github.com/inotia00/ReVanced_Extended/issues/1167
- fix(youtube/sponsorblock): some segments skipping slightly too late https://github.com/inotia00/ReVanced_Extended/issues/1144 https://github.com/inotia00/ReVanced_Extended/issues/1152
- feat(youtube/translations): update translation
`Arabic`
 
Integrations:  bump v0.114.1 
 
CLI: - build: update dependencies
- build: move to official Google smali fork
- build: move to maven central apktool fork
- build: move to maven central revanced-patcher fork

※ support `--unsigned` and `--rip-lib` commands [j-hc/revanced-cli](https://github.com/j-hc/revanced-cli)

YouTube version: 18.27.35
