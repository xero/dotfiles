#!/bin/bash
#       ██                          ████ 
#      ░██                         █░░░░█
#      ░██ ██████  █████  ███████ ░░   ░█
#   ██████░░░░██  ██░░░██░░██░░░██   ███ 
#  ██░░░██   ██  ░███████ ░██  ░██  █░░  
# ░██  ░██  ██   ░██░░░░  ░██  ░██ █░    
# ░░██████ ██████░░██████ ███  ░██░██████
#  ░░░░░░ ░░░░░░  ░░░░░░ ░░░   ░░ ░░░░░░ 

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=16
#font="-*-fixed-medium-*-*-*-12-*-*-*-*-*-*-*"
font="-Gohu-GohuFont-Medium-R-Normal--11-80-100-100-C-60-ISO10646-1"
#font2="-misc-stlarch-medium-r-normal--10-100-75-75-c-80-iso10646-1"

bgcolor=$(hc get frame_bg_active_color)
selbg='#6A8C8C'
selfg='#101010'

####
# Try to find textwidth binary.
# In e.g. Ubuntu, this is named dzen2-textwidth.
if which textwidth &> /dev/null ; then
    textwidth="textwidth";
elif which dzen2-textwidth &> /dev/null ; then
    textwidth="dzen2-textwidth";
else
    echo "This script requires the textwidth tool of the dzen2 project."
    exit 1
fi
####
# true if we are using the svn version of dzen2
# depending on version/distribution, this seems to have version strings like
# "dzen-" or "dzen-x.x.x-svn"
if dzen2 -v 2>&1 | head -n 1 | grep -q '^dzen-\([^,]*-svn\|\),'; then
    dzen2_svn="true"
else
    dzen2_svn=""
fi

