11-03-2023

Patches: 2.164.21
 YouTube
==
- add `hide-shorts-pivot-bar` patch (`Experimental Flags`) https://github.com/inotia00/ReVanced_Extended/issues/110
- add `hide-music-button` patch https://github.com/inotia00/ReVanced_Extended/issues/401
- add `Hide thanks button`(in comments section) https://github.com/inotia00/ReVanced_Extended/issues/423
- fix: `hide-collapse-button` patch is not reflected in patch information
- fix(default-video-quality): treat any connection as wifi except mobile and bluetooth
- fix(litho): `Hide movies shelf` doesn't hide the movie shelf from related video https://github.com/inotia00/ReVanced_Extended/issues/427
- fix(litho): some layouts from `Hide feed surveys` are left in the home feed
- fix(return-youtube-dislike): voteFetch sometimes fails on shorts player
- refactor(litho): minor optimization
- refactor: simplify SharedPrefHelper class
- crowdin translation update
`Arabic`
 
Integrations:  bump v0.99.21 
 
CLI:  - update patcher dependencies

※ support `--unsigned` and `--rip-lib` commands [j-hc/revanced-cli](https://github.com/j-hc/revanced-cli)

YouTube version: 18.09.37
