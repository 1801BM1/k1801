## 1801ВП1-033

### Фотографии кристалла высокого разрешения
- [1801ВП1-033, 71M](http://www.1801bm1.com/files/retro/1801/images/vp1-033.jpg)

### Описание
Микросхема 1801ВП1-033 представляет собой многофункциональное устройство и,
в зависимости от конфигурации, может работать в следующих режимах:
- [интерфейса накопителя на гибких магнитных дисках](/033/doc/fdc.md)
- [контроллера интерфейса параллельного ввода-вывода](/033/doc/pio.md)
- [контроллера байтового параллельного интерфейса](/033/doc/bpic.md)

Микросхема 1801ВП1-033 может использоваться совместно с микросхемой 1801ВП1-034
для организации интерфейсного устройства 16-разрядного программируемого параллельного
ввода-вывода и интерфейсного устройства байтового параллельного ввода-вывода, а также
как самостоятельное интерфейсное устройство накопителя на гибких магнитных дисках.

### Сводная таблица конфигураций
| RC3 | RC2 | RC1 | RC0 | Конфигурация
|-----|-----|-----|-----|--------------------------------------------------------
|  1  |  1  |  1  |  1  | режим контроллера накопителя на гибких магнитных дисках
|  0  |  1  |  1  |  1  | режим параллельного интерфейса xxxxx0/xxx
|  0  |  1  |  1  |  0  | режим параллельного интерфейса 167750/320
|  1  |  1  |  1  |  0  | режим параллельного интерфейса 167740/330
|  0  |  1  |  0  |  1  | режим параллельного интерфейса 167770/300
|  1  |  1  |  0  |  1  | режим параллельного интерфейса 167760/310
|  x  |  0  |  0  |  0  | режим байтового параллельного интерфейса 177510/200
|  x  |  0  |  0  |  1  | режим байтового параллельного интерфейса 177560/60
|  x  |  0  |  1  |  0  | режим байтового параллельного интерфейса 177550/70
|  x  |  0  |  1  |  1  | режим байтового параллельного интерфейса 177270/170
|  x  |  1  |  0  |  0  | режим байтового параллельного интерфейса xxxxxx/xx0/4

| RC5 | RC4 | контроллер накопителя на гибких магнитных дисках
|-----|-----|--------------------------------------------------------
|  0  |  0  | 177170/264
|  0  |  1  | 177174/270
|  1  |  0  | 177200/244
|  1  |  1  | xxxxx0/xxx