# Тестовое задание на должность Junior Flutter разработчка

## Конфигурация проекта

Flutter: 3.7.10 stable

Dart: 2.19.6

Устройства, на которых тестировалось приложение:

Эмуляторы: Pixel 4 API 30, Pixel 3 API 31, Pixel 3a API 32, Pixel 6 API 33

Реальные устройства: Realme GT NEO 2 Android 13

##  Требования

Необходимо сделать макет MVP абстрактного e-commerce приложения, которое включает в себя:

1. Смена темы на всех экранах приложения

2. Авторизация при помощи:
- СМС
- Email
- Биометрических данных

3. Два вида экрана (список или плитка) с возможностью смены

## Выполнено

### 0. Архитектура
В качестве архитектуры была выбрана Чистая Архитектура.

4 основных преимущества Чистой Архитектуры:

- Легко расширяема. При правильной реализации, с расширением проекта не должно возникнуть проблем.
- Прозрачность движения данных.
- Ответсвенности сущностей разделены.
- Известна и популярна, а это значит, что в случае расширения команды разработки приложения наиболее вероятно, что новые разработчики будут с ней знакомы.

### 1. Темы
Смена темы сделана с использованием библиотеки [riverpod](https://pub.dev/packages/riverpod).


### 2. Авторизация
#### Для первых двух пунктов авторизации использовал Firebase (авторизация через СМС и авторизация без пароля по динамической ссылке).


![Тестовые номера в консоли Firebase](https://user-images.githubusercontent.com/72256017/232117717-2783e784-2763-4700-8226-b8bb04739aef.png)



Авторизация по номеру телефона:


https://user-images.githubusercontent.com/72256017/232123377-d0908cc6-ba75-46d7-8141-ff5df9b93a6a.mp4 




Авторизация через email (динамические ссылки):


https://user-images.githubusercontent.com/72256017/232123495-de23ca5b-df7a-420e-8504-743d1d8605a4.mp4




#### Для биометрической аутентификации использовал [local_auth](https://pub.dev/packages/local_auth).


Запись экрана с реального устройства:


https://user-images.githubusercontent.com/72256017/232118493-289d8966-46b6-4ab7-8dea-970249b62532.mp4




Запись с экрана эмулятора:


https://user-images.githubusercontent.com/72256017/232121938-075a26e7-a700-43a3-b4d8-c779afafc7e8.mp4


Запись экрана с реального устройства при биометрической аутентификации на моменте, когда появляется диалог с уведомлением о том, 
что необходимо авторизоваться, чернеет, из-за Чувствительного Контента. 

Демонстрация этой функции проводилась с эмулятора Pixel 6 API 33. 

Единственное отличие от работы на реальном устройстве - лаунчер аутентификации выполнен в виде AlertDialog, например, как в приложении Сбер. 


### 3. Смена вида экранов
Смену вида сделал так же через Riverpod


### 4. Навигация
Настроил навигацию через [auto_route](https://pub.dev/packages/auto_route).


### 5. Стейт-менеджмент
В качестве стейт-менеджера был выбран [flutter_bloc](https://pub.dev/packages/flutter_bloc).

В данном случае, так как в приложении происходит немного событий и все они вызываются по запросу пользователя лучше использовать Cubit, чем Bloc из-за его простоты реализации.


### 6. Отображение и обработка ошибок
В случае, если при авторизации произошла ошибка будет вызван снэкбар и через 2 секунды, снова отобразится страница авторизации.


https://user-images.githubusercontent.com/72256017/232122758-99d18590-3d58-4904-95bc-6edd3da9d2a8.mp4



### 7. Внедрение зависимостей
Для внедрения зависимостей реализован класс DiContainer и его интерфейс IDiContainer, для возможной замены зависимостей в будущем.





