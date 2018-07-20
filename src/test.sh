#!/bin/bash

source './utils.sh'
ports_desination='./ports/toolchain/'
clear

# Загрузить пакет
getpkg() {
	#каталог
	folder=$ports_desination$1
	FileExist $folder
	source $folder
	msg_success "Пакет $name-$version"
	#загрузить исходник
	downloadpkgsrc $source 'downloads/'
	#распаковать исходник
	basename="$(basename $source)"
	unpack "downloads/$basename" "sources/" "$name-$version"
	cd "sources/$name-$version"
	msg "идёт сборка"
	build
}


unpack() {
	msg "идёт распаковка в $2$3"
	rm -rf $2$3
	tar xf $1 -C $2
	msg_success "пакет распакован"
	cd $2$3
}

downloadpkgsrc(){

	filename=$(basename $source)
	dest="$2/$filename"
	msg "Подождите, идёт загрузка пакета ..."

	if ! [ -f $dest ]; then
		curl --url $1 --output $dest --silent
	fi

	msg_success "Пакет загружен"
}

getpkg $1
