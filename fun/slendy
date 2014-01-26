#!/bin/sh

initializeANSI()
{
  esc=""

  blackf="${esc}[30m";   redf="${esc}[31m";    greenf="${esc}[32m"
  yellowf="${esc}[33m"   bluef="${esc}[34m";   purplef="${esc}[35m"
  cyanf="${esc}[36m";    whitef="${esc}[37m"
  
  blackb="${esc}[40m";   redb="${esc}[41m";    greenb="${esc}[42m"
  yellowb="${esc}[43m"   blueb="${esc}[44m";   purpleb="${esc}[45m"
  cyanb="${esc}[46m";    whiteb="${esc}[47m"

  boldon="${esc}[1m";    boldoff="${esc}[22m"
  italicson="${esc}[3m"; italicsoff="${esc}[23m"
  ulon="${esc}[4m";      uloff="${esc}[24m"
  invon="${esc}[7m";     invoff="${esc}[27m"

  reset="${esc}[0m"
}

initializeANSI

cat << EOF

              ${reset}${blackf}|               |               |               |               |${reset}
   ${redf}█     █${reset}    ${blackf}|${reset}    ${greenf}█     █${reset}    ${blackf}|${reset}    ${yellowf}█     █${reset}    ${blackf}|${reset}    ${bluef}█     █${reset}    ${blackf}|${reset}    ${purplef}█     █${reset}    ${blackf}|${reset}    ${cyanf}█     █${reset}
   ${redf}███████${reset}    ${blackf}|${reset}    ${greenf}███████${reset}    ${blackf}|${reset}    ${yellowf}███████${reset}    ${blackf}|${reset}    ${bluef}███████${reset}    ${blackf}|${reset}    ${purplef}███████${reset}    ${blackf}|${reset}    ${cyanf}███████${reset}
 ${redf}███${boldon}${redb}██${reset}${redf}█${boldon}${redb}██${reset}${redf}███${reset}  ${blackf}|${reset}  ${greenf}███${boldon}${greenb}██${reset}${greenf}█${boldon}${greenb}██${reset}${greenf}███${reset}  ${blackf}|${reset}  ${yellowf}███${boldon}${yellowb}██${reset}${yellowf}█${boldon}${yellowb}██${reset}${yellowf}███${reset}  ${blackf}|${reset}  ${bluef}███${boldon}${blueb}██${reset}${bluef}█${boldon}${blueb}██${reset}${bluef}███${reset}  ${blackf}|${reset}  ${purplef}███${boldon}${purpleb}██${reset}${purplef}█${boldon}${purpleb}██${reset}${purplef}███${reset}  ${blackf}|${reset}  ${cyanf}███${boldon}${cyanb}██${reset}${cyanf}█${boldon}${cyanb}██${reset}${cyanf}███${reset}
  ${redf}████${boldon}${redb}█${reset}${redf}████${reset}   ${blackf}|${reset}   ${greenf}████${boldon}${greenb}█${reset}${greenf}████${reset}   ${blackf}|${reset}   ${yellowf}████${boldon}${yellowb}█${reset}${yellowf}████${reset}   ${blackf}|${reset}   ${bluef}████${boldon}${blueb}█${reset}${bluef}████${reset}   ${blackf}|${reset}   ${purplef}████${boldon}${purpleb}█${reset}${purplef}████${reset}   ${blackf}|${reset}   ${cyanf}████${boldon}${cyanb}█${reset}${cyanf}████${reset}
  ${redf}█ █ ${boldon}█${reset} ${redf}█ █${reset}   ${blackf}|${reset}   ${greenf}█ █ ${boldon}█${reset} ${greenf}█ █${reset}   ${blackf}|${reset}   ${yellowf}█ █ ${boldon}█${reset} ${yellowf}█ █${reset}   ${blackf}|${reset}   ${bluef}█ █ ${boldon}█${reset} ${bluef}█ █${reset}   ${blackf}|${reset}   ${purplef}█ █ ${boldon}█${reset} ${purplef}█ █${reset}   ${blackf}|${reset}   ${cyanf}█ █ ${boldon}█${reset} ${cyanf}█ █${reset}
    ${redf}█   █${reset}     ${blackf}|${reset}     ${greenf}█   █${reset}     ${blackf}|${reset}     ${yellowf}█   █${reset}     ${blackf}|${reset}     ${bluef}█   █${reset}     ${blackf}|${reset}     ${purplef}█   █${reset}     ${blackf}|${reset}     ${cyanf}█   █${reset}
              ${blackf}|               |               |               |               |${reset}
EOF