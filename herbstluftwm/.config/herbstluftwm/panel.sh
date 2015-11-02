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
if [ -z "$geometry" ]
then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=268
panel_height=16
#font="-*-fixed-medium-*-*-*-12-*-*-*-*-*-*-*"
font="-Gohu-GohuFont-Medium-R-Normal--11-80-100-100-C-60-ISO10646-1"
#font2="-misc-stlarch-medium-r-normal--10-100-75-75-c-80-iso10646-1"

bgcolor='#000000'
selbg='#6A8C8C'
selfg='#101010'

# try to find textwidth binary.
if which textwidth &> /dev/null ; then
    textwidth="textwidth";
elif which dzen2-textwidth &> /dev/null ; then
    textwidth="dzen2-textwidth";
else
    echo "This script requires the textwidth tool of the dzen2 project."
    exit 1
fi

# detect version
if dzen2 -v 2>&1 | head -n 1 | grep -q '^dzen-\([^,]*-svn\|\),'
then
    dzen2_svn="true"
else
    dzen2_svn=""
fi

if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'
then
    # mawk needs "-W interactive" to line-buffer stdout correctly
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
    ### event generator ###
    # based on different input data (mpc, date, hlwm hooks, ...) this generates events, formed like this:
    #   <eventname>\t<data> [...]
    # e.g.
    #   date    ^fg(#efefef)18:33^fg(#909090), 2013-10-^fg(#efefef)29

    #mpc idleloop player &
    while true
    do
        # "date" output is checked once a second, but an event is only
        # generated if the output changed compared to the previous run.
        date +$'date\t ^ca(1,~/bin/calendar)^fg(#d9d9d9)^i(/usr/share/icons/stlarch_icons/clock1.xbm) ^fg(#efefef)%H:%M^fg(#bcbcbc) %Y-%m-^fg(#efefef)%d^ca()'
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
    while true
    do

        ### output ###
        # this part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.

        echo -n "^bg($bgcolor)$date ^bg(#111111)           "
        # draw tags
        for i in "${tags[@]}"
        do
            case ${i:0:1} in
                '#')
                    echo -n "^bg(#5F8787)^fg(#222222)"
                    ;;
                '+')
                    echo -n "^bg(#666666)^fg(#141414)"
                    ;;
                ':')
                    echo -n "^bg(#3a3a3a)^fg(#bcbcbc)"
                    ;;
                '!')
                    echo -n "^bg(#F92672)^fg(#141414)"
                    ;;
                *)
                    echo -n "^bg(#222222)^fg(#bcbcbc)"
                    ;;
            esac
            if [ ! -z "$dzen2_svn" ]
            then
                # clickable tags if using SVN dzen
                echo -n "^ca(1,\"${herbstclient_command[@]:-herbstclient}\" "
                echo -n "focus_monitor \"$monitor\" && "
                echo -n "\"${herbstclient_command[@]:-herbstclient}\" "
                echo -n " "
            fi
            if [ ${i:0:1 } == "#" ]
            then
                echo -n "use \"${i:1}\") ^i(/usr/share/icons/stlarch_icons/monocle2.xbm) ^ca()"
            else
                echo -n "use \"${i:1}\") ^i(/usr/share/icons/stlarch_icons/monocle.xbm) ^ca()"
            fi
        done
        echo

        ### data handling ###
        # this part handles the events generated in the event loop, and sets
        # internal variables based on them. The event and its arguments are
        # read into the array cmd, then action is taken depending on the event
        # name.
        # "special" events (quit_panel/togglehidepanel/reload) are also handled
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
                if [ "${cmd[1]}" = "current" ] && [ "$currentmonidx" -ne "$monitor" ]
                then
                    continue
                fi
                echo "^togglehide()"
                if $visible
                then
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
    # after the data is gathered and processed, pipe the output to dzen2.

} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y -fn "$font" -h $panel_height \
    -e 'button3=;button4=exec:herbstclient use_index -1;button5=exec:herbstclient use_index +1' \
    -ta l -bg "$bgcolor" -fg '#efefef' & 

#wait 2 seconds then load the stand alone tray
sleep 2
stalonetray
