### Буферный регистр данных
Установка микросхемы в режим буферного регистра данных производится подачей на
вывод RC0 напряжения низкого уровня, а на вывод RC1 высокого.

### Условное графическое обозначение в режиме буферного регистра
![Symbol](/034/img/034-reg.png)

### Структурная схема для режима буферного регистра
![Structure](/034/img/034-reg-arch.jpg)

### Назначение выводов в режиме буферного регистра данных
| Номер           | Название     | Конфигурация | Назначение
|-----------------|--------------|--------------|-----------------------------------------
| 1               | RC1          | Вход         | Вход выбора режима 1 (высокий)
| 2               | RC0          | Вход         | Вход выбора режима 0 (низкий)
| 21              | GND          | Питание      | Нулевой потенциал (земля)
| 26-33,3-8,35,36 | nD0-nD15     | Вход         | Вход регистра данных nD0-nD15
| 9-20,22-25      | nAD0-nAD15   | Выход        | Выход регистра данных nAD0-nAD15
| 34              | nDME         | Вход         | Вход разрешения выдачи данных nAD
| 37-39,41        | NC           | -            | Не используются
| 40              | C            | Вход         | Вход записи данных
| 42              | VCC          | Питание      | Потенциал +5В (источник питания)

### Функциональное описание
Входная информация с выводов nD0—D15 сигналом С высокого уровня записывается в 16-разрядный
буферный регистр. Сигнал низкого уровня nDME разрешает выдачу информации с буферного регистра
на выводы nAD0—nAD15, которые при высоком уровне этого сигнала находятся в отключенном состоянии.
Из интересных особенностей - при переходе сигнала nDME в высокий уровень на выходах nAD 
предварительно устанавливается высокий уровень и только потом, после некоторой задержки выходы
переходят в высокоимпедансное состояние. Этот эффект более сильно выражен на младшем байте
(AD0-AD7) ввиду большей задержки, вносимой элементами L17:A, L17:B, L17:C, L18:A, L18:B и L18:C.