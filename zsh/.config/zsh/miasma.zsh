# ┏┏┓o┳━┓┓━┓┏┏┓┳━┓
# ┃┃┃┃┃━┫┗━┓┃┃┃┃━┫
# ┛ ┇┇┛ ┇━━┛┛ ┇┛ ┇
#  miasma by xero (https://x-e.ro)

#█▓▒░ tty colors
if [ "$TERM" = "linux" ]
then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8666666" #darkgrey
    echo -en "\e]P1685742" #darkred
    echo -en "\e]P9685742" #red
    echo -en "\e]P25f875f" #darkgreen
    echo -en "\e]PA5f875f" #green
    echo -en "\e]P3B36D43" #brown
    echo -en "\e]PBB36D43" #yellow
    echo -en "\e]P478824B" #darkblue
    echo -en "\e]PC78824b" #blue
    echo -en "\e]P5bb7744" #darkmagenta
    echo -en "\e]PDbb7744" #magenta
    echo -en "\e]P6C9A554" #darkcyan
    echo -en "\e]PEC9A554" #cyan
    echo -en "\e]P7D7C483" #lightgrey
    echo -en "\e]PFD7C483" #white
    clear #for background artifacting
fi
