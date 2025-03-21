#!/usr/bin/env zsh
#                 ██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.style>
# ░▓ code   ▓ https://code.x-e.ro/dotfiles
# ░▓ mirror ▓ https://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░

[[ -z "$UI_THEME" ]] && UI_THEME="MIASMA"
if [[ "$UI_THEME" == "EVANGELION" ]]; then
cat << X0
[0m [1;35mG[0m [1;35mE[0m [1;35mT[0m   [1;35mI[0m [1;35mN[0m   [1;35mT[0m [1;35mH[0m [1;35mE[0m   [1;35mF[0m [1;35mU[0m [1;35mK[0m [1;35mK[0m [1;35mE[0m [1;35mN[0m  [1m [1;35mR[0m [1;35mO[0m [1;35mB[0m [1;35mO[0m [1;35mT[0m   [1;35mS[0m [1;35mH[0m [1;35mI[0m [1;35mN[0m [1;35mJ[0m [1;35mI[0m
                  [1;37m_[0m   [30m         [1;37m____
                 [1;32m:[0m [1m\\[0m  [30m         [1;32m|[0m   [1m\\[0;30m    [1;37m.
                 [1;32m| [0;30m [37m\\ [1m.[0m  [30m      [1;32m|[0m    [1;35m:[0;30m   [1;32m|[37m\\[0;30m           [37m [1;32m/[37m\\
             [37m [1m.[0;30m  [1;32m|[0;32m [30m  [1;35m:[32m|[37m\\__[0m  [30m   [1;32m|[0m  [30m  [1;35m|[0;30m   [1;32m|[0;30m [37m\\[30m         [37m [1;32m/[0;30m  [37m\\
[1;37m.[0m [30m           [37m [1;32m|[37m\\[0;30m [1;32m|[0m [30m  [1;35m|[32m! \\[0;30m [1;37m\\[0m [30m   [1;32m|[0m  [30m  [35m| [30m  [1;32m|[0m [1;32m|[35m\\[0;35m [30m       [1;32m/[0;30m   [1;35m/
[1;32m\\[37m"[0m-[35m.[1m________[0m  [1;32m| [0m\\[1;32m:[0m [30m  [35m|[1;32m|\\[0;32m \\[30m [37m\\[30m   [1;32m|[0m  [30m  [35m|[30m   [1;32m|[0;30m [32m| [35m\\[30m      [1;32m/[0;30m   [35m/
 [1;32m\\[0;32m_____[30m     [35m"-[1;32m|[0m  [35m|[32m\\[30m  [35m|[1;32m|[0;30m [32m\\ \\[35m/[30m   [1;32m|[0m  [30m  [35m|[1m___[32m|[0;30m [32m![30m [1;32m|[0;35m\\[1m____[32m/[0;30m  [35m_/[1m-.[0m [1;32m/[37m\\
    [37m  [1;32m\\[0m  [30m [32m____:[37m  [35m|[1m_[0;32m\\[30m [35m|[1;32m|[0;30m  [32m\\[35m/[30m  [1;37m_[35m__[0;32m\\[37m [30m [32m__[30m  [32m_[35m//[37m [30m [32m|[37m [1;32m|[0;35m [30m [32m___[30m [35m\\[32m---"[37m [1m/
      [37m [1;32m\\[0m  [35m\\[37m [30m  [1;32m|[0m  [32m_____,[30m  [35m/[1m___[32m\\[0;32m___\\[35m/[30m [32m/[30m [35m/ [37m  [1;32m\\[0;32m_![30m [32m|[30m  [35m/[1;32m/[0;30m [32m_[35m/[30m [37m [1;32m/[0m [1;35m/
    [1;35m____[32m\\[0;32m_[30m [1;35m\\__[32m|[0m  [35m|[30m   [37m [1;32m|[0;30m [32m__.[30m [32m_[35m/[1m____[0;30m [32m/[37m [35m/ [30m   [37m [1;32m/[0m [30m [35m>[30m [35m/[1;32m/[0;30m [35m/[30m [37m  [1;32m \\[1;35m/
  [1;32m/[0;32m/__________[1m|[0m  [35m/[30m    [1;32m|[0;35m/[37m  [1;32m|[0;35m/ [30m [1;32m\\[0;32m__[35m/[32m/[30m [35m/ [30m    [1;32m/[0m [30m [35m/[32m_[35m/ [32m\\[1;35m/
              [1;32m|[35m /[0m [30m    [1;32m|[0m [30m  [32m:[35m [37m [30m    [1;32m|[0m [1;35m/[0;35m [30m    [1;32m/[0;32m__[1;35m/
              [1;32m|[35m/  [0;30m               [1;32m|[35m/[0m
X0
else
	_RAND=`shuf -i1-2 -n1`
	case $_RAND in
		1)
cat << X0
[0;36m  _ ___  ______ _ ______   _ _______  _ _______
 _╲╲╲  ╲╱     [0;34m╱[0;36m_╲╲╲ _  [0;34m╱[0;36m_ _╲╲╲_     [0;34m╲[0;36m_╲╲╲  _   [0;34m╲
 [0;34m╲    _╱     ╱      ╲_╱  ╲    [0;36m╱   [0;34m__╱      [0;34m╱    [0;34m╲
[0;37m ╱    ╲      [0;34m╲__          ╲   [0;37m╲     [0;34m╲__   ╱     [30;32m╱
[0;37m╱[0;31m_____[0;37m╱╲       [30;32m╱[0;31m__________[0;37m╱[0;31m____[0;37m╲      [30;32m╱[0;31m________[30;32m╱
[0;37m        ╲[0;31m_____[30;32m╱                 [0;37m╲[0;31m____[30;32m╱x0[38;5;240m^[0;31mb7[38;5;240m^[0;31mimp[38;5;240m! [0m
X0
		;;
		2)
cat << X0
[0;36m___╱[37m╲[0;36m [1m _____ ╱[37m╲[36m______[0;36m [1m____╱[37m╲[0;36m   [1m___╱[37m╲
[36m╲[0;36m [1;33m_[0;36m  [37m╲[1;36m╱[0;36m  [1;33m.:[37m╱[36m╱[33m.:[0m╲[36m____[1;37m╱[36m╱[33m_[0m╲[36m_[1;33m.[0;36m  [1;37m╲[0;36m [1m╱[33m.[36m╱[0;36m__ [1;37m╲
[0;36m [1m╲[33m╲[0;36m  ╱    [37m╱[36m╱    ___[37m╱[36m╱  [1;33m.[0m╲[1;36m╱[0;36m _[37m╱[1;36m╱[0;36m ╲  [1m╱[0;36m  [37m╲
[36m ╱[1;33m.:[0;36m ╲    ╲[1;33m_.[0;36m[5C[37m╱[36m╱    _[1;33m. [37m╲[36m╱ [1;33m.:[0;36m╲╱   [37m╱
[36m╱[1;34m____[0m╱[36m╲  [1;34m__[0;36m╲[1;34m╱[34m__[0;36m  [37m╱[36m╱[1;34m______[0;36m│ [37m╱[36m╲[1;34m_______[0m╱
[36m[7C╲[37m╱[36m[6C╲[37m╱[36m[8C│[37m╱[1mx0[34m^[0m67[1;34m^[0miMP[1;34m! [0m
X0
		;;
	esac
fi
