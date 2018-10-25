//
// Модуль:          процедуры работы с буферами памяти для различных утилит
//
#include "config.h"
#include <windows.h>                    // включаем нужные определения
#include "buffer.h"

//
// Функция очистки карты буфера и заполнения области данныз
// моделью по умолчанию
//
void BF_Clear(PBUF Buf)
{
    memset(&Buf->Data[0], BF_DEF_DATA, Buf->Size);
    memset(Buf->Map, 0, Buf->MapSize);
}

//
// Функция создает буфер указанного размера (в байтах),
// при этом буфер заполняется моделью по умолчанию, карта
// буфера обнуляется.
//
PBUF BF_Create(DWORD Size)
{
    PBUF Buf;

    //
    // Выравниваем размер буфера на параграф (16 байтов)
    //
    Size = (Size + 0x0FL) & ~0x0FL;

    if (0 == Size)
    {
        return NULL;
    }

    //
    // Выделяем место для буфера
    //
    Buf = malloc( sizeof(BUF)               // место для заголовка буфера
                  + Size                    // место для данных
                  + ((Size + 7)>>3) + 4 );  // место для карты буфера
    if (NULL == Buf)
    {
        return NULL;
    }

    //
    // Инициализировали внутренние поля буфера
    //
    Buf->Size = Size;
    Buf->Map = &Buf->Data[Size];
    Buf->MapSize = (Size + 7) >> 3;
    //
    // Произвели инициализацию полей данных
    //
    BF_Clear(Buf);
    return Buf;
}

//
// Функция удаления созданного буфера и освобождения всех
// связанных с буфером ресурсов
//
void BF_Close(PBUF Buf)
{
    free(Buf);
}


//
// Функция безусловной записи данных в буфер без проверки
// признака наличия данных по адресу приемника. После
// проведения записи безусловно устанавливаются признаки
// наличия данных.
//
DWORD BF_WriteArray(PBUF Buf, DWORD Dst, PBYTE DataW, DWORD Count)
{
    BYTE MaskBeg, MaskEnd;
    PBYTE Beg, End;
    //
    // Проверим блок адресов на допустимость
    //
    if (Count > Buf->Size) return BF_ERR_OVF;
    if (Dst > Buf->Size) return BF_ERR_OVF;
    if ((Dst + Count) > Buf->Size) return BF_ERR_OVF;

    //
    // Копируем сами данные
    //
    if (Count == 0) return BF_ERR_SUCCESS;
    memcpy(&Buf->Data[Dst], DataW, Count);

    Beg = (Buf->Map) + (Dst >> 3);
    End = (Buf->Map) + ((Dst + Count) >> 3);
    MaskBeg = 0xFF << (Dst & 0x07L);
    MaskEnd = ~( 0xFF << ((Dst + Count) & 0x07L));

    if (Beg == End)
    {
        *Beg |= (MaskBeg & MaskEnd);
    }
    else
    {
        *Beg |= MaskBeg;
        *End |= MaskEnd;
    }

    if ((End - Beg) > 1)
    {
        memset(Beg + 1, 0xFF, (End - Beg) - 1);
    }
    return BF_ERR_SUCCESS;
}
//
// Функция безусловного считывания данных из буфера без проверки
// признака наличия данных по адресу источника.
//
DWORD BF_ReadArray(PBUF Buf, DWORD Src, PBYTE DataR, DWORD Count)
{
    //
    // Проверим блок адресов на допустимость
    //
    if (Count > Buf->Size) return BF_ERR_OVF;
    if (Src > Buf->Size) return BF_ERR_OVF;
    if ((Src + Count) > Buf->Size) return BF_ERR_OVF;

    //
    // Копируем сами данные
    //
    if (Count == 0) return BF_ERR_SUCCESS;
    memcpy(DataR, &Buf->Data[Src], Count);

    return BF_ERR_SUCCESS;
}

//
// Функция безусловного считывания байта из буфера без проверки
// признака наличия данных по адресу источника.
//
DWORD BF_ReadByte(PBUF Buf, DWORD Begin)
{
    //
    // Проверим блок адресов на допустимость
    //
    if (Begin >= Buf->Size) return BF_ERR_OVF;
    return Buf->Data[Begin];
}

