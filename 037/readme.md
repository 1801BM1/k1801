## 1801ВП-037

### Фотографии кристалла высокого разрешения
[1801ВП-037, 103M](http://www.1801bm1.com/files/retro/1801/images/vp1-037.jpg)

### Условное графическое обозначение
![Symbol](/037/img/037.png)

### Назначение выводов
| Номер       | Название     | Конфигурация | Назначение
|-------------|--------------|--------------|-----------------------------------------
| 1           | nSYNC        | Вход         | Строб адреса МПИ
| 2-9         | nAD0-nAD7    | Вых-3/Вход   | Шина адреса/данных МПИ, разряды AD0-AD7, выходы данных при чтении регистра режима
| 10          | nAD8         | Вход         | Вход адреса nAD8 с шины МПИ
| 11          | nAD9         | Вых-3/Вход   | Шина адреса/данных МПИ, разряд AD9, выход данных при чтении регистра режима
| 12-16       | nAD10-nAD14  | Вход         | Шина адреса МПИ, разряды AD10-AD14
| 17          | nAD15        | Вых-3/Вход   | Шина адреса/данных МПИ, разряд AD15, выход данных при чтении регистра начального пуска
| 18-20,22-25 | A0-A6        | Выход        | Мультиплексированный адрес динамической памяти, адрес регенерации
| 21          | GND          | Питание      | Нулевой потенциал (земля)
| 26          | R            | Вход         | Начальный сброс контроллера, активный высокий уровень
| 27          | C            | Вход         | Высокий уровень активирует тестовый режим
| 28          | nVHSYNC      | Выход        | Видеосинхронизация - смесь кадровых  и строчных синхроимпульсов
| 29          | WTD          | Выход        | Строб записи данных в регистры выдачи данных на шину МПИ
| 30          | nWE          | Выход        | Низкий уровень при записи в динамическое ОЗУ
| 31          | WTI          | Выход        | Строб записи данных в сдвиговые регистры видеосигнала
| 32          | nRAS         | Выход        | Строб адреса страницы динамического ОЗУ
| 33          | CLC          | Вход         | Основная тактовая частота, 6МГц
| 34          | nRPLY        | Выход ОК     | Строб подтверждения транзакции МПИ
| 35          | nCAS1        | Выход        | Стробы адреса колонки микросхем динамической памяти старшего байта
| 36          | nCAS0        | Выход        | Стробы адреса колонки микросхем динамической памяти младшего байта
| 37          | nE           | Выход        | Разрешение чтения, низкий уровень при активных nSYNC, nDIN и адресе в диапазоне 000000<sub>8</sub>-177600<sub>8</sub>
| 38          | nBS          | Выход        | Декодер адреса контроллера клавиатуры, низкий уровень при обращении по аресам в диапазоне 177660<sub>8</sub>-177663<sub>8</sub>
| 39          | nWTBT        | Вход         | Признак записи байта МПИ
| 40          | nDOUT        | Вход         | Строб записи данных МПИ
| 41          | nDIN         | Вход         | Строб чтения данных МПИ
| 42          | VCC          | Питание      | Потенциал +5В (источник питания)

### Структурная схема 1801ВП1-037
![Struct](/037/img/struct_037.png)

### Описание
Микросхема 1801ВП1-037 была разработана как специально для построения на ее
основе простого и массового бытового компьютера. Наиболее известными такими
компьютерами является серия БК-0010/11/11М. Несмотря на массовость и
распространенность данных компьютеров, только относительно недавно появилась
более-менее подробная документация, описывающая работу 1801ВП1-037.

Исследуемая микросхема использует 264 ячейки БМК, содержит 406 связей и
выполняет набор функций системного контроллера бытового компьютера, в частности:
- регенерация динамического ОЗУ
- формирование сигналов управления динамическим ОЗУ типа К565РУ5/РУ6
- одновременное (с регенерацией) формирование потока данных для вывода
  графической информации на экран бытового телевизора
- генерация смеси кадровых и строчных синхросигналов для бытового телевизора
- формирование сигнала выборки для контроллера клавиатуры, при обращении
  к адресам 177660<sub>8</sub>-177663<sub>8</sub>
- формирование сигнала обращения к ПЗУ на чтение в диапазоне 
  000000<sub>8</sub>-177577<sub>8</sub> (формирует высокий уровень на выходе
  nE при обращении процессором на запись по любому адресу, или обращению
  на чтение в диапазон 177600<sub>8</sub>-177777<sub>8</sub>)

В структуре микросхемы 1801ВП1-037 можно выделить такие основные блоки:
- БРА, буферный регистр адреса, при переходе сигнала SYNC в низкий уровень этот
  регистр фиксирует адрес обращения на шине МПИ
- ДША, дешифратор адреса вырабатывает необходимые сигналы для управления
  выходами nE и nBS, а также определяет факт обращения к диапазону ОЗУ
  000000<sub>8</sub>-077777<sub>8</sub> (кстати, именно поэтому в схеме
  БК-0011/11М на nAD15 ВП1-037 постоянно подается высокий уровень)
  и к внутреннему регистру по адресу 177664<sub>8</sub>
- МПА, мультиплексор адреса динамического ОЗУ, представляет собой 14-разрядный
  мультиплексор 4-в-1 - переключает как адреса строк и столбцов ОЗУ,
  так и адреса обращения со стороны процессора, адреса регенерации
  и формирования изображения
- РН, регистр начального пуска микропроцессора (используется БК-0010 и
  не используется в БК-0011/11М - в них адрес начального пуска формируется
  другой микросхемой)
- РС, регистр смещения начального адреса буфера изображения
- СТА, счетчик текущего адреса
- СС, счетчик строк
- Схему синхронизации, вырабатывающую управляющие сигналы
- УМ, входные и выходные буферные усилители мощности

В-общем, несмотря на большое количество задействованных ячеек БМК и
относительно большую и сложную схему, ВП1-037 является достаточно
скучной микросхемой - фактически считает два счетчика, частично совмещенные по
младшим разрядам (строки считаются отдельно от видеоадреса, так как его старшая
асть является переменной и зависит от содержимого регистра смещения) и все
сигналы формируются в зависимости от значений данных счетчиков. Любопытно что
счетчики большей частью построены по схеме с ускоренным параллельным переносом,
за исключением самых старших разрядов.

Из малоизвестных особенностей - вход R (активный уровень высокий)
является асинхронным сбросом внутренних счетчиков. Вход С служит для
тестирования микросхемы в заводских условиях - при подаче высокого уровня
счетчик строк начинает тактироваться непосредственно от входа CLK, минуя
счетчики-предделители.

Достаточно интересным является вопрос момента фактической загрузки
содержимого регистра смещения адреса начала видеобуфера в счетчик видеоадреса.
Строб записи в старшие разряды счетчика видеоадреса достаточно длинный.
То есть процессор может успеть поменять значение регистра несколько раз,
но на выводимое изображение многократная замена не повлияет никак, поскольку
строб записи формируется в момент кадрового синхроимпульса и изображение
бланкировано. Окончательная фиксация значения в счетчике (ниспадающий фронт
строба "переписывания") происходит за 40x256x8 (десятичное) тактов CLK
до начала вывода изображения. Это объясняет странное значение 330<sub>8</sub>
которое надо записать в регистр чтобы начало изображения соответствовало адресу
140000<sub>8</sub>. При записи значения 330<sub>8</sub> из регистра 
смещения в счетчик видеоадреса, последний как раз "дотикает" до переполнения
и условного нулевого значения к моменту начала вывода видеоизображения.
