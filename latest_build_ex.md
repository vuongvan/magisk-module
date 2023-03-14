14-03-2023

Patches: 2.164.30
 YouTube
==
- add `lift-vertical-video-restriction` patch (Experimental Flags) https://github.com/orgs/revanced/discussions/929
- add `disable-quic-protocol` patch (Experimental Flags)
- add `protobuf-spoof` patch (it fixes playback buffer issue https://github.com/inotia00/ReVanced_Extended/issues/141 https://github.com/microg/GmsCore/issues/1870)
- feat(youtube/general-ads): hide new type of ad
- fix: `Hide more information menu` setting is broken https://github.com/inotia00/ReVanced_Extended/issues/456
- fix: `default-video-speed` patch fails in YouTube v18.08.39 https://github.com/inotia00/ReVanced_Extended/issues/470
- fix: `enable-timestamps-speed` patch is not reflected in patch information
- fix: reboot dialog is missing in `Default downloader settings`
- fix(sponsorblock): context broken on [segment submission](https://www.reddit.com/r/revancedextended/comments/11pgnbh/12_im_too_stupid_to_submit_the_issue_on_github_so/)
- fix(hide-shorts-component): glitch when there are a lot of shorts component blocked in search results
- refactor(hide-shorts-component): check current PlayerType when blocking shorts player component
- refactor(litho): minor optimization
- rollback(default-video-speed): default video speed does not apply when playing live video
- crowdin translation update
`Arabic`
 
Integrations:  bump v0.99.30
 
CLI:  - update patcher dependencies

※ support `--unsigned` and `--rip-lib` commands [j-hc/revanced-cli](https://github.com/j-hc/revanced-cli)

YouTube version: 18.09.39