//
// Функция безусловной записи байта в буфер без проверки
// признака наличия данных по адресу приемника
//
DWORD BF_WriteByte(PBUF Buf, DWORD Begin, BYTE Data)
{
    //
    // Проверим блок адресов на допустимость
    //
    if (Begin >= Buf->Size) return BF_ERR_OVF;
    //
    // Скопируем данные
    //
    Buf->Data[Begin] = Data;
    //
    // Установим признак наличия данных
    //
    *((Buf->Map) + (Begin >> 3)) |= (BYTE)(1 << (Begin & 0x07));
    return BF_ERR_SUCCESS;
}

//
// Функция проверки наличия байта в буфере по указанному индексу
// Возвращает:
//      0   - нет байта
//      !=0 - байт присутствует
//
DWORD BF_TestByte(PBUF Buf, DWORD Begin)
{
    //
    // Проверим блок адресов на допустимость
    //
    if (Begin >= Buf->Size) return BF_ERR_OVF;
    //
    // Установим признак наличия данных
    //
    return (*((Buf->Map) + (Begin >> 3)) & ((BYTE)(1 << (Begin & 0x07))));
}

//
// Функция записи данных в буфер с проверкой признака наличия данных
// по адресу приемника. Если обнаружены данные, то функция возвращает
// ошибку. После проведения записи безусловно устанавливаются признаки
// наличия данных.
//
DWORD BF_InsertArray(PBUF Buf, DWORD Dst, PBYTE DataW, DWORD Count)
{
    BYTE MaskBeg, MaskEnd;
    PBYTE Beg, End;
    //
    // Проверим блок адресов на допустимость
    //
    if (Count > Buf->Size) return BF_ERR_OVF;
    if (Dst > Buf->Size) return BF_ERR_OVF;
    if ((Dst + Count) > Buf->Size) return BF_ERR_OVF;
    if (Count == 0) return BF_ERR_SUCCESS;

    Beg = (Buf->Map) + (Dst >> 3);
    End = (Buf->Map) + ((Dst + Count) >> 3);
    MaskBeg = 0xFF << (Dst & 0x07L);
    MaskEnd = ~( 0xFF << ((Dst + Count) & 0x07L));

    if (Beg == End)
    {
        //
        // Сначала проверим, нет ли у нас данных,
        // а потом производим установку, потому что
        // проверок больше не будет
        //
        if (*Beg & MaskBeg & MaskEnd)
        {
            return BF_ERR_DATA;
        }
        *Beg |= (MaskBeg & MaskEnd);
    }
    else
    {
        if ((*Beg & MaskBeg) ||
            (*End & MaskEnd) )
                return BF_ERR_DATA;

        if ((End - Beg) > 1)
        {
            PBYTE Ptr = Beg + 1;

            while(Ptr < End)
            {
                if( *Ptr++ )
                    return BF_ERR_DATA;
            }
            memset(Beg + 1, 0xFF, (End - Beg) - 1);
        }
        *Beg |= MaskBeg;
        *End |= MaskEnd;
    }

    //
    // Копируем сами данные
    //
    memcpy(&Buf->Data[Dst], DataW, Count);
    return BF_ERR_SUCCESS;
}

//
// Функция поиска записанного байта в буфере. Поиск байта ведется по
// по признаку наличия данных, начиная с указанного адреса. Если более
// байтов не обнаружено, то возвращается 0xFFFFFFFF, иначе возвращается
// смещение найденного байта в буфере
//
DWORD BF_NextByte(PBUF Buf, DWORD Begin)
{
    DWORD Index;
    BYTE  Data;

    //
    // Проверим блок адресов на допустимость
    //
    if (Begin >= Buf->Size) return BF_ERR_OVF;

    Index = Begin;
    while(Index < Buf->Size)
    {
        Data = *(Buf->Map + (Index >> 3));
        Data &= (0xFF << (Index & 0x07L));
        if (Data != 0)
        {
            //
            // Обнаружены какие-то данные
            //
            Data = Data >> (Index & 0x07L);
            while( !(Data & 0x01))
            {
                Data >>= 1;
                Index ++;
            }
            return Index;
        }
        Index = (Index & ~0x07L) + 8;
    }
    return BF_ERR_NOMORE;
}

