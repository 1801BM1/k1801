//
// Модуль:          процедуры обработки командной строки для различных утилит
//
#define __CMDLINE_INTERNAL__            // определение внутренних функций
#include "config.h"                     //
#include <windows.h>                    // включаем нужные определения
#include <stdio.h>                      //
#include "errors.h"                     // функции вывода сообщений об ошибках
#include "cmdline.h"                    // функции обработки командной строки

#ifdef SWTYP_SERNUM
BOOL CL_IsUpper(BYTE c)
{

// 'A' - 0x41
// 'Z' - 0x5a

// 'А' - 0xc0
// 'Я' - 0xdf

    if (((c >= 0x41) && (c <= 0x5a)) || ((c >= 0xc0) && (c <= 0xdf)))
        return TRUE;
    else
        return FALSE;
}

#endif //SWTYP_SERNUM

#ifdef KEY_INFILE_BIT
//
// Функция копирования имени файла в указанный буфер
// При этом производятся возможные проверки и если
// не указано расширение имени файла, то добавляется
// расширение по умолчанию.
// В случае ошибки выводит сообщение и возвращает TRUE
//
BOOL CL_SetFileName(char* Buf, char* Name)
{
    int Len = strlen(Name);

    if (Len > MAX_FILE_NAME)
    {
        ERR_ShowError(ERR_FATAL"Too long filename\n\r");
        return TRUE;
    }
    strcpy(Buf, Name);

#ifdef DEF_FILE_EXT
    //
    // Проверим, может быть расширение уже указано
    //
    if (strrchr(Buf, '.'))
    {
        return FALSE;
    }

    //
    // Расширение не указано, добавляем по умолчанию
    // предварительно проверив наличие места в буфере
    //
    if (Len >= (MAX_FILE_NAME - sizeof(DEF_FILE_EXT)))
    {
        ERR_ShowError(ERR_FATAL"Too long filename\n\r");
        return TRUE;
    }
    strcpy(Buf + Len, DEF_FILE_EXT);
#endif
    return FALSE;
}

//
// Функция обработки имени файла, в зависимости от параметров
// и предыстории (имя входного файла/имя выходного файла) копирует имя
// в один из статических буферов, если требуется, добавляет расширение
// В случае ошибки выводит сообщение и возвращает TRUE
//
BOOL CL_EnumerateFile(char* Key)
{
    if(CL_KeyPresent(KEY_INFILE_BIT))
    {
        //
        // Одно имя файла (входного) уже обнаружено
        // Смотрим, допускается ли второе имя
        //
#ifdef KEY_OUTFILE_BIT
        if(CL_KeyPresent(KEY_OUTFILE_BIT))
        {
            //
            // Все имена файлов уже указаны - ошибка
            //
            ERR_ShowError(ERR_FATAL"Too many filenames specified\n\r");
            return TRUE;
        }
        else
        {
            CLD_KeyMask |= KEY_OUTFILE_BIT;
            return CL_SetFileName(OutFileName, Key);
        }
#else
        //
        // Второе имя файла недопустимо - выводим ошибку
        //
            ERR_ShowError(ERR_FATAL"Too many filenames specified\n\r");
            return TRUE;
#endif
    }
    else
    {
        CLD_KeyMask |= KEY_INFILE_BIT;
        return CL_SetFileName(InFileName, Key);
    }
}
#endif  // KEY_INFILE_BIT

