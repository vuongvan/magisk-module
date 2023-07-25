25-07-2023

Patches: 2.186.4
 YouTube
==
- feat(youtube/hide-suggested-video-overlay): no longer dependent on `overlay-buttons` patches https://github.com/inotia00/ReVanced_Extended/issues/1210
- fix(youtube): remove dummy code
- fix(youtube): some fingerprints are located in the wrong path
- fix(youtube/enable-old-quality-layout): do not use low level filter anymore
- fix(youtube/hide-shorts-components): sometimes shorts shelves are not hidden
- fix(youtube/hide-suggested-actions): not hidden normally in some situations
- fix(youtube/overlay-buttons): remove unnecessary dependencies
- fix(youtube/swipe-controls): When `Press-to-swipe` is disabled
 
Integrations:  bump v0.114.4 
 
CLI:  - build: update dependencies
- build: move to official Google smali fork
- build: move to maven central apktool fork
- build: move to maven central revanced-patcher fork

※ support `--unsigned` and `--rip-lib` commands [j-hc/revanced-cli](https://github.com/j-hc/revanced-cli) 

YouTube version: 18.27.35
