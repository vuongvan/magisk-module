01-05-2023

Patches: 2.171.4
 YouTube
==
- add `hide-get-premium` patch https://github.com/revanced/revanced-patches/issues/1984
- add `custom-branding-icon-manual` patch [more information](https://github.com/inotia00/revanced-documentation/wiki/Options-Information-about-the-patchif-you-want-a-custom-icon-only-available-on-cli)
- add `custom-double-tap-length` patch
- feat(client-spoof): removed from patch list and dependent on `microg-support` patch
- feat(hide-general-ads): add `Hide audio track button` settings https://github.com/revanced/revanced-patches/issues/1984
- feat(hide-cast-button): no longer dependent on `microg-support` patch https://github.com/inotia00/ReVanced_Extended/issues/866
- feat(protobuf-spoof): update strings resources
- feat(spoof-app-version): rename patch (`enable-old-layout` → `spoof-app-version`)
- feat(spoof-app-version): user selectable version to spoof
- fix(overlay-buttons): repeat button in playlist cannot changed https://github.com/inotia00/ReVanced_Extended/issues/836
- fix(custom-video-speed): crash due to invalid key https://github.com/inotia00/ReVanced_Extended/issues/911
- refactor(patch-options): remove `OverlayButtonsIcon`
 
Integrations:  bump v0.105.4 
 
CLI:  - update patcher dependencies

※ support `--unsigned` and `--rip-lib` commands [j-hc/revanced-cli](https://github.com/j-hc/revanced-cli)

YouTube version: 18.16.39