//
// Функция преобразования строчки десятичных цифр в беззнаковое целое
// В случае успеха возвращает полученное значение, в случае ошибки
// возвращает 0 и устанавливает признак ошибки CLD_ConvError
//
DWORD CL_GetDecValue(char* Line)
{
    DWORD Value = 0;
    int i;

    //
    // Изначально предполагаем ошибку
    //
    CLD_ConvError = TRUE;
    //
    // Пропускаем незначащие нули
    //
    while(*Line == '0') Line++;
    //
    // Принимаем не более 9 значащих цифр, таким образом мы
    // избегаем неопределенности при возникновении переполнения
    //
    for(i = 0; i < (sizeof(DWORD) * 2 + 1); i++)
    {
        //
        // Проверяем конец строки
        //
        if (*Line == 0) break;
        if (!isdigit(*Line)) break;
        Value = Value * 10 + *Line - '0';
        Line++;
    }
    //
    // Цикл закончился, проверяем, достигнут ли конец строки
    //
    if (*Line == 0)
    {
        CLD_ConvError = FALSE;
        return Value;
    }
    //
    // Слишком длинная строчка
    //
    return 0;
}

//
// Функция преобразования строчки шестнадцатиричных цифр в беззнаковое целое
// В случае успеха возвращает полученное значение, в случае ошибки
// возвращает 0 и устанавливает признак ошибки CLD_ConvError
//
DWORD CL_GetHexValue(char* Line)
{
    DWORD Value = 0;
    DWORD Add;

    //
    // Изначально предполагаем ошибку
    //
    CLD_ConvError = TRUE;
    //
    // Принимаем не более 8 значащих цифр, таким образом мы
    // избегаем неопределенности при возникновении переполнения
    //
    while (*Line)
    {
        //
        // Проверяем символ на допустимость
        //
        if (!isxdigit(*Line)) break;
        if (Value & (0xF0L << ((sizeof(DWORD) - 1)*8))) break;

        if (isdigit(*Line))
        {
            Add = *Line - '0';
        }
        else
        {
            Add = toupper(*Line) - 'A' + 10;
        }
        Value = (Value << 4) + Add;
        Line++;
    }
    //
    // Цикл закончился, проверяем, достигнут ли конец строки
    //
    if (*Line == 0)
    {
        CLD_ConvError = FALSE;
        return Value;
    }
    //
    // Слишком длинная строчка
    //
    return 0;
}

