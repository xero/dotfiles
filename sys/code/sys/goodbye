#!/bin/bash
echo ''
echo '    ██             ██                        '
echo '   ░██            ░██                        '
echo '   ░██  ██████   ██████  █████  ██████ ██████'
echo '   ░██ ░░░░░░██ ░░░██░  ██░░░██░░██░░█░░░░██ '
echo '   ░██  ███████   ░██  ░███████ ░██ ░    ██  '
echo '   ░██ ██░░░░██   ░██  ░██░░░░  ░██     ██   '
echo '   ███░░████████  ░░██ ░░██████░███    ██████'
echo '  ░░░  ░░░░░░░░    ░░   ░░░░░░ ░░░    ░░░░░░ '
echo ''
OPTIONS='cancel reboot shutdown'
PS3='select option (1-3): '
select opt in $OPTIONS; 
do
    if [ "$opt" = "cancel" ]; then
        echo '░░▒▒▓▓███▓▓▒▒░░'
        echo 'nevermind...'
        echo ''
        exit
    elif [ "$opt" = "reboot" ]; then
        echo '░░▒▒▓▓███▓▓▒▒░░'
        echo 'rebooting...'
        echo ''
        systemctl reboot
    elif [ "$opt" = "shutdown" ]; then
        echo '░░▒▒▓▓███▓▓▒▒░░'
        echo 'shuting down...'
        echo ''
        systemctl poweroff
    else
        echo '░░▒▒▓▓███▓▓▒▒░░'
        echo 'wat?'
        echo ''
        exit
    fi
done