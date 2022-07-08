# ==================
# === HANDLE TTY ===
# ==================

set ttyVar (tty)

set desktopTty /dev/tty1
set terminalTty /dev/tty2

if test $ttyVar = $desktopTty # if we are running in tty
	Hyprland
end

if test $ttyVar = $terminalTty # if we are running in second tty
	#terminology # launch terminlolgy
end

# ====================
# === HELPER FUNCS ===
# ====================
function round
    echo (math (math -s1 $argv/10) x 10)
end

# =====================
# === FONT SETTINGS ===
# =====================

# === STYLES ===
set reset (tput sgr0) &
set bold (tput bold) &

# === FONT COLORS ===
set black (tput setaf 0) &
set red (tput setaf 1) &
set green (tput setaf 2) &
set yellow (tput setaf 3) &
set blue (tput setaf 4) &
set magenta (tput setaf 5) &
set cyan (tput setaf 6) &
set white (tput setaf 7) &

# ====================
# === INTERACTIVE  ===
# ====================

if status is-interactive
    # === Add aliases ===

    # = ls aliases =
    alias ls='ls --color=auto' &
    alias ll='ls -lav --ignore=..' & # show a long listing of all files/folders except ".."
    alias l='ls -lav -ignore=.?*' & # show a long listing but no hidden files except "."
    alias ..='cd ../' &
    alias ...='cd ../../' &

    # = app aliases =
    alias teams='flatpak run com.microsoft.Teams &'
    alias tor="/home/whatever/Downloads/tor/start-tor-browser &"
    alias vscodium='flatpak run com.vscodium.codium &'

    # = git aliases =
    alias gstat='git status' &
    alias gadd='git add' &
    alias gclone='git clone' &
    alias gommit='git commit' &
    alias gush='git push' &
    alias geckout='git checkout' &
    alias gomote='git remote' &
    alias giff='git diff' &
    alias gog='git log' &
    alias gull='git pull' &
    alias gonfig='git config' &
    alias ginit='git init' &

    # = other aliases =
    alias screens='kanshi' &
    alias config='cd ~/Documents/coding\ repos/dotfiles/; micro fish/config.fish scripts/ufetch-endevour.sh wayfire/wayfire.ini wayfire/wf-shell.ini alacritty/alacritty.yml wofi/styles.css wofi/wifi wofi/wofi-wifi.sh mako/config micro/bindings.json micro/settings.json' &
    alias vcon='cd ~/Documents/coding\ repos/dotfiles/; vim -p ~/.vimrc fish/config.fish scripts/ufetch-endevour.sh wayfire/wayfire.ini wayfire/wf-shell.ini alacritty/alacritty.yml wofi/styles.css wofi/wifi wofi/wofi-wifi.sh mako/config micro/bindings.json micro/settings.json eww/eww.yuck eww/eww.scss eww/imports/widgets.yuck eww/imports/bar-items.yuck' &
    # alias fish_prompt='fish ' #this is supposed to reload fish with staring the greeting
    alias q='exit'
    alias s='systemctl suspend'
end

# =====================
# === FISH GREETING ===
# =====================

function fish_greeting
    clear
    pfetch
end

# ============================
# === PROMPT CONFIGURATION ===
# ============================

# === updates ===
function updates
    set updates (cat ~/.config/eww/scripts/updates.txt)
    if test $updates -ne 0;
        echo -n "$reset with $red$updates$reset updates"
    end
end

# === git ===
function git_info
    set branch_name (git rev-parse --abbrev-ref HEAD 2> /dev/null)

    if test "$branch_name" != ""
        echo -n "$reset on$cyan $branch_name" # if we are on a git folder
        git_changes
    end
end

function git_changes
    # /dev/null prevents nonsensical errors when you are on directories not tracked by git
    set changesLNs (git status --untracked-files=no 2> /dev/null | wc -l)
    set changes (expr $changesLNs - 9)

    if test $changes -eq 0
        set changesText "no changes"
    else if test $changes -gt 1
        set changesText "$changes changes"
    else
        set changesText "1 change"
    end

    echo -n "$reset with$cyan $changesText"
end

# === computer hostname ===
function Hostname
    set hostname_ (hostname)
    echo -n "$reset from $magenta$hostname_"
end

# === computer user ===
function usr
    set user (whoami)
    echo -n "$reset as $yellowfish$user"
end

# === prompt working directory ===
function workingDir
    echo -n "in $blue"
    echo -n (pwd)
    echo -n "$reset"
end

# === prompt indicator ===
function indicator
    if test "$argv" = true
        echo -n "$green > $reset"
    else
        echo -n "$red > $reset"
    end
end

function rightIndicator
	echo -n " $magenta<$reset"
end

# === time ===
function showTime
    set theTime (date '+%H:%M')
    echo -n " at $yellow$theTime$reset"
end

# === date ===
function showDate
    set theDate (date '+%d/%m/%y')
    echo -n " at $yellow$theDate$reset"
end

# === command duration ===
function commandDuration
    set duration (round (math $CMD_DURATION/1000))
	
	if test $duration -gt 0.1
	    # = CALCULATE TIME IN SECONDS MINUTES HOURS DAYS AND WEEKS =
	    set seconds $duration
	    set minutes 0
	    set hours 0
	    set days 0
	    set weeks 0

        if test $seconds -gt 59
            set minutes (math -s0 $seconds/60)
            set seconds (math $seconds%60)
        end

        if test $minutes -gt 59
            set hours (math -s0 $minutes/60)
            set minutes (math $minutes%60)
        end

        if test $hours -gt 23
            set days (math -s0 $hours/24)
            set hours (math $hours%24)
        end

        if test $days -gt 6
            set weeks (math -s0 $days/7)
            set days (math $hours%7)
        end

	    # = PRINT TIME IN SECONDS MINUTES DAYS HOURS AND WEEKS =
		echo -n " took$magenta"
		
        if test $weeks -gt 0
            echo -n " $weeks"
            echo -n "w"
        end

        if test $days -gt 0
            echo -n " $days"
            echo -n "d"
        end

        if test $hours -gt 0
            echo -n " $hours"
            echo -n "h"
        end

		if test $minutes -gt 0
            echo -n " $minutes"
            echo -n "m"
		end
		
		if test $seconds -gt 0
		    echo -n " $seconds"
		    echo -n "s"
		end
		
		echo -n "$reset"
	end
end

# === main prompt ===
function fish_prompt
    if test $status -eq 0
        set success true
    else
        set success false
    end

    workingDir
    git_info
    commandDuration
    indicator "$success"
end

function fish_right_prompt
	rightIndicator
	#updates
	showTime
	showDate
end
