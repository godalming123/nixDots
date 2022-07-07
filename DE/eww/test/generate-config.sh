#!/bin/env fish

source config.conf

echo -e "
; ======================
; === DEFINE WINDOWS ===
; ======================

; === define bar ===

(defwindow bar
  :monitor $barMoniter
  :windowtype \"dock\"
  :geometry (geometry :width \"$barwidth\"
                      :height \"$barHeight\"
                      :anchor \"$barlocation center\")
  :exclusive true
  :stacking \"overlay\"
  (centerbox :orientation \"h\"
    (leftStuff)
    (centerStuff)
    (rightStuff)
  )
)

; === define background information windows ===

(defwindow time
  :monitor 0
  :geometry (geometry :width \"310px\"
                      :height \"340px\"
                      :anchor \"top right\"
                      :y \"30px\"
                      :x \"30px\")
  :exclusive true
  :stacking \"bg\"
  (time-widget :class \"bg-info\")
)

(defwindow resorces
  :monitor 0
  :geometry (geometry :width \"310px\"
                      :height \"250px\"
                      :anchor \"top right\"
                      :y \"390px\"
                      :x \"30px\")
  :exclusive true
  :stacking \"bg\"
  (resorces-widget)
)

; === define app menu ===

(defwindow menu
  :monitor $barMoniter
  :geometry (geometry :width \"300px\"
                      :height \"500px\"
                      :anchor \"$barlocation left\"
                      :y \"10px\"
                      :x \"10px\")
  :stacking \"overlay\"
  :focusable true
(searchapps))

; === define calendar ===

(defwindow calendar
  :monitor $barMoniter
  :geometry (geometry :width \"240px\"
                      :height \"160px\"
                      :anchor \"$barlocation right\"
                      :y \"10px\"
                      :x \"40px\")
  :stacking \"overlay\"
(cal))

; === define updates window ===

(defwindow updates
  :monitor $barMoniter
  :geometry (geometry :width \"240px\"
                      :height \"230px\"
                      :anchor \"$barlocation right\"
                      :y \"10px\"
                      :x \"110px\")
  :stacking \"overlay\"
(updates-menu))

; === define notifucations window ===

(defwindow notifucations
  :monitor $barMoniter
  :geometry (geometry :width \"260px\"
                      :height \"300px\"
                      :anchor \"$barlocation right\"
                      :y \"10px\"
                      :x \"10px\")
  :stacking \"overlay\"
(notifucations))

; === define wifi window ===

(defwindow wifi
  :monitor $barMoniter
  :geometry (geometry :width \"260px\"
                      :height \"300px\"
                      :anchor \"$barlocation right\"
                      :y \"10px\"
                      :x \"118px\")
  :stacking \"overlay\"
(wifi))

; === window for wallpaper ===

(defwindow background
  :monitor $barMoniter
  :geometry (geometry :width \"100%\"
                      :height \"100%\"
                      :anchor \"center\")
  :stacking \"bg\"
(box :class \"background-image\" :valign \"fill\" :halign \"fill\"))

; === window for system info ===

(defwindow sys-info
  :monitor $barMoniter
  :geometry (geometry :width \"600px\"
                      :height \"150px\"
                      :anchor \"$barlocation right\"
                      :y \"10px\"
                      :x \"227px\")
  :stacking \"overlay\"
(system-info))

; === define settings menu ===

(defwindow settings
  :monitor $barMoniter
  :geometry (geometry :width \"700px\"
                      :height \"80%\"
                      :anchor \"center center\"
            )
  :stacking \"overlay\"
  :focusable true
(settings-menu))

; === center ===
(defwidget centerStuff []
    \"\"
)

; ==================
; === VARRIABLES ===
; ==================

; === app list ===
(defpoll search_listen :interval \"1s\" \"cat ./search-items.txt\")

; === charge ===
(defpoll battery-runner :interval \"15s\" \"scripts/battery.sh\")
(defpoll battery :interval \"15s\" \"cat scripts/battery-charge.txt\")
(defpoll battery-status :interval \"15s\" \"cat scripts/battery-status.txt\")
(defpoll notify-battery :interval \"20m\" \"scripts/notify-battery.sh\")

; === volume ===
(defpoll volume :interval \"1s\" \"scripts/getvol.sh\")

; === time vars
(defpoll time :interval \"60s\" \"date '+%d/%m/%y %H:%M'\")

(defpoll HOUR :interval \"600s\" \"date +'%I'\")
(defpoll MIN :interval \"600s\" \"date +'%M'\")
(defpoll MER :interval \"600s\" \"date +'%p'\")
(defpoll DAY :interval \"600s\" \"date +'%A'\")

; === brightness ===
(defpoll brightness :interval \"1s\" \"scripts/brightness.sh\")

; === wifi ===
(defpoll wifi-name :interval \"1m\" \"./scripts/wifi.sh --ESSID\")

; === disk ===
(defpoll disk-usage :interval \"5m\" \"echo \$(df | grep / | awk '{ print $5 }' | sed 's/[^0-9]//g' )\")

; === updates ===
(defpoll updates-runner :interval \"1h\" \"./scripts/updates.sh\")
(defpoll updates :interval \"5m\" \"cat ./scripts/updates.txt\")
(defpoll updates-notifier :interval \"24h\" \"./scripts/notify-updates.sh\")


; =================
; === BAR ITEMS ===
; =================

; === left ===
(defwidget leftStuff []
  (button :tooltip \"Menu - Show favouroute apps - super\" :halign \"start\" :class \"menu-button btn\"
          :onclick \"eww close updates sys-info notifucations wifi calendar; eww open --toggle menu\"
    (image :path \"./icons/dark/feather.png\" :image-height 18)
  )
)

; === right ===
(defwidget rightStuff []
  (box :class \"sidestuff\" :orientation \"h\" :space-evenly false :halign \"end\"
    (box :onclick \"eww close updates menu notifucations calendar wifi; eww open --toggle sys-info\" :orientation \"h\" :space-evenly false
        ; volume
        (imic :tooltip \"Volume: \${volume}%\"
              :icon \"./icons/dark/audio.png\"
              :value volume
              :onchange \"amixer -D pulse set Master {}%\")
        ; brightness
        (imic :tooltip \"Brightness: \${brightness}%\"
              :icon \"./icons/dark/brightness.png\"
              :value brightness
              :onchange \"light -S {}\")
        ; ram
        (imic :tooltip \"RAM: \${EWW_RAM.used_mem_perc}%\"
              :icon \"./icons/dark/ram.png\"
              :value {EWW_RAM.used_mem_perc}
              :onchange \"\")
        ; cpu
        (imic :tooltip \"CPU: \${EWW_CPU.avg}%\"
              :icon \"./icons/dark/cpu.png\"
              :value {EWW_CPU.avg}
              :onchange \"\")
        ; disk
        (imic :tooltip \"Disk: \${(EWW_DISK[\"/\"].used / EWW_DISK[\"/\"].total) * 100}%\"
              :icon \"./icons/dark/disk.png\"
              :value {(EWW_DISK[\"/\"].used / EWW_DISK[\"/\"].total) * 100}
              :onchange \"\")
        ; battery
        (imic :tooltip \"\${battery}% battery \${battery-status == \"Charging\" ? \"and charging\" : \"\"}\"
              :icon \"./icons/dark/battery\${battery-status == \"Charging\" ? \"-charging\" : \"\"}.png\"
              :value battery
              :onchange \"\")
    )
    ; wifi
    (button :tooltip \"\${wifi-name == \"\" ? \"Not connected\" : \"Connected to \${wifi-name} \"}\" :class \"btn\" :onclick \"eww close updates sys-info menu notifucations calendar; eww open --toggle wifi\"
        (image :path \"./icons/dark/wifi.png\" :image-height 18)
    )
    ; updates
    ;\${updates == 0 ? \"\" : \"\"}
    (button :tooltip \"You have \${updates} updates\" :class \"btn\" :onclick \"eww close wifi sys-info menu notifucations calendar; eww open --toggle updates\"
      (box :orientation \"h\" :space-evenly false
        (image :path \"./icons/dark/downloads.png\" :image-height 14)
        updates
      )
    )

    ; calendar
    (button :tooltip \"The date is \${time}\" :class \"btn\" :onclick \"eww close updates sys-info menu wifi notifucations; eww open --toggle calendar\" time)
    ; notifucations menu
    (button :tooltip \"shows notifucations\"  :class \"btn notifucations\" :onclick \"eww close updates sys-info menu wifi calendar; eww open --toggle notifucations\" \"notifucations\")
  )
)

; ===============
; === WIDGETS ===
; ===============

; === calendar ===
(defwidget cal []
  (calendar :halign \"center\" :valign \"center\" :class \"cal\")
)

; === system info ===
(defwidget system-info []
    \"system info\"
)

; === updates menu ===
(defwidget updates-menu []
    (box :orientation \"v\" :valign \"center\" :halign \"middle\" :space-evenly false
      \"You have \${updates} updates\"
      (button :class \"btn-shape btn-color\${updates == 0 ? \"-inactive\" : \"\"} btn-big\" :halign \"center\" :onclick \"eww close updates; alacritty -e paru &\" \"get updates\")
    )
)

; === app search ===
(defwidget searchapps []
    (box :orientation \"h\" :space-evenly false :class \"search-win\" :valign \"fill\"
      (centerbox :orientation \"v\" :class \"sidemenu-btns\"
        (box :orientation \"v\" :space-evenly false
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu; eww open settings\"                       (image :path \"./icons/dark/settings.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu; notify-send software 'opens software'\"                       (image :path \"./icons/dark/software.png\" :image-height 23))
        )
        (box :orientation \"v\" :space-evenly false
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu; nautilus ~/Documents &\"                                    (image :path \"./icons/dark/docs.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu; nautilus ~/Downloads &\"                                    (image :path \"./icons/dark/downloads.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu; nautilus ~/Pictures &\"                                     (image :path \"./icons/dark/landscape.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu; nautilus ~/Music &\"                                        (image :path \"./icons/dark/music.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu; nautilus ~/Videos &\"                                       (image :path \"./icons/dark/recorder.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu; nautilus ~/Desktop &\"                                      (image :path \"./icons/dark/desktop.png\" :image-height 23))
        )
        (box :orientation \"v\"  :space-evenly false  :valign \"end\"
          (button :valign \"start\" :class \"btn\" :onclick \"systemctl shutdown\"                                      (image :path \"./icons/dark/shutdown.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"reboot\"                                                  (image :path \"./icons/dark/restart.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"killall wayfire\"                                         (image :path \"./icons/dark/logout.png\" :image-height 23))
          (button :valign \"start\" :class \"btn\" :onclick \"eww close menu & swaylock -c 000000 & systemctl suspend &\" (image :path \"./icons/dark/moon.png\" :image-height 23)); we need to close the menu so it does not steal our keyboard from swaylock
        )
      )
      (box :orientation \"v\" :space-evenly false :class \"search-win\" :valign \"fill\" :halign \"fill\"
        (input :class \"search-bar\" :onchange \"~/.config/eww/scripts/search.sh {}\")
        (literal :vexpand \"true\" :halign \"fill\" :valign \"fill\" :class \"app-container\" :content search_listen)
        ; \"TODO: app menu\"
      )
      
    )
)

; === metric with icon ===
(defwidget imic [tooltip icon value onchange]
  (box :space-evenly false :tooltip tooltip :orientation \"h\"
    (image :path icon :image-height 18)
    (metric :value value :onchange onchange :label \"\")
  )
)

; === metric ===
(defwidget metric [label value onchange]
  (box :orientation \"h\"
       :class \"metric\"
       :space-evenly false
    (box :class \"label\" label)
    (scale :min 0
           :max 101
           :active {onchange != \"\"}
           :value value
           :onchange onchange)))

; === notificutaions
(defwidget notifucations []
  \"notifucations\"  
)

; === wifi
(defwidget wifi []
  \"wifi\"  
)

; =====================
; === SETTINGS MENU ===
; =====================

(defwidget settings-menu []
  (box :valign \"fill\" :halign \"fill\" :space-evenly false :orientation \"v\"
    ; === app header ===
    (centerbox :orientation \"h\" :class \"dialog-headerbar\"
      (image :path \"./icons/dark/settings.png\" :halign \"start\" :image-height 23)
      (label :halign \"center\" :text \"SETTINGS\" :class \"bold\")
      (button :halign \"end\" :class \"btn round\" :onclick \"eww close settings\" (image :path \"./icons/dark/close.png\" :image-height 15))
    )
    ; === app content ===
    (box :space-evenly false :orientation \"h\"
      ; = sidebar =
      (box :width 200 :halign \"fill\" :valign \"start\" :space-evenly false :orientation \"h\"
        (label :class \"bold\" :text \"Sidebar\")
      )
      ; = config page =
      (box :valign \"fill\" :halign \"fill\" :space-evenly false :orientation \"v\"
        (label :class \"bold\" :text \"ABOUT\")
        (label :text \"Bar + system info on desktop + menu + settings: eww
WM:                                             wayfire
Wallpaper:                                      https://wallpapercave.com/w/wp3363794
\")
      )
    )
  )
)

" > ./eww.yuck

echo -e "
// === blue color scheme ===
\$bg: #2d343a;
\$fg: #b0b4bc;
\$grey-alt: #35404b;
\$grey: #3d464e;
\$inactive: #495055;
\$highlight: #81A1C1;
\$highlight-alt: #5d92c7;
\$highlight-alt-darken: #517fad;
\$highlight-2: #96ddc5;

// === grey colors ===
// \$bg: #383838;
// \$fg: #c7c7c7;
// \$grey-alt: #4d4d4d;
// \$grey: #4b4b4b;
// \$highlight: #ffffff;
// \$highlight-alt: #ffffff;
// \$highlight-2: #d4d4d4;

// === yellow color scheme ===
// \$bg: #101820;
// \$fg: #a5aaaf;
// \$grey-alt: #282f35;
// \$grey: #3c4349;
// \$highlight: #F2AA4C;
// \$highlight-alt: #ecb062;
// \$highlight-2: #eeb345;

// === red color scheme ===
// \$bg: #2D2926;
// \$fg: #a09c99;
// \$grey-alt: #5a514a;
// \$grey: #46403c;
// \$highlight: #E94B3C;
// \$highlight-alt: #ecb062;
// \$highlight-2: #eeb345;

// === teal color scheme ===
// \$bg: #222831;
// \$fg: #b0b4bc;
// \$grey-alt: #35404b;
// \$grey: #393E46;
// \$highlight: #5ddad5;
// \$highlight-alt: #5fc0bd;
// \$highlight-2: #A3F7BF;

// === GENERAL STYLES ===

* {
  all: unset; //Unsets everything so you can style everything from scratch
}

.bold {
  font-weight: bold;
}

@mixin trans {
  transition: 300ms;
}

.bar {
  background-color: \$bg;
  color: \$fg;
}

window:not(.bar), tooltip {
	  background-color: \$grey;
	  padding: 10px;
	  border-radius: 10px;
}

.sidemenu-btns button {
  border-radius: 99px;
  margin: 1px;
  padding: 1px;
  // aspect-ratio: 1/1;
}

// === BACKGROUND IMAGE ===

.background-image {
  background-image: url(\"./wallpapers/windows-11-dark.jpg\");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
}

// === DIALOG ===

.dialog-headerbar {
  padding: 0 5px;
  & > button {
    border-radius: 99px;
    min-width: 20px;
  }
}

// === CLOCK + CALENDER ===

calendar {
	padding: 5px 0;
  &:selected {
    background: \$highlight-alt;
    border-radius: 50px;
    min-height: 20px;
  }
  & > * {
    border-radius: 50px;
    min-height: 20px;
    // padding: 50px 10px 100px 30px;
  }
  &:hover {
    background: \$grey-alt;
  }
}

.time_hour, .time_min {
	color: \$highlight;
	font-size : 75px;
	font-weight : bold;
}
.time_hour {
	margin : 0px 0px 0px 25px;
}
.time_min {
	margin : 0px 0px 0px 25px;
}

.time_mer {
	color: \$highlight-alt;
	font-size : 43px;
	font-weight : bold;
	margin : 0px 0px 0px 0px;
}

.time_day {
	color: \$highlight-2;
	font-size : 25px;
	font-weight : normal;
	margin : 0px 0px 0px 0px;
}

// === BUTTONS ===

.btn {
  @include trans();
  padding: 1 5;
  &:hover, &:focus {
    background-color: \$grey-alt;
  }
}

.btn-big {
  padding: 8px;
  margin: 5px;
}

.btn-shape {
  @include trans();
  border-radius: 5px;
  padding: 5px;
  margin: 3px;
}

.btn-color {
  background: \$highlight-alt;
  &:hover {
    background: \$highlight-alt-darken;
  }
}

.btn-color-inactive {
  background: \$inactive;
  opacity: 0.8;
}

// === SLIDERS ===
.metric scale trough highlight {
  background-color: \$highlight;
  border-radius: 50px;
}
.metric scale trough {
  background-color: \$grey;
  border-radius: 50px;
  min-height: 5px;
  min-width: 50px;
  margin-left: 10px;
  margin-right: 20px;
  @include trans();
  &:hover {
     min-height: 10px;
  }
}

" > ./eww.scss