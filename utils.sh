#!/usr/bin/env bash -e

source semver

TEMP_DIR="temp"
BUILD_DIR="build"

ARM64_V8A="arm64-v8a"
ARM_V7A="arm-v7a"
GITHUB_REPOSITORY=${GITHUB_REPOSITORY:-$"vuongvan/magisk-module"}
WGET_HEADER="User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0"


notset() {
	case $1 in '') return 0 ;; *) return 1 ;; esac
}

get_prebuilts() {
	echo "Getting prebuilts"
	RV_CLI_URL_REPO="https://api.github.com/repos/inotia00/revanced-cli/releases/latest"
	RV_PATCHES_URL_REPO="https://api.github.com/repos/inotia00/revanced-patches/releases/latest"
	RV_INTEGRATIONS_URL_REPO="https://api.github.com/repos/inotia00/revanced-integrations/releases/latest"
	RM_URL=https://vuongvan.github.io/VancedManager/rvmn.apk
	MG_URL=https://github.com/inotia00/VancedMicroG/releases/latest/download/microg.apk
	
	RV_CLI_DATA=$(req $RV_CLI_URL_REPO - )
	echo $RV_CLI_DATA >> cli_data.txt
	RV_CLI_URL=$(cat cli_data.txt | tr -d ' ' | sed -n 's/.*"browser_download_url":"\(.*jar\)".*/\1/p')
	RV_CLI_JAR="${TEMP_DIR}/${RV_CLI_URL##*/}"
	
	RV_INTEGRATIONS_DATA=$(req $RV_INTEGRATIONS_URL_REPO - )
	echo $RV_INTEGRATIONS_DATA >> intergrations_data.txt
	RV_INTEGRATIONS_URL=$(cat intergrations_data.txt | tr -d ' ' | sed -n 's/.*"browser_download_url":"\(.*apk\)".*/\1/p')
	RV_INTEGRATIONS_APK=${RV_INTEGRATIONS_URL##*/}
	RV_INTEGRATIONS_APK="${TEMP_DIR}/${RV_INTEGRATIONS_APK%.apk}-$(cut -d/ -f8 <<<"$RV_INTEGRATIONS_URL").apk"
	
	RV_PATCHES_DATA=$(req $RV_PATCHES_URL_REPO - )
	echo $RV_PATCHES_DATA >> patches_data.txt
	RV_PATCHES_URL=$(cat patches_data.txt | tr -d ' ' | sed -n 's/.*"browser_download_url":"\(.*jar\)".*/\1/p')
	RV_PATCHES_JAR="${TEMP_DIR}/${RV_PATCHES_URL##*/}"
	local rv_patches_filename=${RV_PATCHES_JAR#"$TEMP_DIR/"}
	rv_patches_ver=${rv_patches_filename##*'-'}
	
	RM_APK="${TEMP_DIR}/rvmn.apk"
	MG_APK="${TEMP_DIR}/microg.apk"
	
	get_changelogs patches_data.txt
	log "Patches: ${rv_patches_ver::-4}"
	log "$get_chlogs"
	get_changelogs intergrations_data.txt
	log " \nIntegrations: $get_chlogs"
	get_changelogs cli_data.txt
	log " \nCLI: $get_chlogs"
	
	dl_if_dne "$RV_CLI_JAR" "$RV_CLI_URL"
	dl_if_dne "$RV_INTEGRATIONS_APK" "$RV_INTEGRATIONS_URL"
	dl_if_dne "$RV_PATCHES_JAR" "$RV_PATCHES_URL"
	dl_if_dne "$RM_APK" "$RM_URL"
	dl_if_dne "$MG_APK" "$MG_URL"
}

get_changelogs() { 
	get_chlogs=$(cat $1 | tr -d '"' | tr -d '#' | tr -d '}'| sed 's/\\n\\n/\\n/g' | sed 's/\\n\\n/\\n/g')
	get_chlogs=${get_chlogs##*body:}
	get_chlogs=${get_chlogs%%,*}
}

abort() { echo "abort: $1" && exit 1; }

set_prebuilts() {
	[ -d "$TEMP_DIR" ] || abort "${TEMP_DIR} directory could not be found"
	RV_CLI_JAR=$(find "$TEMP_DIR" -maxdepth 1 -name "revanced-cli-*" | tail -n1)
	[ -z "$RV_CLI_JAR" ] && abort "revanced cli not found"
	log "CLI: ${RV_CLI_JAR#"$TEMP_DIR/"}"
	RV_INTEGRATIONS_APK=$(find "$TEMP_DIR" -maxdepth 1 -name "app-release-unsigned-*" | tail -n1)
	[ -z "$RV_CLI_JAR" ] && abort "revanced integrations not found"
	log "Integrations: ${RV_INTEGRATIONS_APK#"$TEMP_DIR/"}"
	RV_PATCHES_JAR=$(find "$TEMP_DIR" -maxdepth 1 -name "revanced-patches-*" | tail -n1)
	[ -z "$RV_CLI_JAR" ] && abort "revanced patches not found"
	log "Patches: ${RV_PATCHES_JAR#"$TEMP_DIR/"}"
}

req() { wget -q -nv -O "$2" --header="$WGET_HEADER" "$1"; }
log() { echo -e "$1" >>build.log; }
get_apk_vers() { req "https://www.apkmirror.com/uploads/?appcategory=${1}" - | sed -n 's;.*Version:</span><span class="infoSlide-value">\(.*\) </span>.*;\1;p'; }
get_largest_ver() {
	local max=0
	while read -r v || [ -n "$v" ]; do
		if [ "$(command_compare "$v" "$max")" = 1 ]; then max=$v; fi
	done
	if [[ $max = 0 ]]; then echo ""; else echo "$max"; fi
}
get_patch_last_supported_ver() {
	unzip -p "$RV_PATCHES_JAR" | strings -s , | sed -rn "s/.*${1},versions,(([0-9.]*,*)*),Lk.*/\1/p" | tr ',' '\n' | get_largest_ver
}

dl_if_dne() {
	if [ ! -f "$1" ]; then
		echo -e "\nGetting '$1' from '$2'"
		req "$2" "$1"
	fi
}

# if you are here to copy paste this piece of code, acknowledge it:)
dl_apk() {
	local url=$1 regexp=$2 output=$3
	url="https://www.apkmirror.com$(req "$url" - | tr '\n' ' ' | sed -n "s/href=\"/@/g; s;.*${regexp}.*;\1;p")"
	url="https://www.apkmirror.com$(req "$url" - | tr '\n' ' ' | sed -n 's;.*href="\(.*key=[^"]*\)">.*;\1;p')"
	url="https://www.apkmirror.com$(req "$url" - | tr '\n' ' ' | sed -n 's;.*href="\(.*key=[^"]*\)">.*;\1;p')"
	req "$url" "$output"
}

patch_apk() {
	local stock_input=$1 patched_output=$2 patcher_args=$3
	if [ -f "$patched_output" ]; then return; fi
	# shellcheck disable=SC2086
	# --rip-lib is only available in my own revanced-cli builds
	echo "java -jar $RV_CLI_JAR --rip-lib x86 --rip-lib x86_64 -c -a $stock_input -o $patched_output -b $RV_PATCHES_JAR --keystore=ks.keystore $patcher_args"
	java -jar "$RV_CLI_JAR" --rip-lib x86 --rip-lib x86_64 --rip-lib armeabi-v7a -c -a "$stock_input" -o "$patched_output" -b "$RV_PATCHES_JAR" --keystore=ks.keystore $patcher_args
}


select_ver() {
	local last_ver pkg_name=$1 apkmirror_category=$2 select_ver_experimental=$3
	last_ver=$(get_patch_last_supported_ver "$pkg_name")
	if [ "$select_ver_experimental" = true ] || [ -z "$last_ver" ]; then
		if [ "$pkg_name" = "com.twitter.android" ]; then
			last_ver=$(get_apk_vers "$apkmirror_category" | grep "release" | get_largest_ver)
		elif [ "$pkg_name" = "com.google.android.youtube" ]; then
                        last_ver=${EXPERIMENTAL_YTVER} 
                else
			last_ver=$(get_apk_vers "$apkmirror_category" | get_largest_ver)
		fi
	fi
	echo "$last_ver"
}

build_rv() {
	local -n args=$1
	local version

	echo "Building ${args[app_name]} ${args[arch]}"

	if [ "${args[is_module]}" = true ]; then
		if [[ ${args[patcher_args]} == *"--experimental"* ]]; then
			local select_ver_experimental=true
		else
			local select_ver_experimental=false
		fi
		if [[ ${args[patcher_args]} != *-e\ ?(music-)microg-support* ]] &&
			[[ ${args[patcher_args]} != *"--exclusive"* ]] ||
			[[ ${args[patcher_args]} == *-i\ ?(music-)microg-support* ]]; then
			local is_root=false
		else
			local is_root=true
		fi
	else
		local select_ver_experimental=true
		local is_root=false
	fi
	if [ $is_root = true ]; then
		local output_dir="$TEMP_DIR"
		# --unsigned is only available in my revanced-cli builds
		if [ "${args[rip_all_libs]}" = true ]; then
			# native libraries are already extracted. remove them all to keep apks smol
			args[patcher_args]="${args[patcher_args]} --unsigned --rip-lib arm64-v8a --rip-lib armeabi-v7a"
		else
			args[patcher_args]="${args[patcher_args]} --unsigned"
		fi
	else
		local output_dir="$BUILD_DIR"
	fi
        version=$(cat version.conf)
	[ -z "$version" ] && version=$(select_ver "${args[pkg_name]}" "${args[apkmirror_dlurl]##*/}" $select_ver_experimental)
	echo "Choosing version '${version}'"

	local stock_apk="${TEMP_DIR}/${args[app_name],,}-stock-v${version}-${args[arch]}.apk"
	local patched_apk="${output_dir}/revanced-v${version}-p${rv_patches_ver::-4}-ex.bin"
	if [ ! -f "$stock_apk" ]; then
		dl_apk "https://www.apkmirror.com/apk/${args[apkmirror_dlurl]}-${version//./-}-release/" \
			"${args[regexp]}" \
			"$stock_apk"
		if [ "${args[arch]}" = "all" ]; then
			log "\n${args[app_name]} version: ${version}"
		else
			log "\n${args[app_name]} (${args[arch]}) version: ${version}"
		fi
	fi

	patch_apk "$stock_apk" "$patched_apk" "${args[patcher_args]}"
	#Build Youtue Custom Package Name
	rm options.toml
	local patched_apk="${output_dir}/revanced-v${version}-p${rv_patches_ver::-4}-cp.bin"
	patch_apk "$stock_apk" "$patched_apk" "${args[patcher_args]}"

	if [ $is_root = false ]; then
		echo "Built ${args[app_name]} (${args[arch]}) (non-root)"
		return
	fi
}

build_yt() {
	declare -A yt_args
	yt_args[app_name]="YouTube"
	yt_args[is_module]=true
	yt_args[patcher_args]="${YT_PATCHER_ARGS} -m ${RV_INTEGRATIONS_APK}"
	yt_args[arch]="all"
	yt_args[rip_all_libs]=true
	yt_args[pkg_name]="com.google.android.youtube"
	yt_args[apkmirror_dlurl]="google-inc/youtube/youtube"
	yt_args[regexp]="APK</span>[^@]*@\([^#]*\)"
	yt_args[module_prop_name]="ytrv-magisk"
	#shellcheck disable=SC2034
	yt_args[module_update_json]="yt-latest.json"

	build_rv yt_args
}

build_music() {
	declare -A ytmusic_args
	local arch=$1
	ytmusic_args[app_name]="Music"
	ytmusic_args[is_module]=true
	ytmusic_args[patcher_args]="${MUSIC_PATCHER_ARGS}"
	ytmusic_args[arch]=$arch
	ytmusic_args[rip_all_libs]=false
	ytmusic_args[pkg_name]="com.google.android.apps.youtube.music"
	ytmusic_args[apkmirror_dlurl]="google-inc/youtube-music/youtube-music"
	if [ "$arch" = "$ARM64_V8A" ]; then
		ytmusic_args[regexp]='arm64-v8a</div>[^@]*@\([^"]*\)'
		ytmusic_args[module_prop_name]="ytmusicrv-magisk"
	elif [ "$arch" = "$ARM_V7A" ]; then
		ytmusic_args[regexp]='armeabi-v7a</div>[^@]*@\([^"]*\)'
		ytmusic_args[module_prop_name]="ytmusicrv-arm-magisk"
	fi
	#shellcheck disable=SC2034
	ytmusic_args[module_update_json]="music-update-${arch}.json"

	build_rv ytmusic_args
}

build_twitter() {
	declare -A tw_args
	tw_args[app_name]="Twitter"
	tw_args[is_module]=false
	tw_args[patcher_args]="-r"
	tw_args[arch]="all"
	tw_args[pkg_name]="com.twitter.android"
	tw_args[apkmirror_dlurl]="twitter-inc/twitter/twitter"
	#shellcheck disable=SC2034
	tw_args[regexp]="APK</span>[^@]*@\([^#]*\)"

	build_rv tw_args
}

build_reddit() {
	declare -A reddit_args
	reddit_args[app_name]="Reddit"
	reddit_args[is_module]=false
	reddit_args[patcher_args]="-r"
	reddit_args[arch]="all"
	reddit_args[pkg_name]="com.reddit.frontpage"
	reddit_args[apkmirror_dlurl]="redditinc/reddit/reddit"
	#shellcheck disable=SC2034
	reddit_args[regexp]="APK</span>[^@]*@\([^#]*\)"

	build_rv reddit_args
}

build_warn_wetter() {
	declare -A warn_wetter_args
	warn_wetter_args[app_name]="WarnWetter"
	warn_wetter_args[is_module]=false
	warn_wetter_args[patcher_args]="-r"
	warn_wetter_args[arch]="all"
	warn_wetter_args[pkg_name]="de.dwd.warnapp"
	warn_wetter_args[apkmirror_dlurl]="deutscher-wetterdienst/warnwetter/warnwetter"
	#shellcheck disable=SC2034
	warn_wetter_args[regexp]="APK</span>[^@]*@\([^#]*\)"

	build_rv warn_wetter_args
}

build_tiktok() {
	declare -A tiktok_args
	tiktok_args[app_name]="TikTok"
	tiktok_args[is_module]=false
	tiktok_args[patcher_args]="-r"
	tiktok_args[arch]="all"
	tiktok_args[pkg_name]="com.zhiliaoapp.musically"
	tiktok_args[apkmirror_dlurl]="tiktok-pte-ltd/tik-tok-including-musical-ly/tik-tok-including-musical-ly"
	#shellcheck disable=SC2034
	tiktok_args[regexp]="APK</span>[^@]*@\([^#]*\)"

	build_rv tiktok_args
}