//
// Функция обработки ключа, получает указатель на конкретный ключ,
// ищет его в таблице ключей, получает и проверяет значения стандартных типов.
// В случае ошибки выводит сообщение и возвращает TRUE
//
BOOL CL_ProcessKey(char* Key)
{
    char Chr;
    char *VPtr;
    PSWITCH_DESC Desc;

    Chr = *Key;
    Chr = toupper(Chr);

    for(Desc = &Switch[0]; Desc < &Switch[KEY_TAB_SIZE]; Desc++)
    {
        if (Desc->Letter == Chr)
        {
            //
            // Обнаружена запись в массиве описателей ключей
            //
            if (CL_KeyPresent(Desc->KeyBit))
            {
                //
                // Ключ указан два и более раз - ошибка
                //
                ERR_ShowError(ERR_FATAL"Multiple switch specification\n\r");
                return TRUE;
            }
            //
            // Ключ обнаружен, устанавливаем признаки наличия ключа
            //
            CLD_KeyMask |= Desc->KeyBit;
            Desc->Flags |= SWFLG_PRESENT;

            VPtr = Key + 1;     // указатель на возможное значение ключа

            switch(Desc->Type)
            {
//
// ключ не может иметь никаких значений
//
#ifdef SWTYP_NOVALUE
                case SWTYP_NOVALUE:
                {
                    if (*VPtr != 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has unexpected value\n\r", *Key);
                        return TRUE;
                    }
                    break;
                }
#endif SWTYP_NOVALUE

//
// ключ может иметь дополнительный '+'
//
#ifdef SWTYP_PLUS
                case SWTYP_PLUS:
                {
                    Desc->Value = 0;
                    if (*VPtr == 0)
                    {
                        break;
                    }
                    if (   (*VPtr != '+')
                        || (*(VPtr+1) != 0) )
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                    Desc->Value = '+';
                    Desc->Flags |= SWFLG_HASVALUE;
                    break;
                }
#endif SWTYP_PLUS

//
// ключ может иметь беззнаковое десятичное значение
//
#ifdef SWTYP_DECVALUE
                case SWTYP_DECVALUE:
                {
                    //
                    // Проверим, у ключа должно ли обязательно быть значение
                    //
                    if(Desc->Format & SWFMT_MUSTVALUE)
                    {
                        if (*VPtr == 0)
                        {
                            ERR_ShowError(ERR_FATAL"Switch -%c must have value\n\r", *Key);
                            return TRUE;
                        }
                    }
                    if(*VPtr != 0)
                    {
                        //
                        // Получаем требуемое значение
                        //
                        Desc->Value = CL_GetDecValue(VPtr);
                        if (CLD_ConvError)
                        {
                            ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                            return TRUE;
                        }
                        Desc->Flags |= SWFLG_HASVALUE;
                    }
                    break;
                }
#endif SWTYP_DECVALUE

//
// ключ может иметь беззнаковое шестнадцатиричное значение
//
#ifdef SWTYP_HEXVALUE
                case SWTYP_HEXVALUE:
                {
                    //
                    // Проверим, у ключа должно ли обязательно быть значение
                    //
                    if(Desc->Format & SWFMT_MUSTVALUE)
                    {
                        if (*VPtr == 0)
                        {
                            ERR_ShowError(ERR_FATAL"Switch -%c must have value\n\r", *Key);
                            return TRUE;
                        }
                    }
                    if(*VPtr != 0)
                    {
                        //
                        // Получаем требуемое значение
                        //
                        Desc->Value = CL_GetHexValue(VPtr);
                        if (CLD_ConvError)
                        {
                            ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                            return TRUE;
                        }
                        Desc->Flags |= SWFLG_HASVALUE;
                    }
                    break;
                }
#endif SWTYP_HEXVALUE

//
// ключ является номером или адресом LPT-порта
//
#ifdef SWTYP_LPTPORT
                case SWTYP_LPTPORT:
                {
                    //
                    // Проверим, у ключа должно обязательно быть значение
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have LPT port address or number\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // Получаем требуемое значение
                    //
                    Desc->Value = CL_GetHexValue(VPtr);
                    if (CLD_ConvError)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                        Desc->Flags |= SWFLG_HASVALUE;
                    break;
                }
#endif SWTYP_LPTPORT

//
// ключ является номером COM-порта
//
#ifdef SWTYP_COMPORT
                case SWTYP_COMPORT:
                {
                    //
                    // Проверим, у ключа должно обязательно быть значение
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have communication port number\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // Получаем требуемое значение
                    //
                    Desc->Value = CL_GetDecValue(VPtr);
                    if (CLD_ConvError)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                        Desc->Flags |= SWFLG_HASVALUE;
                    break;
                }
#endif SWTYP_COMPORT

//
// ключ является скоростью обмена по COM-порту
//
#ifdef SWTYP_BAUDRATE
                case SWTYP_BAUDRATE:
                {
                    //
                    // Проверим, у ключа должно обязательно быть значение
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have baudrate value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // Получаем требуемое значение
                    //
                    Desc->Value = CL_GetDecValue(VPtr);
                    if (CLD_ConvError)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                        Desc->Flags |= SWFLG_HASVALUE;
                    break;
                }
#endif SWTYP_BAUDRATE
//
// ключ является датой
//
#ifdef SWTYP_DATE
                case SWTYP_DATE:
                {
                    //
                    // Проверим, у ключа должно обязательно быть значение
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have valid date value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // Получаем требуемое значение
                    //
                    Desc->Value = CL_GetDecValue(VPtr);
                    if (CLD_ConvError)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                        Desc->Flags |= SWFLG_HASVALUE;
                    break;
                }
#endif SWTYP_DATE
//
// ключ серийным номером
//
#ifdef SWTYP_SERNUM
                case SWTYP_SERNUM:
                {
                    //
                    // Проверим, у ключа должно обязательно быть значение
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have serial number value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // две буквы и восемь цифр
                    //
                    if(10!=strlen(VPtr))
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have 2 letters and 8 digits \n\r", *Key);
                        return TRUE;
                    }
                    //
                    // проверим цифры
                    //
                    Desc->Value = CL_GetDecValue(VPtr+2);
                    if (CLD_ConvError)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // проверим буквы на верхний регистр
                    //
                    if((FALSE==CL_IsUpper(*VPtr))||(FALSE==CL_IsUpper(*(VPtr+1))))
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // запомним указатель на строку с номером
                    //
                    Desc->Value = (DWORD)VPtr;
                    Desc->Flags |= SWFLG_HASVALUE;
                    break;
                }
#endif SWTYP_SERNUM

//
// При добавлении новых типов ключей следует добавить новые метки
//
                default:
                    {
                        ERR_ShowError(ERR_DEBUG"Unknown switch type encountered\n\r");
                        return TRUE;
                    }
            }
            return FALSE;
        }
    }
    ERR_ShowError(ERR_FATAL"Unknown switch specified: -%s\n\r", Key);
    return TRUE;
}
//
// Функция обработки очередного ключа, производит синтаксические проверки
// В случае ошибки выводит сообщение и возвращает TRUE
//
BOOL CL_EnumerateKey(char* Key)
{
    char C;

    C = *Key;
    if (!C)
    {
        ERR_ShowError(ERR_FATAL"Command line syntax error\n\r");
        return TRUE;
    }

    if ( (C != '-') && (C != '/'))
    {
    #ifdef  KEY_INFILE_BIT
        //
        // Возможно обнаружено имя файла, тогда попытаемся обработать
        //
        return CL_EnumerateFile(Key);
    #else
        //
        // Если имя файла в командной строке недопустимо, то обнаружена ошибка
        //
        ERR_ShowError(ERR_FATAL"Command line syntax error\n\r");
        return TRUE;
    #endif
    }

    Key++;
    C = *Key;

    if (!C)
    {
        ERR_ShowError(ERR_FATAL"Command line syntax error\n\r");
        return TRUE;
    }

    return CL_ProcessKey(Key);
}

