#!/usr/bin/env bash

# If the '-e' flag is passed, cells will be three rows high.
if [ "$1" == "-e" ]; then
    expanded=true;
else
    expanded=false
fi

# If the option --sixteen is given, only show the first 16 colors
if [ "$1" == "-16" ]; then
    showall=true;
    sixteen=true;
    expanded=true;
else
    sixteen=false
fi

# Creates a color row.
# Arguments:
#   - width (number)
#   - starting color (number)
#   - ending color (number)
row () {
    # Give the arguments names for scope reasons.
    width=$(($1 - 2))
    start=$2
    end=$3

    # Creates a "slice" (one terminal row) of a row.
    # Can be have number labels or be blank.
    # Arguments:
    #   - label (boolean)
    slice () {
        for ((i=$start; i<=$end; i++))
        do
            # Determine if there will be a label on this cell (this is actually
            # a per slice setting but the title needs to be set on each cell
            # because of the numbering).
            if [ $1 ]; then string=$i; else string=' '; fi

            # Change background to the correct color.
            tput setab $i

            # Print the cell.
            printf "%${width}s " $string
        done

        # Clear the coloring to avoid nasty wrapping colors.
        tput sgr0
        echo
    }

    if [ $expanded == true ]; then
        # Print a blank slice, a labeled one, and then a blank one.
        slice; slice true; slice
    else
        # Just print the labeled slice.
        slice true
    fi
}

display () {

    # Get the widths based on columns.
    cols=$(tput cols)
    sixth=$(($cols/6))
    eighth=$(($cols/8))
    twelfth=$(($cols/12))

    # Give it some room to breathe.
    echo

    # The first sixteen colors.
    row $eighth 0 7
    row $eighth 8 15
    echo

    if [ $sixteen == true ]; then
        exit
    fi

    # 16-231.
    for ((a=0; a<=35; a++))
    do
        row $sixth $((16 + (6 * a))) $((21 + (6 * a)))
    done
    echo

    # Greyscale.
    row $twelfth 232 243
    tput setaf 0
    row $twelfth 244 255

    # Clear before exiting.
    tput sgr0
    echo
}

# Show that table thang!
display