if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'; then
    # mawk needs "-W interactive" to line-buffer stdout correctly
    # http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=593504
    uniq_linebuffered() {
      awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
else
    # other awk versions (e.g. gawk) issue a warning with "-W interactive", so
    # we don't want to use it there.
    uniq_linebuffered() {
      awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
fi

hc pad $monitor $panel_height

{
    ### Event generator ###
    # based on different input data (mpc, date, hlwm hooks, ...) this generates events, formed like this:
    #   <eventname>\t<data> [...]
    # e.g.
    #   date    ^fg(#efefef)18:33^fg(#909090), 2013-10-^fg(#efefef)29

    #mpc idleloop player &
    while true ; do
        # "date" output is checked once a second, but an event is only
        # generated if the output changed compared to the previous run.
        date +$'date\t ^ca(1,~/code/sys/calendar)^fg(#d9d9d9)^i(/usr/share/icons/stlarch_icons/clock1.xbm) ^fg(#efefef)%H:%M^fg(#bcbcbc) %Y-%m-^fg(#efefef)%d^ca() '
        sleep 1 || break
    done > >(uniq_linebuffered) &
    childpid=$!
    hc --idle
    kill $childpid
} 2> /dev/null | {
    IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
    visible=true
    date=""
    windowtitle=""
    while true ; do

        ### Output ###
        # This part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.

        bordercolor="#26221C"tags
        separator=" "
        xicon="#d9d9d9"
        xtitle="#bcbcbc"
        xfg="#ffffff"
        xext="#909090"
        cool="#6A8C8C"
        hot="#990000"
        # draw tags
        for i in "${tags[@]}" ; do
            case ${i:0:1} in
                '#')
                    echo -n "^bg(#6A8C8C)^fg(#101010)"
                    ;;
                '+')
                    echo -n "^bg(#666666)^fg(#141414)"
                    ;;
                ':')
                    echo -n "^bg(#222222)^fg(#ffffff)"
                    ;;
                '!')
                    echo -n "^bg(#F92672)^fg(#141414)"
                    ;;
                *)
                    echo -n "^bg($bgcolor)^fg($xtitle)"
                    ;;
            esac
            if [ ! -z "$dzen2_svn" ] ; then
                # clickable tags if using SVN dzen
                echo -n "^ca(1,\"${herbstclient_command[@]:-herbstclient}\" "
                echo -n "focus_monitor \"$monitor\" && "
                echo -n "\"${herbstclient_command[@]:-herbstclient}\" "
                #echo -n "use \"${i:1}\") ^i(/usr/share/icons/stlarch_icons/diamond1.xbm) ^ca()"
                echo -n "use \"${i:1}\") ${i:1} ^ca()"
            else
                # non-clickable tags if using older dzen
                echo -n " ${i:1} "
            fi
        done
        echo -n "$separator"
        #echo -n "^bg()^fg() ${windowtitle//^/^^}"
        temp=`sensors | awk '/Core\ 0/ {gsub(/\+/,"",$3); gsub(/\..+/,"",$3); print $3}'`
        # temp heat colorizing
        if (($temp<=50))
        then
            temp="^fg($cool)$temp"
        elif (($temp>50 && $temp<=75))
        then
            temp="^fg($xfg)$temp"
        elif (($temp>76))
        then
            temp="^fg($hot)$temp"
        else
            temp="^fg($xfg)$temp"
        fi
        temp="^fg($xicon)^i(/usr/share/icons/stlarch_icons/temp1.xbm) ^fg($xtitle)temp $temp^fg($xext)°c"
        #up time
        upSeconds=`cat /proc/uptime`;
        upSeconds=${upSeconds%%.*};
        let secs=$((${upSeconds}%60))
        let mins=$((${upSeconds}/60%60))
        let hours=$((${upSeconds}/3600%24))
        let days=$((${upSeconds}/86400))
        uptime="^fg($xicon)^i(/usr/share/icons/stlarch_icons/uparrow1.xbm) ^fg($xtitle)uptime ^fg($xfg)${days}^fg($xext)d ^fg($xfg)${hours}^fg($xext)h ^fg($xfg)${mins}^fg($xext)m"
        #pacman updates
        updates=`pacman -Quq | wc -l`
        updates="^fg($xicon)^i(/usr/share/icons/stlarch_icons/pacman1.xbm) ^fg($xtitle)pacman ^fg($xfg)$updates"
        #cpu
        cpu=`mpstat | awk '$3 ~ /CPU/ { for(i=1;i<=NF;i++) { if ($i ~ /%idle/) field=i } } $3 ~ /all/ { print 100 - $field }'`
        cpu="^fg($xicon)^i(/usr/share/icons/stlarch_icons/cpu1.xbm) ^fg($xtitle)cpu ^fg($xfg)$cpu^fg($xext)%"
        #memory
	mem=`free | awk '/Mem:/ {print int($3/$2 * 100.0)}'`
	mem="^fg($xicon)^i(/usr/share/icons/stlarch_icons/mem1.xbm) ^fg($xtitle)ram ^fg($xfg)$mem^fg($xext)%"
        #battery
        bat=`cat /sys/class/power_supply/BAT1/capacity`
        batstat=`cat /sys/class/power_supply/BAT1/status`
        if (($batstat=='Charging'))
        then
            batico="^i(/usr/share/icons/stlarch_icons/ac10.xbm)"
        else
            batico="^i(/usr/share/icons/stlarch_icons/batt5full.xbm)"
        fi
        bat="^fg($xicon)$batico ^fg($xtitle)battery ^fg($xfg)$bat^fg($xext)%"
        #cyberspace
        # read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
        # if iwconfig $int1 >/dev/null 2>&1; then
        #     wifi=$int1
        #     eth0=$int2
        # else
        #     wifi=$int2
        #     eth0=$int1
        # fi
        # ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 || int=$wifi
        # if (($int==$wifi))
        # then
        #     net="^fg($xicon)^i(/usr/share/icons/stlarch_icons/wireless5.xbm) ^fg($xtitle)network ^fg($xfg)wifi"
        # elif (($int==$eth0))
        # then
        #     net="^fg($xicon)^i(/usr/share/icons/stlarch_icons/ac5.xbm) ^fg($xtitle)network ^fg($xfg)ethernet"
        # else
        #     net="^fg($xicon)^i(/usr/share/icons/stlarch_icons/dice5.xbm) ^fg($xtitle)network ^fg($xfg)disconnected"
        # fi
        #combine
        right="^bg($bgcolor) $cpu $separator $mem $separator $temp $separator $bat $separator $updates $separator $uptime               $date $separator $separator"

        right_text_only=$(echo -n "$right" | sed 's.\^[^(]*([^)]*)..g')
        # get width of right aligned text.. and add some space..
        width=$($textwidth "$font" "$right_text_only    ")
        echo -n "^pa($(($panel_width - $width)))$right"
        echo

        ### Data handling ###
        # This part handles the events generated in the event loop, and sets
        # internal variables based on them. The event and its arguments are
        # read into the array cmd, then action is taken depending on the event
        # name.
        # "Special" events (quit_panel/togglehidepanel/reload) are also handled
        # here.

        # wait for next event
        IFS=$'\t' read -ra cmd || break
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                #echo "resetting tags" >&2
                IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
                ;;
            date)
                #echo "resetting date" >&2
                date="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            togglehidepanel)
                currentmonidx=$(hc list_monitors | sed -n '/\[FOCUS\]$/s/:.*//p')
                if [ "${cmd[1]}" -ne "$monitor" ] ; then
                    continue
                fi
                if [ "${cmd[1]}" = "current" ] && [ "$currentmonidx" -ne "$monitor" ] ; then
                    continue
                fi
                echo "^togglehide()"
                if $visible ; then
                    visible=false
                    hc pad $monitor 0
                else
                    visible=true
                    hc pad $monitor $panel_height
                fi
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            #player)
            #    ;;
        esac
    done

    ### dzen2 ###
    # After the data is gathered and processed, the output of the previous block
    # gets piped to dzen2.

} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y -fn "$font" -h $panel_height \
    -e 'button3=;button4=exec:herbstclient use_index -1;button5=exec:herbstclient use_index +1' \
    -ta l -bg "$bgcolor" -fg '#efefef' & 

sleep 2
stalonetray
