1. git clone https://github.com/Eliti1/tzgenotek  
2. cd tzgenotek  
3. ./docker.sh 
4. ./yc.sh
5. ./registry.sh
3 и 4 этапы отдельно, потому что там после установки перезапускается shell, если всё в 1 скрипт делать, то скрипт падает.

Тут Автоматизированный ключ я сразу засунул в диру к проекту. Если будете сами формировать ключ то вот инструкция:
_______________________________________________________________________________________________________________________________________________________________________
Перед прогоном скрипта необходимо получить Автоматизированный ключ в IAM для Инициализации YC:

Yandex Cloud Console  
Создаем сервисный аккаунт и Создаем авторизированный ключ  
Скачиваем authorized_key.json  
Закидываем authorized_key.json на сервак (через scp или другим способом)  
В скрипте registry.sh в "AUTHORIZED_KEY" прописываем путь, где находится ваш authorized_key.json  
_________________________________________________________________________________________________________________________________________________________________________
Чтобы проверить ошибку: ./check_error.sh
