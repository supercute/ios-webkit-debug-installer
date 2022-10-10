# Установка IOS Webkit Debug для отладки IOS устройств на Linux старых версий

## Установка через bash скрипт

Клонируем  репозиторий ```git clone https://github.com/supercute/ios-webkit-debug-installer.git```

Заходим в папку ```cd ios-webkit-debug```

Запускаем установщик ```./ios-webkit-debug.sh```

## Самостоятельная сборка из исходников 

Собираем самостоятельно из нескольких репозиториев, все репозитории в аккаунте https://github.com/libimobiledevice

Порядок сборки: 

**1. libplist**

**2. libusbmuxd**

**3. libimobiledevice**

**4. usbmuxd (если не работает в системе)**

**5. ios-webkit-debug-proxy**

Для сборки дополнительно понадобится пакет **python-dev**

Если возникает ошибка ```ios_webkit_debug_proxy: error while loading shared libraries: libimobiledevice.so.6: cannot open shared object file: No such file or directory```

Запустите ```sudo ldconfig```, либо ```export LD_LIBRARY_PATH=/usr/local/lib```
## Настройки устройства (iphone, ipad and other)

Включаем **Настройки -> Safari -> Дополнения -> Веб инспектор**

При подключении устройства к компьютеру **Доверять -> ДА**

## Настройки подключения

Запускаем службу usbmuxd ```sudo usbmuxd -v ```

Подключаем устройство

Проверяем подключаение ```idevice_id -l``` должен отобразится id устройства

Запускаем адаптер (запускает дебаггер автоматически) ```remotedebug_ios_webkit_adapter --port=9000```

## Настройки Chrome

Переходим на ```chrome://inspect```

Добавляем localhost:9000 в **Discover network targets -> Configure**

В **Remote Target** появятся страницы с Safari по клику на которые открываем окно с экраном телефона и инспектором chrome
