1. git clone https://github.com/Eliti1/tzgenotek  
2. cd tzgenotek  
3. ./docker.sh #Запускаем установку докера. Не засунул в main-скрипт, потому что после установки Докера нужно перезапустить консоль, а в этом случае скрипт падает
4. ./yc.sh 
5. ./registry.yml

Тут ключ я сразу засунул в диру к проекту (понимаю, что секрет надо прятать с хранилище секретов). Если будете сами формировать ключ то вот инструкция:

Перед прогоном скрипта необходимо получить Автоматизированный ключ в IAM для Инициализации YC:

Yandex Cloud Console
Создаем сервисный аккаунт и Создаем авторизированный ключ
Скачиваем authorized_key.json
Закидываем authorized_key.json на сервак (через scp или другим способом)
В скрипте registry.sh в "AUTHORIZED_KEY" прописываем путь, где находится ваш authorized_key.json
