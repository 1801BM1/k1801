//
// ������:          ��������� ��������� �����-������ ��� ��������� ������
// ����������:      Microsoft Visual C++ v6.0
// �������:         �� 19 �������� 2003 ����
//
// 19 �������� 2003
//      ������� ������ ���
//
#include "config.h"
#include <windows.h>
#include <io.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include "errors.h"
#include "cmdline.h"
#include "buffer.h"
#include "fileio.h"

//
// ��������� ��������� ���� ������������� ��� ������
// ���������� �������� ����� ��� NULL � ������ ������
// ��� �������� ��������������� ������ ������ ��� ������
//
PFHANDLE FL_Open(char* Name, DWORD BufSize)
{
    PFHANDLE File;

    if (NULL == Name)
    {
        return NULL;
    }
    //
    // ������� �������� ������ ��� ���������
    //
    File = malloc(sizeof(FHANDLE) + BufSize);
    if (NULL == File)
    {
        return NULL;
    }

    File->Handle = open(Name, _O_RDONLY | _O_SEQUENTIAL | _O_BINARY, 0);

    if (File->Handle < 0)
    {
        //
        // ���� �������� ������, �� ��������� ���������� ������
        //
        free(File);
        return NULL;
    }

    File->Size = BufSize;
    File->Ptr = File->End = &File->Data[0];
    File->Flags = 0;
    return File;
}

//
// ��������� ��������� ���� ������������� ��� ������
// ���������� �������� ����� ��� NULL � ������ ������
// ��� �������� ��������������� ������ ������ ��� ������
//
PFHANDLE FL_Create(char* Name, DWORD BufSize)
{
    PFHANDLE File;

    if (NULL == Name)
    {
        return NULL;
    }

    //
    // ������� �������� ������ ��� ���������
    //
    File = malloc(sizeof(FHANDLE) + BufSize);
    if (NULL == File)
    {
        return NULL;
    }

    File->Handle = open(Name,
                    _O_CREAT | _O_BINARY | _O_WRONLY | _O_SEQUENTIAL | _O_TRUNC,
                    _S_IREAD | _S_IWRITE );

    if (File->Handle < 0)
    {
        //
        // ���� �������� ������, �� ��������� ���������� ������
        //
        free(File);
        return NULL;
    }

    File->Size = BufSize;
    File->Ptr = &File->Data[0];
    File->End = &File->Data[BufSize];
    File->Flags = FLFLG_ForWrite;
    return File;
}

//
// ���������� ������ ���������� ����� ������ �� �����
// ���������� ����� ������� ����������� ������,
// 0 - � ������ ����� ����� ��� ������ ������
//
DWORD FL_ReadArray(PFHANDLE File, PBYTE Data, DWORD Count)
{
    DWORD Read = 0;     // ��� ��������� ������
    DWORD Part = 0;

    if (File->Flags & FLFLG_ForWrite) return 0;
    if (Count == 0) return 0;

    while(Read < Count)
    {
        if (File->Ptr >= File->End)
        {
            //
            // ������� ������ ������ � ������ ���������
            // ��������� �� ����� ����� ������
            //
            File->Ptr = File->End = &File->Data[0];
            Part = read(File->Handle, File->Ptr, File->Size);
            if (Part == 0)
            {
                //
                // ��������� ����� �����, ������ ��� ��� ���������
                //
                break;
            }
            //
            // �����, ��� � ������ ��������� ����� ������
            //
            File->End += Part;
        }

        if (((DWORD)(File->End) - (DWORD)(File->Ptr)) >= (Count - Read))
        {
            //
            // � ������ ���� ���������� ��� �����������
            // ������ ��� ����������, ����� ������
            // �������� ����� ���������, ���������� �� �����
            // ����� ����������� ��� ��������� ������
            //
            memcpy(Data + Read, File->Ptr, Count - Read);
            File->Ptr += Count-Read;
            Read = Count;
            break;
        }

        //
        // ������ ��� ��� �������� � ������ � ���������� ����
        //
        memcpy(Data + Read, File->Ptr, File->End - File->Ptr);
        Read += File->End - File->Ptr;
        File->Ptr = File->End;
    }
    return Read;
}

