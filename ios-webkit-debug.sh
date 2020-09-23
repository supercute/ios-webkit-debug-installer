#!/bin/bash
PACKAGESDIR=packages
PACKAGESPATH=$(pwd)/${PACKAGESDIR}

sudo apt update
sudo apt-get install \
	build-essential \
	checkinstall \
	git \
	autoconf \
	automake \
	libtool-bin	\
	libssl-dev \
	libusb-1.0-0-dev \
	udev \
	python-dev

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

cd ${PACKAGESPATH}/libplist
./autogen.sh
make	
if [[ -f "${PACKAGESPATH}/libplist/Makefile" ]]
then
	sudo make install	
else
	echo -e "\e[41mОтсутствует Makefile в ${PACKAGESPATH}/libplist/\e[0m"
fi

echo -e "\e[47mСборка libusbmuxd...\e[0m"

cd ${PACKAGESPATH}/libusbmuxd
./autogen.sh
make	
if [[ -f "${PACKAGESPATH}/libusbmuxd/Makefile" ]]
then
	sudo make install	
else
	echo -e "\e[41mОтсутствует Makefile в ${PACKAGESPATH}/libusbmuxd/\e[0m"
fi

echo -e "\e[47mСборка libimobiledevice...\e[0m"

cd ${PACKAGESPATH}/libimobiledevice
./autogen.sh
make	
if [[ -f "${PACKAGESPATH}/libimobiledevice/Makefile" ]]
then
	sudo make install	
else
	echo -e "\e[41mОтсутствует Makefile в ${PACKAGESPATH}/libimobiledevice/\e[0m"
fi

echo -e "\e[47mСборка usbmuxd...\e[0m"

cd ${PACKAGESPATH}/usbmuxd
./autogen.sh
make	
if [[ -f "${PACKAGESPATH}/usbmuxd/Makefile" ]]
then
	sudo make install	
else
	echo -e "\e[41mОтсутствует Makefile в ${PACKAGESPATH}/usbmuxd/\e[0m"
fi

echo -e "\e[47mСборка ios-webkit-debug-proxy...\e[0m"

cd ${PACKAGESPATH}/ios-webkit-debug-proxy
./autogen.sh
make	
if [[ -f "${PACKAGESPATH}/ios-webkit-debug-proxy/Makefile" ]]
then
	sudo make install	
else
	echo -e "\e[41mОтсутствует Makefile в ${PACKAGESPATH}/ios-webkit-debug-proxy/\e[0m"
fi

sudo ldconfig

echo -e "\e[47mУстановка remotedebug-ios-webkit-adapter\e[0m"

sudo npm install remotedebug-ios-webkit-adapter -g