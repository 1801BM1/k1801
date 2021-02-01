### Устройство выдачи вектора прерывания и компаратор адреса
Установка микросхемы в режим устройства выдачи вектора прерывания и компаратора адреса
производится подачей на выводы RC0 и RC1 напряжения высокого уровня.

### Условное графическое обозначение в режиме компаратора адреса
![Symbol](/034/img/034-aciv.png)

### Структурная схема для режима компаратора адреса
![Structure](/034/img/034-aciv-arch.jpg)

### Назначение выводов в режиме выдачи вектора и компаратора адреса
| Номер       | Название     | Конфигурация | Назначение
|-------------|--------------|--------------|-----------------------------------------
| 1           | RC1          | Вход         | Вход выбора режима 1 (высокий)
| 2           | RC0          | Вход         | Вход выбора режима 0 (высокий)
| 3-8         | S11-S16      | Вход         | Входы программирования вектора прерывания 2-7 
| 9           | nSB          | Выход        | Выход "Устройство выбрано"
| 10          | nVIRQ        | Выход        | Выход запроса на прерывание (не открытый коллектор)
| 11          | nAD2         | Выход        | Выход канала nAD2
| 12-16,22    | nAD3-nAD7    | Вход/Выход   | Входы-выходы канала nAD3-nAD7
| 17-20,22    | nAD8-nAD12   | Вход         | Входы канала nAD8-nAD12
| 21          | GND          | Питание      | Нулевой потенциал (земля)
| 23          | nBS          | Вход         | Вход "Внешнее устройство"
| 24-25,40    | NC           | -            | Не используются
| 26-33,35,36 | S1-S10       | Вход         | Входы программирования адреса AD3-AD12 
| 34          | nIAKI        | Вход         | Вход разрешения прерывания
| 37          | nVIRI        | Вход         | Вход запроса на прерывание
| 38          | nDIN         | Вход         | Вход "Чтение данных"
| 39          | nRPLY        | Выход        | Выход "Ответ", открытый коллектор
| 41          | nSYNC        | Вход         | Вход "Обмен"
| 42          | VCC          | Питание      | Потенциал +5В (источник питания)

### Функциональное описание
Старшие шесть разрядов требуемого адреса вектора прерывания устанавливаются на выводах
S11—S16, этот вектор будет выдаваться (прямое значение, без инверсии) на выходы канала
nAD2-nAD7 (nAD8-nAD12 остаются при выдаче вектора в высокоимпедансном состоянии).

Адрес, необходимый для сравнения, устанавливается на выводах S1-S10. Состояния S1-S10
и nAD3-nAD12 сравниваются при наличии сигнала nBS низкого уровня. При совпадении
вырабатывается сигнал nSB низкого уровня, который запоминается в триггере на все время
присутствия сигнала SYNC.

Выход nRPLY работает как открытый коллектор, активный уровень низкий, но при переходе
в неактивное состояние кратковременно генерирует высокий уровень, после чего переводится
в высокоимпедансное состояние. Выход nRPLY активируется только в циклах чтения вектора
при наличии активного запроса на прерывание.