//
// ���������� ������ ������ ����� �� �����
// ���������� < 0 - � ������ ����� ����� ��� ������ ������
//                  ����� ���������� ����������� ����
//
int FL_ReadByte(PFHANDLE File)
{
    DWORD Part;

    if (File->Flags & FLFLG_ForWrite) return -1;

    if (File->Ptr >= File->End)
    {
        //
        // ������� ������ ������ � ������ ���������
        // ��������� �� ����� ����� ������
        //
        File->Ptr = File->End = &File->Data[0];
        Part = read(File->Handle, File->Ptr, File->Size);
        if (Part == 0)
        {
            //
            // ��������� ����� �����, ������ -1
            //
            return -1;
        }
        //
        // �����, ��� � ������ ��������� ����� ������
        //
        File->End += Part;
    }

    return (0x000000FFL & (*File->Ptr++));
}

//
// ���������� ������ ���������� ����� ������ � ����
// � ������ ������ ���������� ��������� ��������
//
DWORD FL_WriteArray(PFHANDLE File, PBYTE Data, DWORD Count)
{
    DWORD Write = 0;        // ��� �������� ������
    DWORD Part;

    if (!(File->Flags & FLFLG_ForWrite))
    {
        //
        // ���� �� ������ ��� ������, ������ �������
        //
        return FL_ERR_SUCCESS;
    }

    if (Count == 0) return 0;
    while(Write < Count)
    {
        if (File->Ptr >= File->End)
        {
            //
            // ����� � ������ ���������, ������� �������� ������
            // �� ������ �� ���� � �������������� ���������
            //
            File->Ptr = &File->Data[0];
            Part = write(File->Handle, File->Ptr, File->Size);
            if (Part != File->Size)
            {
                //
                // ��������� �����-�� ������
                //
                break;
            }
        }

        if (((DWORD)(File->End) - (DWORD)(File->Ptr)) >= (Count - Write))
        {
            //
            // � ������ ���� ���������� ����� ��� ���������� ������
            // ����� ������ �������� ����� ���������, ������ ������ �
            // ���� ����� ����������� ��� ��������� ������
            //
            memcpy(File->Ptr, Data + Write, Count - Write);
            File->Ptr += Count - Write;
            Write = Count;
            break;
        }

        //
        // ��������� �������� ����� � ���������� ����
        //
        memcpy(File->Ptr, Data + Write, File->End - File->Ptr);
        Write += File->End - File->Ptr;
        File->Ptr = File->End;
    }

    //
    // ���������, ��� ����������� ������� ������
    //
    if (Write == Count)
        return FL_ERR_SUCCESS;
    else
        return FL_ERR_WRITE;
}

//
// ���������� ������ ������ �� ������ �� ����, � ������
// ������ ������� ��������� ���������� ��������� ��������
//
DWORD FL_Flush(PFHANDLE File)
{
    int Result;

    if (!(File->Flags & FLFLG_ForWrite))
    {
        //
        // ���� �� ������ ��� ������, ������ �������
        //
        return FL_ERR_SUCCESS;
    }

    if (File->Ptr != &File->Data[0])
    {
        Result = write(File->Handle, &File->Data[0], File->Ptr - &File->Data[0]);
        if (Result != File->Ptr - &File->Data[0])
        {
            ERR_ShowError(ERR_INFO"Write file error while flushing data\n\r");
            return FL_ERR_WRITE;
        }
        File->Ptr = &File->Data[0];
    }
    return FL_ERR_SUCCESS;
}

//
// ������� �������� ��������� �����, ���� ���� ��� ������
// �� ������, �� ���������� ������ ����������� ������ �� ����,
// ����� ������������� ������, ���������� ��� ������
//
void FL_Close(PFHANDLE File)
{
    if (File->Flags & FLFLG_ForWrite)
    {
        FL_Flush(File);
    }
    close(File->Handle);
    free(File);
}

