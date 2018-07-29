#!/bin/bash
source './utils.sh'
source './cfg'

if [ $# -eq 0 ]
	then
	msg_err "No arguments supplied"
	exit 1
fi

case "$1" in
 "help")
    source './help'
<<<<<<< HEAD
=======

>>>>>>> c1d6ca8d5fe36896286afe812d34ecaded2bb2dc
    ;;

  "r")
    msg_success "repository type: [$repo]"
    msg_success "repository url:  [$repo_url]"
    ;;

  "v")
     msg "asd version:  [$version]"
    ;;

	"a")
     # msg "asd version:  [$version]"
	  # curl -K myconfig.txt >> output.txt
	  # D=$repo_url/$repo/$2
	  # P=$(curl $D)
	  # build()
	;;

  *)
    echo "Такого аргумента нет. Смотрите информацию [#asd help]"
    exit 1
    ;;
esac
