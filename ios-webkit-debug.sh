#!/bin/bash
PACKAGESDIR=packages
PACKAGESPATH=$(pwd)/${PACKAGESDIR}

sudo apt update
sudo apt-get install \
	build-essential \
	checkinstall \
	nodejs \
	npm \
	git \
	autoconf \
	automake \
	libtool-bin	\
	libssl-dev \
	libusb-1.0-0-dev \
	udev \
	python-dev

checkInstallPackage()
{
	if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ]
	then
		sudo apt install $1
		return 1
	else 
		echo -e "\e[47m$1 уже установлен\e[0m"
		return 0
	fi
}

checkVersion()
{
	if [ command -v $1 >/dev/null 2>&1 || command -V $1 >/dev/null 2>&1 ]
	then
	    echo -e "\e[42m$1 найден\e[0m"
	    return 0
	else
	    echo -e "\e[41m$1 не найден\e[0m"
	    return 1
	fi
}

checkMakeFile()
{
	if [[ -f "${PACKAGESPATH}/$1/Makefile" ]]
	then
		return 0	
	else
		echo -e "\e[41mОтсутствует Makefile в ${PACKAGESPATH}/$1/\e[0m"
		exit 1
	fi
}


checkInstallPackage python-dev

# Проверка существования папки с
if [[ -d "${PACKAGESPATH}" ]]
then
	echo -e "\e[41mПапка уже существует\e[0m"
	
else
	mkdir ${PACKAGESDIR}
	echo -e "\e[42mСоздана папка ${PACKAGESDIR}\e[0m"
fi

# Переход в папку
cd ${PACKAGESDIR}

echo -e "\e[47mСкачивание пакетов...\e[0m"
# Скачивание пакетов
git clone https://github.com/libimobiledevice/libplist.git
git clone https://github.com/libimobiledevice/libusbmuxd.git
git clone https://github.com/libimobiledevice/libimobiledevice.git
git clone https://github.com/libimobiledevice/usbmuxd.git
git clone https://github.com/google/ios-webkit-debug-proxy.git

export LD_LIBRARY_PATH=/usr/local/lib

echo -e "\e[47mСборка libplist...\e[0m"

cd "${PACKAGESPATH}/libplist"
./autogen.sh
make	
if checkMakeFile libplist
then
	sudo make install	
fi
echo -e "\e[42mlibplist установлен\e[0m"

echo -e "\e[47mСборка libusbmuxd...\e[0m"

cd "${PACKAGESPATH}/libusbmuxd"
./autogen.sh
make	
if checkMakeFile libusbmuxd
then
	sudo make install	
fi
echo -e "\e[42mlibusbmuxd установлен\e[0m"

echo -e "\e[47mСборка libimobiledevice...\e[0m"

cd "${PACKAGESPATH}/libimobiledevice"
./autogen.sh
make	
if checkMakeFile libimobiledevice
then
	sudo make install	
fi
echo -e "\e[42mlibimobiledevice установлен\e[0m"

if checkVersion usbmuxd;
then
	echo -e "\e[47musbmuxd Уже присутствует\e[0m"
else
	cd "${PACKAGESPATH}/usbmuxd"
	./autogen.sh
	make	
	if checkMakeFile usbmuxd
	then
		sudo make install	
	fi
	echo -e "\e[42mlusbmuxd установлен\e[0m"
fi

echo -e "\e[47mСборка ios-webkit-debug-proxy...\e[0m"

cd "${PACKAGESPATH}/ios-webkit-debug-proxy"
./autogen.sh
make	
if checkMakeFile ios-webkit-debug-proxy
then
	sudo make install	
fi
echo -e "\e[42ios-webkit-debug-proxy установлен\e[0m"

sudo ldconfig

echo -e "\e[47mУстановка remotedebug-ios-webkit-adapter\e[0m"

if checkVersion npm;
then
	npm install remotedebug-ios-webkit-adapter -g
	echo -e "\e[42remotedebug-ios-webkit-adapter установлен\e[0m"
else
	sudo npm install remotedebug-ios-webkit-adapter -g
	echo -e "\e[42remotedebug-ios-webkit-adapter установлен\e[0m"
fi