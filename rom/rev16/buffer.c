//
// ������:          ��������� ������ � �������� ������ ��� ��������� ������
//
#include "config.h"
#include <windows.h>                    // �������� ������ �����������
#include "buffer.h"

//
// ������� ������� ����� ������ � ���������� ������� ������
// ������� �� ���������
//
void BF_Clear(PBUF Buf)
{
    memset(&Buf->Data[0], BF_DEF_DATA, Buf->Size);
    memset(Buf->Map, 0, Buf->MapSize);
}

//
// ������� ������� ����� ���������� ������� (� ������),
// ��� ���� ����� ����������� ������� �� ���������, �����
// ������ ����������.
//
PBUF BF_Create(DWORD Size)
{
    PBUF Buf;

    //
    // ����������� ������ ������ �� �������� (16 ������)
    //
    Size = (Size + 0x0FL) & ~0x0FL;

    if (0 == Size)
    {
        return NULL;
    }

    //
    // �������� ����� ��� ������
    //
    Buf = malloc( sizeof(BUF)               // ����� ��� ��������� ������
                  + Size                    // ����� ��� ������
                  + ((Size + 7)>>3) + 4 );  // ����� ��� ����� ������
    if (NULL == Buf)
    {
        return NULL;
    }

    //
    // ���������������� ���������� ���� ������
    //
    Buf->Size = Size;
    Buf->Map = &Buf->Data[Size];
    Buf->MapSize = (Size + 7) >> 3;
    //
    // ��������� ������������� ����� ������
    //
    BF_Clear(Buf);
    return Buf;
}

//
// ������� �������� ���������� ������ � ������������ ����
// ��������� � ������� ��������
//
void BF_Close(PBUF Buf)
{
    free(Buf);
}


//
// ������� ����������� ������ ������ � ����� ��� ��������
// �������� ������� ������ �� ������ ���������. �����
// ���������� ������ ���������� ��������������� ��������
// ������� ������.
//
DWORD BF_WriteArray(PBUF Buf, DWORD Dst, PBYTE DataW, DWORD Count)
{
    BYTE MaskBeg, MaskEnd;
    PBYTE Beg, End;
    //
    // �������� ���� ������� �� ������������
    //
    if (Count > Buf->Size) return BF_ERR_OVF;
    if (Dst > Buf->Size) return BF_ERR_OVF;
    if ((Dst + Count) > Buf->Size) return BF_ERR_OVF;

    //
    // �������� ���� ������
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
// ������� ������������ ���������� ������ �� ������ ��� ��������
// �������� ������� ������ �� ������ ���������.
//
DWORD BF_ReadArray(PBUF Buf, DWORD Src, PBYTE DataR, DWORD Count)
{
    //
    // �������� ���� ������� �� ������������
    //
    if (Count > Buf->Size) return BF_ERR_OVF;
    if (Src > Buf->Size) return BF_ERR_OVF;
    if ((Src + Count) > Buf->Size) return BF_ERR_OVF;

    //
    // �������� ���� ������
    //
    if (Count == 0) return BF_ERR_SUCCESS;
    memcpy(DataR, &Buf->Data[Src], Count);

    return BF_ERR_SUCCESS;
}

//
// ������� ������������ ���������� ����� �� ������ ��� ��������
// �������� ������� ������ �� ������ ���������.
//
DWORD BF_ReadByte(PBUF Buf, DWORD Begin)
{
    //
    // �������� ���� ������� �� ������������
    //
    if (Begin >= Buf->Size) return BF_ERR_OVF;
    return Buf->Data[Begin];
}

//
// ������� ����������� ������ ����� � ����� ��� ��������
// �������� ������� ������ �� ������ ���������
//
DWORD BF_WriteByte(PBUF Buf, DWORD Begin, BYTE Data)
{
    //
    // �������� ���� ������� �� ������������
    //
    if (Begin >= Buf->Size) return BF_ERR_OVF;
    //
    // ��������� ������
    //
    Buf->Data[Begin] = Data;
    //
    // ��������� ������� ������� ������
    //
    *((Buf->Map) + (Begin >> 3)) |= (BYTE)(1 << (Begin & 0x07));
    return BF_ERR_SUCCESS;
}

//
// ������� �������� ������� ����� � ������ �� ���������� �������
// ����������:
//      0   - ��� �����
//      !=0 - ���� ������������
//
DWORD BF_TestByte(PBUF Buf, DWORD Begin)
{
    //
    // �������� ���� ������� �� ������������
    //
    if (Begin >= Buf->Size) return BF_ERR_OVF;
    //
    // ��������� ������� ������� ������
    //
    return (*((Buf->Map) + (Begin >> 3)) & ((BYTE)(1 << (Begin & 0x07))));
}

//
// ������� ������ ������ � ����� � ��������� �������� ������� ������
// �� ������ ���������. ���� ���������� ������, �� ������� ����������
// ������. ����� ���������� ������ ���������� ��������������� ��������
// ������� ������.
//
DWORD BF_InsertArray(PBUF Buf, DWORD Dst, PBYTE DataW, DWORD Count)
{
    BYTE MaskBeg, MaskEnd;
    PBYTE Beg, End;
    //
    // �������� ���� ������� �� ������������
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
        // ������� ��������, ��� �� � ��� ������,
        // � ����� ���������� ���������, ������ ���
        // �������� ������ �� �����
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
    // �������� ���� ������
    //
    memcpy(&Buf->Data[Dst], DataW, Count);
    return BF_ERR_SUCCESS;
}

//
// ������� ������ ����������� ����� � ������. ����� ����� ������� ��
// �� �������� ������� ������, ������� � ���������� ������. ���� �����
// ������ �� ����������, �� ������������ 0xFFFFFFFF, ����� ������������
// �������� ���������� ����� � ������
//
DWORD BF_NextByte(PBUF Buf, DWORD Begin)
{
    DWORD Index;
    BYTE  Data;

    //
    // �������� ���� ������� �� ������������
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
            // ���������� �����-�� ������
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

