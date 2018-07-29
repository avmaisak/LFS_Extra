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
    ;;

  "r")
    msg_success "repository type: [$repo]"
    msg_success "repository url:  [$repo_url]"
    ;;

  "v")
     msg "asd version:  [$version]"
    ;;

	"a")
		if [ -z "$2" ]; then
			echo "package not specified"
			exit 1
		fi

		URL=$repo_url/$repo/$2
		PKG_META_TEMP_DEST="$dest_temp/$2"

		rm -rvf $PKG_META_TEMP_DEST

		echo "installing package from url $URL to destination folder $PKG_META_TEMP_DEST"

		curl --url $URL -K $2 >> $PKG_META_TEMP_DEST --silent
		source "$PKG_META_TEMP_DEST"

		# указан source
		if [ "$source" ]; then
			# имя файла
			filename="${source##*/}"
			# путь до загруженного архива
			PKG_SRC="$dest_temp/$filename"
			echo "package $PKG_SRC"
			curl --url $URL -K $2 >> "$PKG_SRC" --silent
			tar xvf $PKG_SRC
			cd "$name-$version"
		fi

		build
	;;

  *)
    echo "Такого аргумента нет. Смотрите информацию [#asd help]"
    exit 1
    ;;
esac