//
// Функция проверки полученных значений ключей
//
//
BOOL CL_CheckValues(void)
{
    PSWITCH_DESC Desc;

    for(Desc = &Switch[0]; Desc < &Switch[KEY_TAB_SIZE]; Desc++)
    {
        if (!Desc->Flags & SWFLG_PRESENT) continue;
        //
        // Если ключ не имеет значения, то не проверяем его
        //
        if (!Desc->Flags & SWFLG_HASVALUE) continue;

        switch(Desc->Type)
        {
//
// ключ не может иметь никаких значений, ничего не проверяем
//
#ifdef SWTYP_NOVALUE
                case SWTYP_NOVALUE:
                {
                    break;
                }
#endif SWTYP_NOVALUE

#ifdef SWTYP_PLUS
                case SWTYP_PLUS:
                {
                    break;
                }
#endif SWTYP_PLUS

//
// ключ может иметь беззнаковое десятичное значение
//
#ifdef SWTYP_DECVALUE
                case SWTYP_DECVALUE:
                {
                    if(Desc->Format & SWFMT_LOWLIMIT)
                    {
                        if(Desc->Value < Desc->LowLimit)
                        {
                            ERR_ShowError(ERR_FATAL"Switch -%c has value less than lower limit\n\r",
                                          Desc->Letter);
                            return TRUE;
                        }
                    }
                    if(Desc->Format & SWFMT_HIGHLIMIT)
                    {
                        if(Desc->Value > Desc->HighLimit)
                        {
                            ERR_ShowError(ERR_FATAL"Switch -%c has value more than upper limit\n\r",
                                          Desc->Letter);
                            return TRUE;
                        }
                    }
                    //
                    // Вызываем опциональную процедуру проверки
                    //
                    if (Desc->ValueProc != NULL)
                        if(Desc->ValueProc(Desc))
                            return TRUE;
                    break;
                }
#endif SWTYP_DECVALUE

//
// ключ может иметь беззнаковое шестнадцатиричное значение
//
#ifdef SWTYP_HEXVALUE
                case SWTYP_HEXVALUE:
                {
                    if(Desc->Format & SWFMT_LOWLIMIT)
                    {
                        if(Desc->Value < Desc->LowLimit)
                        {
                            ERR_ShowError(ERR_FATAL"Switch -%c has value less than lower limit\n\r",
                                          Desc->Letter);
                            return TRUE;
                        }
                    }
                    if(Desc->Format & SWFMT_HIGHLIMIT)
                    {
                        if(Desc->Value > Desc->HighLimit)
                        {
                            ERR_ShowError(ERR_FATAL"Switch -%c has value more than upper limit\n\r",
                                          Desc->Letter);
                            return TRUE;
                        }
                    }
                    //
                    // Вызываем опциональную процедуру проверки
                    //
                    if (Desc->ValueProc != NULL)
                        if(Desc->ValueProc(Desc))
                            return TRUE;
                    break;
                }
#endif SWTYP_HEXVALUE

//
// ключ является номером или адресом LPT-порта
//
#ifdef SWTYP_LPTPORT
                case SWTYP_LPTPORT:
                {
                    switch(Desc->Value)
                    {
                        case 1:
                            Desc->Value = 0x378;
                            break;
                        case 2:
                            Desc->Value = 0x278;
                            break;
                        case 3:
                            Desc->Value = 0x3BC;
                            break;
                        case 0x378:
                        case 0x278:
                        case 0x3BC:
                            break;
                        default:
                            ERR_ShowError(ERR_FATAL"Invalid LPT port address or number specified\n\r");
                            return TRUE;
                    }
                    break;
                }
#endif SWTYP_LPTPORT

//
// ключ является номером COM-порта
//
#ifdef SWTYP_COMPORT
                case SWTYP_COMPORT:
                {
                    if( (Desc->Value < Desc->LowLimit)
                     || (Desc->Value > Desc->HighLimit) )
                    {
                        ERR_ShowError(ERR_FATAL"Invalid communication port number specified: %u\n\r",
                                      Desc->Value);
                        return TRUE;
                    }
                    break;
                }
#endif SWTYP_COMPORT

#ifdef SWTYP_BAUDRATE
                case SWTYP_BAUDRATE:
                {
                    switch(Desc->Value)
                    {
                        case 110:       if (Desc->LowLimit & SWBAUD_110) break;
                        case 150:       if (Desc->LowLimit & SWBAUD_150) break;
                        case 300:       if (Desc->LowLimit & SWBAUD_300) break;
                        case 600:       if (Desc->LowLimit & SWBAUD_600) break;
                        case 1200:      if (Desc->LowLimit & SWBAUD_1200) break;
                        case 2400:      if (Desc->LowLimit & SWBAUD_2400) break;
                        case 3600:      if (Desc->LowLimit & SWBAUD_3600) break;
                        case 4800:      if (Desc->LowLimit & SWBAUD_4800) break;
                        case 7200:      if (Desc->LowLimit & SWBAUD_7200) break;
                        case 9600:      if (Desc->LowLimit & SWBAUD_9600) break;
                        case 12800:     if (Desc->LowLimit & SWBAUD_12800) break;
                        case 14400:     if (Desc->LowLimit & SWBAUD_14400) break;
                        case 19200:     if (Desc->LowLimit & SWBAUD_19200) break;
                        case 28800:     if (Desc->LowLimit & SWBAUD_28800) break;
                        case 38400:     if (Desc->LowLimit & SWBAUD_38400) break;
                        case 57600:     if (Desc->LowLimit & SWBAUD_57600) break;
                        case 115200:    if (Desc->LowLimit & SWBAUD_115200) break;
                        case 230400:    if (Desc->LowLimit & SWBAUD_230400) break;
                        case 460800:    if (Desc->LowLimit & SWBAUD_460800) break;
                        case 921600:    if (Desc->LowLimit & SWBAUD_921600) break;
                        default:
                        {
                            ERR_ShowError(ERR_FATAL"Unsupported baud rate specified: %u\n\r",
                                          Desc->Value);
                            return TRUE;
                        }
                    }
                    break;
                }
#endif SWTYP_BAUDRATE

//
// ключ является датой
//
#ifdef SWTYP_DATE
                case SWTYP_DATE:
                {
                    DWORD Date;
                    BYTE Year;
                    BYTE Month;
                    BYTE Day;
                    Date  = Desc->Value;
                    Year  = (BYTE)(Date%100); Date = Date/100;
                    Month = (BYTE)(Date%100); Date = Date/100;
                    Day   = (BYTE)(Date%100); Date = Date/100;
                    Date  = Desc->Value;
                    if((Date>999999L)||(Day>31)||(Month>12))
                    {
                        ERR_ShowError(ERR_FATAL"Invalid date specified: %u\n\r",
                                      Desc->Value);
                        return TRUE;
                    }
                    break;
                }
#endif SWTYP_DATE
//
// ключ является серийным номером
//
#ifdef SWTYP_SERNUM
                case SWTYP_SERNUM:
                {

                    break;
                }
#endif SWTYP_SERNUM
//
// При добавлении новых типов ключей SWTYP_xxxx следует добавить новые метки
//
                default:
                    {
                        ERR_ShowError(ERR_DEBUG"Unknown switch type encountered\n\r");
                        return TRUE;
                    }
            } // switch
        } // for
    return FALSE;
}

