#!/usr/bin/env bash

warn () {
    echo 1>&2 "$(tput setaf 3)[WARNING] $1$(tput sgr 0)"
}

panic () {
    echo 1>&2 "$(tput setaf 1)[ERROR] $1$(tput sgr 0)"
}

info () {
    echo 1>&2 "$(tput setaf 6)[INFO] $1$(tput sgr 0)"
}

debug () {
    info $1
}
