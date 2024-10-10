#!/bin/bash
#
# See https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash#13359121
# for bash parameter handling

#set -eo pipefail

SLACKBUILDS_DIR="/opt/slackbuilds"
ACTION="install"
CONFIRMATION="n"
DONT_LOOKUP=0
PACKAGE="$1"
SKIP_DEPENDENCIES=""
SKIP_MD5_CHECK=""
SUDO=""
VERBOSE=0

GREEN='\033[0;32m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
RESET='\033[0m'
YELLOW='\033[0;33m'

# use sudo if not running as root
[[ $UID -ne 0 ]] && SUDO="sudo --preserve-env"

log() {
    local lvl="${2:-INFO}"
    local color="$RESET"

    [[ "$lvl" = "DEBUG" && $VERBOSE -ne 1 ]] && return

    [[ "$lvl" = "DEBUG" ]] && color="$MAGENTA"
    [[ "$lvl" = "INFO" ]] && color="$GREEN"
    [[ "$lvl" = "WARN" ]] && color="$YELLOW"
    [[ "$lvl" = "ERROR" ]] && color="$RED"

    echo -e "[${color}${lvl}${RESET}] $1" 1>&2
}

# Check if package is already installed
#
# @return 0 if package is installed
# @return 2 if package is not installed
is_sb_installed () {
    local current_version="$(find /var/log/packages/ -name "${1}-*")"

    log "is_sb_installed: pkg=$1, version='$current_version'" "DEBUG"
    if [ -n "$current_version" ]; then
        return 0
    fi

    return 1
}

function install_dependencies() {
    local dependencies="$1"
    local action="${2:-install}"
    local confirmatin="${3:-n}"
    local result=

    log "==== Installing dependencies: $dependencies"
    for dep in $dependencies; do
        packages=$(find $SLACKBUILDS_DIR -type d -name "$dep")
        log "===== Installing dependency... $dep -- $packages"

        for pkg_path in $packages; do
            install_sb "$pkg_path" "$action" "$confirmation"
            result=$?

            log "install_dependencies: $dep ($pkg_path), result = $result" "DEBUG"
            if [ $result -eq 0 ]; then
                log "======== Installed $pkg_path"
            elif [ $result -eq 1 ]; then
                log "$dep already installed"
            fi
        done
    done
}

