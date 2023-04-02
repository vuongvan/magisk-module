02-04-2023

Patches: 2.168.1
 YouTube
==
- add `hide-channel-avatar-section` patch (Note: doesn't support tablet ui) https://github.com/inotia00/ReVanced_Extended/issues/608
- add `Hide shop button` settings (hide-button-container) https://github.com/inotia00/ReVanced_Extended/issues/620
- add `enable-tablet-navigation-bar` patch
- fix(general-ads): `Hide movies shelf` toggle also hides album cards from search results https://github.com/inotia00/ReVanced_Extended/issues/622
- fix(sponsorblock): segments not skipping during background play https://github.com/inotia00/ReVanced_Extended/issues/524
- fix(overlay-button): buttons are not hidden when swiping the seekbar https://github.com/inotia00/ReVanced_Extended/issues/504
- fix(protobuf-spoof): subtitles in wrong location (also fix https://github.com/inotia00/ReVanced_Extended/issues/481)
- refactor: change some default values
- refactor(protobuf-spoof): automatic spoofing protobuf
- refactor(protobuf-spoof): switch to whitelist method
- refactor(settings): change 'PivotBar' to '[Navigation Bar](https://m3.material.io/components/navigation-bar/guidelines)' in string resource and code (Even in the Android guidelines
 
Integrations:  bump v0.101.1 
 
CLI:  - update patcher dependencies

※ support `--unsigned` and `--rip-lib` commands [j-hc/revanced-cli](https://github.com/j-hc/revanced-cli)

YouTube version: 18.12.35
