Пояснение: docker-compose файл запускает выбранный ВАМИ сервис с ВАШЕГО ПК локально (например, frontend_stable_compose.yaml запускает frontend локально), а остальные подгружает с Dockerhub, причём можно выбрать, из какой ветки:
- **stable** - main
- **dev** - develop

# Инструкция по запуску
Создайте папку (например, "faberge") и откройте её в терминале
В неё склонируйте данный репозиторий и тот, в котором хотите разрабатывать

## Первый запуск (сборка/пересборка):
docker compose -f .\infra_faberge\<сервис>.yaml up --build

## Дальнейший запуск:
docker compose -f .\infra_faberge\<сервис>.yaml up

## Остановка:
docker compose -f .\infra_faberge\<сервис>.yaml down