function install_sb() {
    local path="$1"
    local action="${2:-install}"
    local confirmation="${3:-n}"
    local build_result=
    local pkg_name=
    local is_installed=
    PRGNAM=""
    VERSION=""
    DOWNLOAD=""
    MD5SUM=""
    DOWNLOAD_x86_64=""
    MD5SUM_x86_64=""
    REQUIRES=""

    if [ -z "$path" ]; then
        log "Invalid slackbuild: '$path'" "ERROR"
        return
    fi

    # read package information
    source "$path/$(basename $path).info"
    pkg_name="$PRGNAM-$VERSION"

    log "confirmation = $confirmation, requires = '$REQUIRES', skip = '$SKIP_DEPENDENCIES'" "DEBUG"
    if [ "$confirmation" = 'n' ]; then
        local msg="Package: $PRGNAM ($VERSION)"
        if [ -n "$REQUIRES" -a "$SKIP_DEPENDENCIES" != "y" ]; then
            msg="$msg\n  Dependencies:\n"
            msg="$msg$(tr ' ' '\n' <<< $REQUIRES | xargs printf "    * %s\n")"
        fi
        log "$msg"
        read -p "[PROMPT] Go ahead with $action? [y/N]:" confirmation
    fi

    log "$PRGNAM: confirmation = $confirmation ($pkg_name, $path)" "DEBUG"
    if [ "$confirmation" != 'y' ]; then
        exit 0
    fi

    log "=== Installing $pkg_name ($path) (ACTION=$ACTION)"

    is_sb_installed $pkg_name
    is_installed=$?
    if [ $action = "install" -a $is_installed -eq 0 ]; then
        log "$pkg_name already installed, skipping..." "WARN"
        popd 1>/dev/null 2>&1
        return 1
    fi

    if [ -n "$REQUIRES" -a "$SKIP_DEPENDENCIES" != "y" ]; then
        install_dependencies "$REQUIRES" "$action" $confirmation
    fi

    log "Installing $path..."
    pushd "$path"
    source "$path/$(basename "$path").info"
    # check if DOWNLOAD_x86_64 is configured
    if [ -n "$DOWNLOAD_x86_64" ]; then
        DOWNLOAD="$DOWNLOAD_x86_64"
    fi

    # check if MD5 checksum is configured
    if [ -n "$MD5SUM_x86_64" -o -z "$MD5SUM" ]; then
        MD5SUM="$MD5SUM_x86_64"
    fi
    # test -z "$MD5SUM" && test -n "$MD5SUM_x86_64" && MD5SUM="$MD5SUM_x86_64"

    if [ -z "$DOWNLOAD" ]; then
        log "No DOWNLOAD source" "ERROR"
        exit 1
    fi

    downloads=($DOWNLOAD)
    md5s=($MD5SUM)

    for (( i=0; i<${#downloads[@]}; i++)); do
        download="${downloads[$i]}"
        md5="${md5s[$i]}"
        log "i = $i, download = $download, md5 = $md5" "DEBUG"

        if [ ! -f "$(basename $download)" ]; then
            log "Downloading source from: $download" "DEBUG"
            wget --continue $download
            if [ $? -ne 0 ]; then
                log "Something went wrong with wget" "ERROR"
                exit 1
            fi
        else
            log "Source found" "WARN"
        fi

        if [ -n "$MD5SUM" -a "$SKIP_MD5_CHECK" != "y" ]; then
            log "Comparing MD5 checksum..." "WARN"
            ACTUAL_MD5SUM="$(md5sum "$(basename "$download")" | cut -d' ' -f 1)"
            MD5_FOUND=1

            log "Comparing MD5 sum: MD5 = $md5" "DEBUG"
            [ "$md5" == "$ACTUAL_MD5SUM" ] && MD5_FOUND=0

            if [ $MD5_FOUND -ne 0 ]; then
                log "MD5SUM does not match; expected $ACTUAL_MD5SUM, got $MD5SUM. Exiting..." "ERROR"
                exit 1
            fi
        fi
    done

    log "Running slack build script"
    notify-send "Slackbuild" "Running build script for $pkg_name. May need password"
    $SUDO sh "$PWD/${PRGNAM}.SlackBuild"
    build_result=$?

    if [ $build_result -ne 0 ]; then
        log "Error running $PRGNAM.SlackBuild" "ERROR"
        exit 1
    fi

    log "Installing package $pkg_name"
    notify-send "Slackbuild" "Installing $pkg_name. May need password"
    $SUDO /sbin/upgradepkg --install-new /tmp/${PRGNAM}-*.tgz

    if [[ $? -ne 0 ]]; then
        log "Failed to install $path" "ERROR"
    fi

    for download in $DOWNLOAD; do
        rm "$(tr '/' '\n' <<< $download | tail -n 1)"
    done
    if [ -f README.SLACKWARE ]; then
        cat README.SLACKWARE
    fi

    popd 1>/dev/null
    return 0
}

function print_help() {
    cat 1>&2 <<EOS
Usage: $(basename $0) <action> <slackbuild [.tar.gz]>

The slackbuild can be either an archive downloaded from slackbuilds.org
or a directory from the slackbuilds repository.

  <slackbuild>  space-separated list of slackbuild packages

ACTIONS

  i[nstall]     Install package
  d[esc]        Show package description (slack-desc), if found.
  s[earch]      Show package description (slack-desc), if found.
  u[pgrade]     Upgrade package (install if new)
  info          Print package info

OPTIONS

  -d|--do-not-lookup      Do not lookup package in slackbuilds repo, treat argument as slackbuild package directory
  -y|--yes                Confirm package installation (skip prompt)
  -s|--skip-dependencies  Skip dependencies installation
  --skip-md5              Skip MD5 integrity check
  -v|--verbose            Be verbose
  -h|--help               Print this message
EOS
}

while [[ $# -gt 0 ]]; do
    param="$1"

    case $param in
        d|desc|s|search)
            ACTION="desc"
            PACKAGE="$2"
            shift
            shift
            ;;

        i|install)
            PACKAGE="$2"
            shift
            ;;

        reinstall)
            ACTION="reinstall"
            shift
            ;;

        u|upgrade)
            ACTION="upgrade"
            PACKAGE="$2"
            shift
            shift
            ;;

        info)
            ACTION="info"
            PACKAGE="$2"
            shift
            shift
            ;;

        -d|--do-not-lookup)
            DONT_LOOKUP=1
            shift
            ;;

        -y|--yes)
            CONFIRMATION="y"
            shift
            ;;

        -s|--skip-dependencies)
            SKIP_DEPENDENCIES="y"
            shift
            ;;

        --skip-md5)
            SKIP_MD5_CHECK="y"
            shift
            ;;

        -v|--verbose)
            VERBOSE=1
            shift
            ;;

        -h|--help)
            print_help
            exit 1
            ;;

        *)
            PACKAGE="$param"
            shift
            ;;
    esac
done

if [ $ACTION = "info" -o $ACTION = "reinstall" -o $ACTION = "install" -o $ACTION = "upgrade" ]; then
    if [ $DONT_LOOKUP -eq 1 ]; then
        packages="$PACKAGE"
    else
        packages=$(find $SLACKBUILDS_DIR -type d -name "$PACKAGE")
    fi

    for pkg_path in $packages; do
        if [ $ACTION = "info" ]; then
            pkg=$(basename $pkg_path)

            echo "$pkg =================================================== $pkg_path"
            cat $pkg_path/$pkg.info

            if [ -f $pkg_path/README.SLACKWARE ]; then
                echo -e "\n-----------------------------| README.SLACKWARE |-----------------------------\n"
                cat $pkg_path/README.SLACKWARE
            fi
            if [ -f $pkg_path/README ]; then
                echo -e "\n-----------------------------| README |-----------------------------\n"
                cat $pkg_path/README
            fi
        else
            install_sb "$pkg_path" $ACTION "$CONFIRMATION"
        fi
    done

    exit 0
fi

if [ $ACTION = "desc" ]; then
    packages=$(find $SLACKBUILDS_DIR -type d -name "*${PACKAGE}*")

    # find $SLACKBUILDS_DIR -type d -name "$PACKAGE" -execdir cat "{}/slack-desc" \;
    # See installpkg(8) for a reference on how they parse package description
    for pkg_path in $packages; do
        pkg=$(basename $pkg_path)

        echo "$pkg =================================================== $pkg_path"
        grep "^$pkg:" $pkg_path/slack-desc | uniq | sed "s/^$pkg:/#/g"
        echo
    done
    exit 0
fi
