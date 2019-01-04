#!/bin/sh
#
# pb; a command line pastebin service helper
#    {kopimi,CC0} MMXVIII . syntax samurai
#         ▟▙
# ▟▒░░░░░░░▜▙▜████████████████████████████████▛
# ▜▒░░░░░░░▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
#         ▜▛
# authors:
#   xero  <https://xero.nu>
#   stark <https://git.io/stark>
# code:
#   https://code.xero.nu/pb
#   https://git.io/pb.sh
# greets:
#   all the ops of these great free services <3
#
usage () {
    cat <<EOF

          █
     ▄▀▀▄ █▐▀▄
░ ░ ░█▐░█░█▐░█░ ░ ░
     █▐▄▀ ▀▄▄▀
     █

pb; a command line pastebin service helper

usage:
   pb <service> [file|stream]

services:
   ix.io, 0x0.st, sprunge.us, p.iotek.org,
   clbin.com, uguu.se, lewd.se, fiery.me,
   doko.me, mixtape.moe, pomf.cat, catbox.moe,
   asis.io, dmca.gripe, ptpb.pw, rokket.space,
   dumpz.org, n33r.tk, w1r3.net, pastebin.com

environment variables for pastebin.com:
   PB_API_DEV: developer api key [required] https://pastebin.com/api#1
   PB_API_USR: user api key [optional] https://pastebin.com/api#8
   PRIVACY: paste visibility  [optional] valid values: public|0, unlisted|1, private|2
   ANON: paste w/o a user key even if defined [optional]

examples:
   pb ix ~/.vimrc
   pb 0x0 <(ps aux)
   dmesg | pb iop
   PB_API_DEV=XXXX PRIVACY=0 pb pb /tmp/leak.txt

EOF
  exit 0
}

ARG="${2:-/dev/stdin}"

case $1 in
	ix|ix.io)
		curl -sF 'f:1=<-' http://ix.io < $ARG
	;;
	0x0|null|nullbyte|0*)
		curl -sF 'file=@-' https://0x0.st < $ARG
	;;
	sprunge|sprunge.us|s*)
		curl -sF 'sprunge=<-' http://sprunge.us < $ARG
	;;
	iotek|iopaste|p.iotek.org|iop*)
		curl -sT- https://p.iotek.org < $ARG
	;;
	w1r3|wire|w1r3.net|w*)
		curl -sF 'upload=@-' https://w1r3.net < $ARG
	;;
	clbin|clbin.com|cl*)
		curl -sF 'clbin=<-' https://clbin.com < $ARG
	;;
	uguu|uguu.se|u*)
		curl -sF 'file=@-' https://uguu.se/api.php?d=upload-tool < $ARG
	;;
	lewd|lewd.se|l*)
		curl -sF 'file=@-' https://lewd.se/api.php?d=upload-tool < $ARG
	;;
	fiery|fiery.me|f*)
		curl -sF 'files[]=@-' https://safe.fiery.me/api/upload < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//'
	;;
	doko|doko.me|do*)
		curl -sF 'files[]=@-' https://doko.moe/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	mixtape|mixtape.moe|m*)
		curl -sF 'files[]=@-' https://mixtape.moe/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	pomf|pomf.cat|po*)
		curl -sF 'files[]=@-' https://pomf.cat/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's!"url":"!https://a.pomf.cat/!;s/"//'
	;;
	catbox|catbox.moe|cat*)
		curl -sF 'reqtype=fileupload' -F 'fileToUpload=@-' https://catbox.moe/user/api.php < $ARG
	;;
	asis|asis.io|a*)
		curl -sF 'files[]=@-' https://up.asis.io/upload.php < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's!"url":"!https://dl.asis.io/!;s/"//'
	;;
	dmca|dmca.gripe|gripe|dm*)
		curl -sF 'files[]=@-' http://dmca.gripe/api/upload < $ARG | grep -Po '"url":"[A-Za-z0-9]+.*?"' | sed 's/"url":"//;s/"//;s/[\]//g'
	;;
	ptpb|ptpb.pw|pt*)
		curl -sF 'c=@-' https://ptpb.pw/ < $ARG | grep "url:" | sed 's/url: //'
	;;
	rokket|rokket.space|r*)
		curl -sF 'files[]=@-' https://rokket.space/upload < $ARG | grep 'url' | sed 's/"url": "//;s/",//;s/ //g'
	;;
	dumpz|dumpz.org|du*)
		curl -s --data-binary @- https://dumpz.org < $ARG | sed 's/http/&s/;s!$!/text/!'
	;;
	n33r|n33r.tk|n*)
		curl -sF 'files[]=@-' https://n33r.tk/upload.php < $ARG | grep 'url' | sed 's/.*"url": "//;s/"//;s/[\]//g;s/[",]//;s/http/&s/'
	;;
	pb|pastebin|pastebin.com)
		[ -z ${PB_API_DEV} ] && usage
		PRIVACY="${PRIVACY:-1}"
		if [ -n "${PRIVACY}" ]; then
			case ${PRIVACY} in
				public|0)
					PRIVACY=0
				;;
				unlisted|1)
					PRIVACY=1
				;;
				private|2)
					PRIVACY=2
				;;
				*)
					usage
				;;
			esac
		fi
		qs="api_option=paste&api_dev_key=${PB_API_DEV}&api_paste_expire_date=N&api_paste_private=${PRIVACY}&api_paste_name=`basename ${ARG}`"
		[ -n ${PB_API_USR} ] && [ -z ${ANON} ] && qs="${qs}&api_user_key=${PB_API_USR}"
		curl -d "${qs}" --data-urlencode "api_paste_code=`<$ARG`" http://pastebin.com/api/api_post.php
	;;
	*)
		usage
	;;
esac
# vi:syntax=sh
