# Установка IOS Webkit Debug для отладки IOS устройств на Linux

## Установка через bash скрипт

Клонируем текущий репозиторий ```git clone git@gitlab.machaon-dev.ru:shumskih/ios-webkit-debug.git```

Заходим в папку ```cd ios-webkit-debug```

Запускаем установщик ```./ios-webkit-debug.sh```

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