# Установка IOS Webkit Debug для отладки IOS устройств на Linux

## Установка через bash скрипт

Клонируем текущий репозиторий ```git clone git@gitlab.machaon-dev.ru:shumskih/ios-webkit-debug.git```

Заходим в папку ```cd ios-webkit-debug```

Запускаем установщик ```./ios-webkit-debug.sh```

## Настройки устройства (iphone, ipad and other)

Включаем **Настройки -> Safari -> Дополнения -> Веб инспектор**

При подключении устройства к компьютеру **Доверять -> ДА**

## Настройки подключения

Запускаем службу usbmuxd ```sudo usbmuxd -v -f ```

Подключаем устройство

Проверяем подключаение ```idevice_id -l``` должен отобразится id устройства

Для дополнительной проверки запускаем дебаггер ```ios_webkit_debug_proxy```

По адресу ```localhost:9221``` должен появится список устройств, а по адресу ```localhost:9222``` открытые страницы в Safari 

Должно показать примерно ```Connected :9222 to iPhone (Даниил) (d428aa2e0c6745a454bdbdf46da68af6f086a1f3)```

Завершаем ```CTRL+C```

Запускаем адаптер (запускает дебаггер автоматически) ```remotedebug_ios_webkit_adapter --port=9000```

## Настройки Chrome

Переходим на ```chrome://inpect```

Добавляем localhost:9000 в **Discover network targets -> Configure**

В **Remote Target** появятся страницы с Safari по клику на которые открываем окно с экраном телефона и инспектором chrome