//
// Функция проверки взаимной совместимости ключей между собой
// Проверяются следующие критерии:
//  - если какой-то ключ требует указания какого-то другого ключа
//    или комбинации ключей, то это условие проверяется;
//  - проверяются несовместимые комбинации ключей
//  - могут вызываться дополнительные процедуры проверки;
//
BOOL CL_CheckCompatibility(void)
{
    PSWITCH_DESC Desc;

    for(Desc = &Switch[0]; Desc < &Switch[KEY_TAB_SIZE]; Desc++)
    {
        if ( ! Desc->Flags & SWFLG_PRESENT ) continue;
        if ( CLD_KeyMask & Desc->IncompKey )
        {
            ERR_ShowError(ERR_FATAL"Incompatible switch combination specified\n\r");
            return TRUE;
        }
        if ((CLD_KeyMask & Desc->RequireKey) != Desc->RequireKey)
        {
            ERR_ShowError(ERR_FATAL"Incomplete switch combination specified\n\r");
            return TRUE;
        }
        if (Desc->VerifyProc != NULL)
            if(Desc->VerifyProc(Desc))
                return TRUE;
    }
    return FALSE;
}

//
// Функция первичной обработки командной строки
// Получает аргументы, переданные основной функции main()
// В случае ошибки выводит сообщения с использованием
// функции ERR_ShowText() и возвращает ненулевое значение
//
BOOL CL_ParseCmdLine(int arg, char* argv[])
{
    int i;

    if (arg < 2)
    {
        //
        // если не указано дополнительных
        // аргументов, то выводим справочное сообщение
        //
        ERR_ShowHelp();
        return TRUE;
    }

    for (i = 1; i < arg; i++)
    {
        //
        // Поочередно обрабатываем ключи и проверяем синтаксис отдельных ключей
        //
        if (CL_EnumerateKey(argv[i]))
            return TRUE;
    }

    //
    // Производим проверку допустимости значений и совместимости ключей
    // Вызываем их только тогда, когда все ключи получены и предварительно
    // обработаны
    //
    if (CL_CheckValues()|| CL_CheckCompatibility())
        return TRUE;
    return FALSE;
}

