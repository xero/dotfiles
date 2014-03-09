#!/bin/bash
 
pci_integrated=$(lspci | grep VGA | sed -n '1p' | cut -f 1 -d " ")
pci_discrete=$(lspci | grep VGA | sed -n '2p' | cut -f 1 -d " ")
 
integrated=$(cat /sys/kernel/debug/vgaswitcheroo/switch | grep $pci_integrated | grep -o -P ':.:...:')
discrete=$(cat /sys/kernel/debug/vgaswitcheroo/switch | grep $pci_discrete | grep -o -P ':.:...:')
 
name_integrated=$(lspci | grep VGA | sed -n '1p' | sed -e "s/.* VGA compatible controller[ :]*//g" | sed -e "s/ Corporation//g" | sed -e "s/ Technologies Inc//g" | sed -e 's/\[[0-9]*\]: //g' | sed -e 's/\[[0-9:a-z]*\]//g' | sed -e 's/(rev [a-z0-9]*)//g' | sed -e "s/ Integrated Graphics Controller//g")
name_discrete=$(lspci | grep VGA | sed -n '2p' | sed -e "s/.* VGA compatible controller[ :]*//g" | sed -e "s/ Corporation//g" | sed -e "s/ Technologies Inc//g" | sed -e 's/\[[0-9]*\]: //g' | sed -e 's/\[[0-9:a-z]*\]//g' | sed -e 's/(rev [a-z0-9]*)//g' | sed -e "s/ Integrated Graphics Controller//g")
 
if [ "$integrated" = ":+:Pwr:" ]
then
integrated_condition="on"
elif [ "$integrated" = ": :Pwr:" ]
then
integrated_condition="on"
elif [ "$integrated" = ": :Off:" ]
then
integrated_condition="off"
fi
 
if [ "$discrete" = ":+:Pwr:" ]
then
discrete_condition="on"
elif [ "$discrete" = ": :Pwr:" ]
then
discrete_condition="on"
elif [ "$discrete" = ": :Off:" ]
then
discrete_condition="off"
fi

notify-send -t 5000 \
-i "/home/xero/.config/awesome/themes/ghost/gfx.png" \
'  gfx status 
░░▒▒▓▓███▓▓▒▒░░' \
" intel  = $integrated_condition 
 radeon = $discrete_condition"