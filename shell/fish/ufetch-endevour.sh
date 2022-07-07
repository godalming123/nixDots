#!/bin/sh

# INFO

host="$(cat /etc/hostname)"
os="Endeavour OS"
kernal="$(uname -sr)"
uptime="$(uptime -p | sed 's/up //')"
packadges="$(paru -Q | wc -l)"
shell="$(basename "${SHELL}")"

# FONT SETTINGS

reset="$(tput sgr0)"
bold="$(tput bold)"

# FONT COLORS

black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

# ECHO

function sysInfo {
    echo "${bold}${blue}${USER}${white}$1${cyan}${host}${reset}$6"
    echo "$7$7$7$7$7$7$7$7$2$7$7$7$7$7$7$7$7$3"
    echo "${bold}${blue}OS      ${reset}$4 ${cyan}${os}"
    echo "${bold}${blue}KERNAL  ${reset}$4 ${cyan}${kernal}"
    echo "${bold}${blue}UPTIME  ${reset}$4 ${cyan}${uptime}"
    echo "${bold}${blue}PKDGS   ${reset}$4 ${cyan}${packadges}"
    echo "${bold}${blue}SHELL   ${reset}$4 ${cyan}${shell}"
    echo "$reset$5"
}

#sysInfo "@" "-" "" ":" "" "" "-"
#sysInfo "@" "─" "" ":" "" "" "─"
#sysInfo "@" "─" "" "│" "" "" "─"
#sysInfo "@" "+" "" "│" "" "" "─"
sysInfo "@" "╮" "╯" "│" "────────╯" "│" "─"