//
// ������� ���������� ������ �� ���������� �����,
// ��� ���� � �������� ����� �� ���������� �������,
// ���������, ������� �����, � ����� CR/LF. ������
// ������ ������������.
// ����������:
//  < 0 - ��������� ������, ��������������� ��������� ��������
//  = 0 - ��������� ����� �����
//  > 0 - �������� �������� � �����, ������ ������������ �����
//
int FL_ReadLineSkip(PFHANDLE File, char* Line, DWORD Num)
{
    int Len = 0;
    int Data;

    while(Len < FL_LINSIZE)
    {
        Data = FL_ReadByte(File);
        if (Data < 0) return 0;
        switch(Data)
        {
            //
            // ���������� ��������� �������
            //
            case 0x09:
            case 0x0D:
            case 0x20:
                break;

            case 0x0A:
                *Line++ = 0;
                //
                // ���� ������ ������ �� ���������� �������� �� ���������
                //
                if (0 != Len)
                {
                    return Len;
                }
                Line--;
                break;

            default:
                *Line++ = (char)Data;
                Len++;
                break;
        }
    }
    ERR_VerboseFail();
    ERR_ShowError(ERR_FATAL"Input file line %d is too long\n\r", Num);
    return -1;
}

//
// ������� ���������� ��� ���������������� ����� � �����
// ������ ������� ������������ � ����� ��������� ��������
//
void FL_WriteHex(char* Line, BYTE Dat)
{
    if ((Dat>>4) < 10)
    {
        *Line++ = (Dat>>4) + '0';
    }
    else
    {
        *Line++ = (Dat>>4) - 10 + 'A';
    }
    if ((Dat & 0x0F) < 10)
    {
        *Line = (Dat & 0x0F) + '0';
    }
    else
    {
        *Line = (Dat & 0x0F) - 10 + 'A';
    }
}

//
// ������� ������ �� ������ ��� ���������������� ����� � ��������
// ������������� �� � ����. � ������ ������ ���������� ����������
// ����, ��� ������ - <0
//
int FL_ReadHex(char* Line)
{
    int Ret;
    int Data;

    //
    // � ����� ��������� �������������� �������
    // ������ �������������� ������, ��� �������������
    // ������������ �������
    //
    for(;;)
    {
        Data = *Line++;
        if (Data <  '0') return -1;
        if (Data <= '9')
        {
            Ret = (Data - '0') << 4;
            break;
        }
        if (Data <  'A') return -1;
        if (Data <= 'F')
        {
            Ret = (Data - 'A' + 10) << 4;
            break;
        }
        if (Data < 'a') return -1;
        if (Data <='f')
        {
            Ret = (Data - 'a' + 10) << 4;
            break;
        }
        return -1;
    }

    Data = *Line++;
    if (Data <  '0') return -1;
    if (Data <= '9') return (Ret | (Data - '0'));
    if (Data <  'A') return -1;
    if (Data <= 'F') return (Ret | (Data - 'A' + 10));
    if (Data <  'a') return -1;
    if (Data <= 'f') return (Ret | (Data - 'a' + 10));
    return -1;
}

#ifdef FLTYP_HEX

DWORD UpdateCRC(DWORD Init, BYTE Dat)
{
    DWORD register Crc;

    Crc = (Init << 8) | Dat;

    Crc = Crc << 1; if (Crc & 0x01000000L) Crc = Crc ^ 0x00800100L;
    Crc = Crc << 1; if (Crc & 0x01000000L) Crc = Crc ^ 0x00800100L;
    Crc = Crc << 1; if (Crc & 0x01000000L) Crc = Crc ^ 0x00800100L;
    Crc = Crc << 1; if (Crc & 0x01000000L) Crc = Crc ^ 0x00800100L;
    Crc = Crc << 1; if (Crc & 0x01000000L) Crc = Crc ^ 0x00800100L;
    Crc = Crc << 1; if (Crc & 0x01000000L) Crc = Crc ^ 0x00800100L;
    Crc = Crc << 1; if (Crc & 0x01000000L) Crc = Crc ^ 0x00800100L;
    Crc = Crc << 1; if (Crc & 0x01000000L) Crc = Crc ^ 0x00800100L;

    return (Crc >> 8) & 0xFFFFL;
}

