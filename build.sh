#!/usr/bin/env bash

set -eu -o pipefail

source build.conf
source utils.sh

print_usage() {
	echo -e "Usage:\n${0} build|clean|reset-template"
}

if [ -z ${1+x} ]; then
	print_usage
	exit 0
elif [ "$1" = "clean" ]; then
	rm -rf revanced-cache build.log build
	exit 0
elif [ "$1" = "reset-template" ]; then
	exit 0
elif [ "$1" = "build" ]; then
	:
else
	print_usage
	exit 1
fi

: >build.log
log "$(date +'%d-%m-%Y')\n"
mkdir -p "$BUILD_DIR" "$TEMP_DIR"

if [ "$UPDATE_PREBUILTS" = true ]; then get_prebuilts; else set_prebuilts; fi


if [ "$BUILD_YT" = true ]; then build_yt; fi
if [ "$BUILD_MUSIC_ARM64_V8A" = true ]; then build_music $ARM64_V8A; fi
if [ "$BUILD_MUSIC_ARM_V7A" = true ]; then build_music $ARM_V7A; fi
if [ "$BUILD_TWITTER" = true ]; then build_twitter; fi
if [ "$BUILD_REDDIT" = true ]; then build_reddit; fi
if [ "$BUILD_WARN_WETTER" = true ]; then build_warn_wetter; fi
if [ "$BUILD_TIKTOK" = true ]; then build_tiktok; fi


echo "Done"
