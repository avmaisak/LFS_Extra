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
    msg_success "temp folder:  [$dest_temp]"
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

		curl --url $URL -K $2 >> $PKG_META_TEMP_DEST --silent
		source "$PKG_META_TEMP_DEST"

		# указан source
		if [ "$source" ]; then
			# имя файла
			filename="${source##*/}"
			# путь до загруженного архива
			PKG_SRC="$dest_temp/$filename"
			# загрузка файла из источника
			curl --insecure -L --url $source --output $PKG_SRC --silent
			PKG_SRC_UNPACK_DEST="$dest_temp/$name-$version"
			# распаковка
			tar -xf $PKG_SRC -C $dest_temp
			cd "$PKG_SRC_UNPACK_DEST"
			# сборка
			build
		fi

		declare -F execute && execute

		rm -rvf $PKG_META_TEMP_DEST
		rm -rvf $PKG_SRC_UNPACK_DEST
		rm -rvf $PKG_SRC
	;;

  *)
    echo "Такого аргумента нет. Смотрите информацию [#asd help]"
    exit 1
    ;;
esac