//
// ������� �������������� ������ ������� Extended-Intel-Hex
// � �������� ������ � ������� ����� ������ �� ����������
// ������ � �����. � ������ ������ ������� ���������������
// ��������� � ���������� TRUE.
//
// ���� ������ �������� ����� NULL, �� ���������� �������������
// ����� ���������� ����������� ����������
//
BOOL FL_ProcLineHex(PBUF Buf, char* Line, DWORD Num)
{
    BYTE Bin[FL_LINSIZE/2];
    static DWORD SegDat;
    static DWORD FileCrc;
    static BOOL FileEnd;
    static BOOL SumFlag;
    int Len, Dat, i;
    DWORD Adr, Crc;

    if (Num == -1)
    {
        return SumFlag;
    }

    if ((NULL == Buf) || (NULL == Line))
    {
        SegDat = 0;
        FileCrc = 0;
        FileEnd = FALSE;
        SumFlag = FALSE;
        return FALSE;
    }
    //
    // ���� ���� ���������� ������ ����� �����,
    // �� ���������� ��� ����������� ������
    //
    if (FileEnd)
    {
        return FALSE;
    }

    //
    // ���� ������ ������ ������ ';', �� ��� �����������
    //
    if (*Line == ';')
    {
        return FALSE;
    }

    if (*Line++ != ':')
    {
        ERR_VerboseFail();
        ERR_ShowError(ERR_FATAL"Invalid hex-record found in line %d\n\r", Num);
        return TRUE;
    }

    //
    // �������� ����� ������
    //
    Len = FL_ReadHex(Line);
    if((Len < 0) || (Len>64))
    {
        ERR_VerboseFail();
        ERR_ShowError(ERR_FATAL"Invalid hex-record found in line %d\n\r", Num);
        return TRUE;
    }
    Crc = Len;
    Line += 2;

    //
    // �������� �������-�������������� ����, ��� ������, ������ � �����
    //
    for(i=0; i<(Len+4); i++)
    {
        Dat = FL_ReadHex(Line);
        if (Dat < 0)
        {
            ERR_VerboseFail();
            ERR_ShowError(ERR_FATAL"Invalid hex-record found in line %d\n\r", Num);
            return TRUE;
        }
        Bin[i] = (BYTE)Dat;
        Crc += Dat;
        Line += 2;
    }

    if(*Line)
    {
         ERR_VerboseFail();
         ERR_ShowError(ERR_FATAL"Invalid hex-record found in line %d\n\r", Num);
         return TRUE;
    }
    Adr = (Bin[0]<<8) + Bin[1];

    switch(Bin[2])
    {
        //
        // 00 - Data Record - ������� ���� ������
        //
        case 0x00:
        {
            Adr = Adr + SegDat;
            switch( BF_InsertArray( Buf, Adr, &Bin[3], Len))
            {
                case BF_ERR_SUCCESS:
                {
                    return FALSE;
                }
                case BF_ERR_OVF:
                {
                    //
                    // ������ ������� �� ������� ������
                    //
                    ERR_VerboseFail();
                    ERR_ShowError(ERR_FATAL"hex-record address exceeds the buffer limit in line %d\n\r", Num);
                    return TRUE;
                }
                case BF_ERR_DATA:
                {
                    ERR_VerboseFail();
                    ERR_ShowError(ERR_FATAL"overlapped hex-record found in line %d\n\r", Num);
                    return TRUE;
                }
                default:
                {
                    ERR_VerboseFail();
                    ERR_ShowError(ERR_DEBUG"BF_InsertArray returned unknown code\n\r");
                    return TRUE;
                }
            }
        }
        //
        // 01 - End Of File - ������ ����� �����
        //
        case 0x01:
        {
            if (Len != 0)
            {
                ERR_VerboseFail();
                ERR_ShowError(ERR_FATAL"hex-record has invalid len in line %d\n\r", Num);
                return TRUE;
            }
            FileEnd = 1;
            return FALSE;
        }
        //
        // 02 - Extended Segment Adrress - ���������� �����
        //
        case 0x02:
        {
            if (Len != 2)
            {
                ERR_VerboseFail();
                ERR_ShowError(ERR_FATAL"hex-record has invalid len in line %d\n\r", Num);
                return TRUE;
            }
            SegDat = ((Bin[3]<<8) + Bin[4]) << 4;
            if (SegDat >= BF_GetSize(Buf))
            {
                ERR_VerboseFail();
                ERR_ShowError(ERR_FATAL"hex-record address exceeds the buffer limit in line %d\n\r", Num);
                return TRUE;
            }
            return FALSE;
        }
        //
        // 04 - Extended Linear Adrress - ������� 16-���
        //      32-�������� ������
        //
        case 0x04:
        {
            if (Len != 2)
            {
                ERR_VerboseFail();
                ERR_ShowError(ERR_FATAL"hex-record has invalid len in line %d\n\r", Num);
                return TRUE;
            }
            SegDat = ((Bin[3]<<8) + Bin[4]) << 16;
            if (SegDat >= BF_GetSize(Buf))
            {
                ERR_VerboseFail();
                ERR_ShowError(ERR_FATAL"hex-record address exceeds the buffer limit in line %d\n\r", Num);
                return TRUE;
            }
            return FALSE;
        }
        //
        // 03 - Start Segment Address - ������ ����� �����
        //      �S:IP, ��� �������� - ������ ������������
        //
        case 0x03:
        {
            return FALSE;
        }
        //
        // 05 - Start Linear Adrress - ������ ����� �����
        //      � 32-������� �������� �������
        //
        case 0x05:
        {
            return FALSE;
        }
        default:
            break;
    }
    ERR_VerboseFail();
    ERR_ShowError(ERR_FATAL"Invalid hex-record type found in line %d\n\r", Num);
    return TRUE;
}
#endif FLTYP_HEX

