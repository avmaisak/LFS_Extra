#!/bin/sh
#Red
RED='\e[0;31m'
#Green
GREEN='\e[0;32m'
#Yellow
YELLOW='\e[0;33m'
#Blue
BLUE='\e[0;34m'
#Reset color
CRESET='\e[0m'
#Сообщение
msg() {
	echo -e $1
}
msg_success() {
	echo -e "${GREEN}$1${CRESET}"
}
#Сообщение об ошибке
msg_err() {
	echo -e "${RED}$1${CRESET}"
}
#Предупреждение
msg_warn() {
	echo -e "${YELLOW}$1${CRESET}"
}
#подтвердить
confirm() {
	read -r -p "$1 (Y/n) " response
	case "$response" in
		[Nn][Oo]|[Nn]) echo "$2"; exit 2 ;;
		*) : ;;
	esac
}
# каталог существует
FolderExist() {
	if [ ! -d $1 ]; then
		msg_err "Каталог '$1' не существует"
		exit 1
	fi
}

# файл существует
FileExist() {
	if [ ! -f $1 ]; then
		msg_err "Файл '$1' не существует"
		exit 1
	fi
}
