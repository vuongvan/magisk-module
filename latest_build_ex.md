04-04-2023

Patches: 2.168.12
 YouTube
==
- improve(overlay-button): remove the animation of the button showing after tapping the seekbar https://github.com/inotia00/ReVanced_Extended/issues/631
- fix(hide-shorts-component): subscribe button sometimes not hidden after playing general video https://github.com/inotia00/ReVanced_Extended/issues/639
- fix(protobuf-spoof): subtitles are still on top in some videos https://github.com/inotia00/ReVanced_Extended/issues/636
- fix(sponsorblock): autoplay stops when sponsorblock skips at the end of the video https://github.com/inotia00/ReVanced_Extended/issues/547
- fix(sponsorblock): slight delay when the device wakes up from deep sleep if the current video speed is not 1.0x
- refactor(protobuf-spoof): add support protobuf spoofing in feeds https://github.com/inotia00/ReVanced_Extended/issues/633
- remove `Hide official cards` setting (removed from server side)
- update ad filter
- crowdin translation update
`Bulgarian`
 
Integrations:  bump v0.101.12
 
CLI:  - update patcher dependencies

※ support `--unsigned` and `--rip-lib` commands [j-hc/revanced-cli](https://github.com/j-hc/revanced-cli)

YouTube version: 18.12.35
