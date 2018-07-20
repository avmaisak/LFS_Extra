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
	msg_success "Пакет $name $version"
	#загрузить исходник
	downloadpkgsrc $source 'downloads/'
	#распаковать исходник
	unpack "downloads/$(basename $source)" "sources/"
}


unpack() {
	msg "идёт распаковка"
	tar xf $1 -C $2
	msg_success "пакет распакован"
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