//
// Функции получения имен входного и выходного файлов, если имена
// не были указаны, то возвращают NULL
//
#ifdef  KEY_INFILE_BIT
char* CL_GetInFile(void)
{
    //
    // Проверим, было ли указано имя входного в файла в командной строке
    //
    if (CL_KeyPresent(KEY_INFILE_BIT) && strlen(InFileName))
    {
        return &InFileName[0];
    }
    return NULL;
}

#ifdef  KEY_OUTFILE_BIT
char* CL_GetOutFile(void)
{
    //
    // Проверим, было ли указано имя выходного в файла в командной строке
    //
    if (CL_KeyPresent(KEY_OUTFILE_BIT) && strlen(OutFileName))
    {
        return &OutFileName[0];
    }
    return NULL;
}
#endif
#endif

//
// Функция получения указателя на значение ключа (если было указано
// в командной строке, иначе возвращается указатель на значение
// по умолчанию), дальнейшая обработка зависит от типа значения
// ключа. Если ключ не был указан, то возвращает NULL
//
//
PVOID CL_GetValuePtr(DWORD KeyBit)
{
    PSWITCH_DESC Desc;
    PVOID Result = NULL;

    for(Desc = &Switch[0]; Desc < &Switch[KEY_TAB_SIZE]; Desc++)
    {
        if(Desc->KeyBit == KeyBit)
        {
            if (!CL_KeyPresent(KeyBit))
            {
                //
                // Если ключ не присутствует в командной строке вернем NULL
                //
                break;
            }
            switch(Desc->Type)
            {
//
// ключ не может иметь никаких значений
//
#ifdef SWTYP_NOVALUE
                case SWTYP_NOVALUE:
                {
                    break;
                }
#endif SWTYP_NOVALUE

//
// ключ может иметь дополнительный '+'
//
#ifdef SWTYP_PLUS
                case SWTYP_PLUS:
                {
                    if (Desc->Flags & SWFLG_HASVALUE)
                    {
                        Result = &Desc->Value;
                    }
                    break;
                }
#endif SWTYP_PLUS

//
// ключ может иметь беззнаковое десятичное значение
//
#ifdef SWTYP_DECVALUE
                case SWTYP_DECVALUE:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_DECVALUE

//
// ключ может иметь беззнаковое шестнадцатиричное значение
//
#ifdef SWTYP_HEXVALUE
                case SWTYP_HEXVALUE:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_HEXVALUE

//
// ключ является номером или адресом LPT-порта
//
#ifdef SWTYP_LPTPORT
                case SWTYP_LPTPORT:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_LPTPORT
//
// ключ является номером COM-порта
//
#ifdef SWTYP_COMPORT
                case SWTYP_COMPORT:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_COMPORT
//
// ключ является скоростью обмена
//
#ifdef SWTYP_BAUDRATE
                case SWTYP_BAUDRATE:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_BAUDRATE
//
// ключ является датой
//
#ifdef SWTYP_DATE
                case SWTYP_DATE:
                {
                    /*
                    DWORD Date1,Date;
                    Date = 0;
                    Date1  = Desc->Value;
                    Date |= (((Date1%100)&0xFF)<<16); Date1 = Date1/100;
                    Date |= (((Date1%100)&0xFF)<<8); Date1 = Date1/100;
                    Date |= (((Date1%100)&0xFF));
                    Result = &Date;
                    */
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_DATE
//
// ключ является серийным номером
//
#ifdef SWTYP_SERNUM
                case SWTYP_SERNUM:
                {
                    // это уже адрес
                    Result  = (PVOID)(Desc->Value);
                    break;
                }
#endif SWTYP_SERNUM
//
// При добавлении новых типов ключей следует добавить новые метки
//
                default:
                    {
                        ERR_ShowError(ERR_DEBUG"Unknown switch type encountered\n\r");
                        break;
                    }
            }
            break;
        }
    }
    return Result;
}