#ifdef FLTYP_HEX
//
// ������� ������ � �������� ���� � ������� intel-hex
// � ������ ������ ������� ��������� � ���������� TRUE
//
BOOL WriteLineHex( PFHANDLE File, DWORD Len,
                   DWORD Addr, DWORD Type, PBYTE Data)
{
    BYTE Line[FL_LINSIZE+2], Crc;
    DWORD i;

    Line[0] = ':';
    FL_WriteHex(&Line[1], (BYTE)Len);
    FL_WriteHex(&Line[3], (BYTE)(Addr>>8));
    FL_WriteHex(&Line[5], (BYTE)(Addr));
    FL_WriteHex(&Line[7], (BYTE)(Type));
    Crc =  (BYTE)(Len  + (Addr>>8) + Addr + Type);

    for( i=0; i<Len; i++)
    {
        Crc = Crc + Data[i];
        FL_WriteHex(&Line[9 + 2*i], Data[i]);
    }

    Crc = -Crc;
    FL_WriteHex(&Line[9 + 2*Len], Crc);
    Line[11 + 2*Len] = 0x0D;
    Line[12 + 2*Len] = 0x0A;

    if(FL_WriteArray(File, Line, 13+2*Len))
    {
        ERR_VerboseFail();
        ERR_ShowError(ERR_FATAL"Output file write error\n\r");
        return TRUE;
    }
    return FALSE;
}
//
// ������� ���������� ������ ������ � �������� hex �����
// ��� ���� �������� ����� ��������������� ��������� �
// ������������� �������, ��� ������ ���������� TRUE
//
BOOL FL_SaveHex(char* Name, PBUF Buf, DWORD Flags)
{
    BYTE Frame[FL_HEXSIZE], SegBuf[2];
    DWORD Addr, Seg, Begin, Len, FileCrc;
    PFHANDLE File;


    File = FL_Create(Name, FL_BUFSIZE);
    if (NULL == File)
    {
        ERR_ShowError(ERR_FATAL"Output file open failure\n\r");
        return TRUE;
    }
    ERR_Verbose(FLMSG_WRITEHEX);

    Addr = 0;
    Seg = -1;
    FileCrc = 0;

    while(Addr < BF_GetSize(Buf))
    {
        Begin = BF_NextByte(Buf, Addr);
        if(Begin == BF_ERR_NOMORE)
        {
            //
            // ������ ������ ���, ����������� ���������
            //
            break;
        }

        Len = 0;
        while( (Len < FL_HEXSIZE) &&
               ((Begin+Len) < BF_GetSize(Buf)) &&
               ((((Begin+Len) ^ Begin) & 0xFFFF0000) == 0 ))
        {
            if (BF_TestByte(Buf, Begin+Len))
            {
                Frame[Len] = (BYTE)BF_ReadByte(Buf, Begin+Len);
                FileCrc = UpdateCRC(FileCrc, Frame[Len]);
                Len++;
            }
            else
            {
                break;
            }
        }
        Addr = Begin + Len;

        if((Begin & 0xFFFF0000) != (Seg & 0xFFFF0000))
        {
            Seg = Begin;
            //
            //
            // ������ ����������� �������� �� ������������ ����� ��������
            // ����� 1 ���������, ������� ���������� ������������ ������
            // ���������� ��������� ������
            //
            //  SegBuf[0] = (BYTE)(Seg>>12);
            //  SegBuf[1] = (BYTE)(Seg>>4);
            //
            //  if (WriteLineHex( File, 2, 0, 0x02, SegBuf))
            //  {
            //      FL_Close(File);
            //      return TRUE;
            //  }
            //
            SegBuf[0] = (BYTE)(Seg>>24);
            SegBuf[1] = (BYTE)(Seg>>16);
            if (WriteLineHex( File, 2, 0, 0x04, SegBuf))
            {
                FL_Close(File);
                return TRUE;
            }
        }
        if (Begin < 0x100000)
        {
            ERR_VerboseHex(Begin);
        }
        else
        {
            //
            // ��� ������� ������ ������� �������� �� 64K
            //
            if ((Begin & 0xFFFF) == 0)
            {
                ERR_VerboseHex(Begin);
            }
        }
        if (WriteLineHex( File, Len, Begin, 0x00, Frame))
        {
            FL_Close(File);
            return TRUE;
        }
    }
    //
    // ���������� ����� �����
    //
    if (WriteLineHex( File, 0, 0, 0x01, Frame))
    {
        FL_Close(File);
        return TRUE;
    }

    ERR_VerboseDone();
    FL_Close(File);
    return FALSE;
}
//
// ������� �������� hex ����� � ��������� ����� ������
// ��� ���� �������� ����� ��������������� ��������� �
// ������������� �������, ��� ������ ���������� TRUE
//
BOOL FL_LoadHex(char* Name, PBUF Buf, DWORD Flags)
{
    PFHANDLE File;
    DWORD LineNum;
    char  Line[FL_LINSIZE];
    int Status;

    File = FL_Open(Name, FL_BUFSIZE);
    if (NULL == File)
    {
        ERR_ShowError(ERR_FATAL"Source file open failure\n\r");
        return TRUE;
    }

    LineNum = 1;
    ERR_Verbose(FLMSG_READHEX);
    //
    // �������������� ��������� Hex-������
    //
    FL_ProcLineHex(NULL, NULL, 0);

    for(;;)
    {
        //
        // ������ �������, ���������� �������, ���������, ���� � CR/LF
        //
        Status = FL_ReadLineSkip(File, Line, LineNum);
        //
        // ��������� ����� �����?
        //
        if (Status == 0) break;
        //
        // ��������� ������ ���������� �����?
        //
        if (Status < 0)
        {
            FL_Close(File);
            return TRUE;
        }
        //
        // ������������ ��������� ������� �����
        //
        if (FL_ProcLineHex(Buf, Line, LineNum))
        {
            FL_Close(File);
            return TRUE;
        }

        if (LineNum < 10000)
        {
            ERR_VerboseDec(LineNum);
        }
        else
        {
            //
            // ��� ������� ���������� ����� ������� ������
            // ������ �������� �������
            //
            if ((LineNum % 1000) == 0)
            {
                ERR_VerboseDec(LineNum);
            }
        }
        LineNum++;
    }
    ERR_VerboseDone();
    FL_Close(File);
    return FALSE;
}
#endif FLTYP_HEX
