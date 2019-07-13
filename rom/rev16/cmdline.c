//
// ������:          ��������� ��������� ��������� ������ ��� ��������� ������
//
#define __CMDLINE_INTERNAL__            // ����������� ���������� �������
#include "config.h"                     //
#include <windows.h>                    // �������� ������ �����������
#include <stdio.h>                      //
#include "errors.h"                     // ������� ������ ��������� �� �������
#include "cmdline.h"                    // ������� ��������� ��������� ������

#ifdef SWTYP_SERNUM
BOOL CL_IsUpper(BYTE c)
{

// 'A' - 0x41
// 'Z' - 0x5a

// '�' - 0xc0
// '�' - 0xdf

    if (((c >= 0x41) && (c <= 0x5a)) || ((c >= 0xc0) && (c <= 0xdf)))
        return TRUE;
    else
        return FALSE;
}

#endif //SWTYP_SERNUM

#ifdef KEY_INFILE_BIT
//
// ������� ����������� ����� ����� � ��������� �����
// ��� ���� ������������ ��������� �������� � ����
// �� ������� ���������� ����� �����, �� �����������
// ���������� �� ���������.
// � ������ ������ ������� ��������� � ���������� TRUE
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
    // ��������, ����� ���� ���������� ��� �������
    //
    if (strrchr(Buf, '.'))
    {
        return FALSE;
    }

    //
    // ���������� �� �������, ��������� �� ���������
    // �������������� �������� ������� ����� � ������
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
// ������� ��������� ����� �����, � ����������� �� ����������
// � ����������� (��� �������� �����/��� ��������� �����) �������� ���
// � ���� �� ����������� �������, ���� ���������, ��������� ����������
// � ������ ������ ������� ��������� � ���������� TRUE
//
BOOL CL_EnumerateFile(char* Key)
{
    if(CL_KeyPresent(KEY_INFILE_BIT))
    {
        //
        // ���� ��� ����� (��������) ��� ����������
        // �������, ����������� �� ������ ���
        //
#ifdef KEY_OUTFILE_BIT
        if(CL_KeyPresent(KEY_OUTFILE_BIT))
        {
            //
            // ��� ����� ������ ��� ������� - ������
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
        // ������ ��� ����� ����������� - ������� ������
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
// ������� �������������� ������� ���������� ���� � ����������� �����
// � ������ ������ ���������� ���������� ��������, � ������ ������
// ���������� 0 � ������������� ������� ������ CLD_ConvError
//
DWORD CL_GetDecValue(char* Line)
{
    DWORD Value = 0;
    int i;

    //
    // ���������� ������������ ������
    //
    CLD_ConvError = TRUE;
    //
    // ���������� ���������� ����
    //
    while(*Line == '0') Line++;
    //
    // ��������� �� ����� 9 �������� ����, ����� ������� ��
    // �������� ���������������� ��� ������������� ������������
    //
    for(i = 0; i < (sizeof(DWORD) * 2 + 1); i++)
    {
        //
        // ��������� ����� ������
        //
        if (*Line == 0) break;
        if (!isdigit(*Line)) break;
        Value = Value * 10 + *Line - '0';
        Line++;
    }
    //
    // ���� ����������, ���������, ��������� �� ����� ������
    //
    if (*Line == 0)
    {
        CLD_ConvError = FALSE;
        return Value;
    }
    //
    // ������� ������� �������
    //
    return 0;
}

//
// ������� �������������� ������� ����������������� ���� � ����������� �����
// � ������ ������ ���������� ���������� ��������, � ������ ������
// ���������� 0 � ������������� ������� ������ CLD_ConvError
//
DWORD CL_GetHexValue(char* Line)
{
    DWORD Value = 0;
    DWORD Add;

    //
    // ���������� ������������ ������
    //
    CLD_ConvError = TRUE;
    //
    // ��������� �� ����� 8 �������� ����, ����� ������� ��
    // �������� ���������������� ��� ������������� ������������
    //
    while (*Line)
    {
        //
        // ��������� ������ �� ������������
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
    // ���� ����������, ���������, ��������� �� ����� ������
    //
    if (*Line == 0)
    {
        CLD_ConvError = FALSE;
        return Value;
    }
    //
    // ������� ������� �������
    //
    return 0;
}

//
// ������� ��������� �����, �������� ��������� �� ���������� ����,
// ���� ��� � ������� ������, �������� � ��������� �������� ����������� �����.
// � ������ ������ ������� ��������� � ���������� TRUE
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
            // ���������� ������ � ������� ���������� ������
            //
            if (CL_KeyPresent(Desc->KeyBit))
            {
                //
                // ���� ������ ��� � ����� ��� - ������
                //
                ERR_ShowError(ERR_FATAL"Multiple switch specification\n\r");
                return TRUE;
            }
            //
            // ���� ���������, ������������� �������� ������� �����
            //
            CLD_KeyMask |= Desc->KeyBit;
            Desc->Flags |= SWFLG_PRESENT;

            VPtr = Key + 1;     // ��������� �� ��������� �������� �����

            switch(Desc->Type)
            {
//
// ���� �� ����� ����� ������� ��������
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
// ���� ����� ����� �������������� '+'
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
// ���� ����� ����� ����������� ���������� ��������
//
#ifdef SWTYP_DECVALUE
                case SWTYP_DECVALUE:
                {
                    //
                    // ��������, � ����� ������ �� ����������� ���� ��������
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
                        // �������� ��������� ��������
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
// ���� ����� ����� ����������� ����������������� ��������
//
#ifdef SWTYP_HEXVALUE
                case SWTYP_HEXVALUE:
                {
                    //
                    // ��������, � ����� ������ �� ����������� ���� ��������
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
                        // �������� ��������� ��������
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
// ���� �������� ������� ��� ������� LPT-�����
//
#ifdef SWTYP_LPTPORT
                case SWTYP_LPTPORT:
                {
                    //
                    // ��������, � ����� ������ ����������� ���� ��������
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have LPT port address or number\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // �������� ��������� ��������
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
// ���� �������� ������� COM-�����
//
#ifdef SWTYP_COMPORT
                case SWTYP_COMPORT:
                {
                    //
                    // ��������, � ����� ������ ����������� ���� ��������
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have communication port number\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // �������� ��������� ��������
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
// ���� �������� ��������� ������ �� COM-�����
//
#ifdef SWTYP_BAUDRATE
                case SWTYP_BAUDRATE:
                {
                    //
                    // ��������, � ����� ������ ����������� ���� ��������
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have baudrate value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // �������� ��������� ��������
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
// ���� �������� �����
//
#ifdef SWTYP_DATE
                case SWTYP_DATE:
                {
                    //
                    // ��������, � ����� ������ ����������� ���� ��������
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have valid date value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // �������� ��������� ��������
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
// ���� �������� �������
//
#ifdef SWTYP_SERNUM
                case SWTYP_SERNUM:
                {
                    //
                    // ��������, � ����� ������ ����������� ���� ��������
                    //
                    if (*VPtr == 0)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have serial number value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // ��� ����� � ������ ����
                    //
                    if(10!=strlen(VPtr))
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c must have 2 letters and 8 digits \n\r", *Key);
                        return TRUE;
                    }
                    //
                    // �������� �����
                    //
                    Desc->Value = CL_GetDecValue(VPtr+2);
                    if (CLD_ConvError)
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // �������� ����� �� ������� �������
                    //
                    if((FALSE==CL_IsUpper(*VPtr))||(FALSE==CL_IsUpper(*(VPtr+1))))
                    {
                        ERR_ShowError(ERR_FATAL"Switch -%c has invalid value\n\r", *Key);
                        return TRUE;
                    }
                    //
                    // �������� ��������� �� ������ � �������
                    //
                    Desc->Value = (DWORD)VPtr;
                    Desc->Flags |= SWFLG_HASVALUE;
                    break;
                }
#endif SWTYP_SERNUM

//
// ��� ���������� ����� ����� ������ ������� �������� ����� �����
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
// ������� ��������� ���������� �����, ���������� �������������� ��������
// � ������ ������ ������� ��������� � ���������� TRUE
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
        // �������� ���������� ��� �����, ����� ���������� ����������
        //
        return CL_EnumerateFile(Key);
    #else
        //
        // ���� ��� ����� � ��������� ������ �����������, �� ���������� ������
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
// ������� �������� ���������� �������� ������
//
//
BOOL CL_CheckValues(void)
{
    PSWITCH_DESC Desc;

    for(Desc = &Switch[0]; Desc < &Switch[KEY_TAB_SIZE]; Desc++)
    {
        if (!Desc->Flags & SWFLG_PRESENT) continue;
        //
        // ���� ���� �� ����� ��������, �� �� ��������� ���
        //
        if (!Desc->Flags & SWFLG_HASVALUE) continue;

        switch(Desc->Type)
        {
//
// ���� �� ����� ����� ������� ��������, ������ �� ���������
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
// ���� ����� ����� ����������� ���������� ��������
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
                    // �������� ������������ ��������� ��������
                    //
                    if (Desc->ValueProc != NULL)
                        if(Desc->ValueProc(Desc))
                            return TRUE;
                    break;
                }
#endif SWTYP_DECVALUE

//
// ���� ����� ����� ����������� ����������������� ��������
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
                    // �������� ������������ ��������� ��������
                    //
                    if (Desc->ValueProc != NULL)
                        if(Desc->ValueProc(Desc))
                            return TRUE;
                    break;
                }
#endif SWTYP_HEXVALUE

//
// ���� �������� ������� ��� ������� LPT-�����
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
// ���� �������� ������� COM-�����
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
// ���� �������� �����
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
// ���� �������� �������� �������
//
#ifdef SWTYP_SERNUM
                case SWTYP_SERNUM:
                {

                    break;
                }
#endif SWTYP_SERNUM
//
// ��� ���������� ����� ����� ������ SWTYP_xxxx ������� �������� ����� �����
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
// ������� �������� �������� ������������� ������ ����� �����
// ����������� ��������� ��������:
//  - ���� �����-�� ���� ������� �������� ������-�� ������� �����
//    ��� ���������� ������, �� ��� ������� �����������;
//  - ����������� ������������� ���������� ������
//  - ����� ���������� �������������� ��������� ��������;
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
// ������� ��������� ��������� ��������� ������
// �������� ���������, ���������� �������� ������� main()
// � ������ ������ ������� ��������� � ��������������
// ������� ERR_ShowText() � ���������� ��������� ��������
//
BOOL CL_ParseCmdLine(int arg, char* argv[])
{
    int i;

    if (arg < 2)
    {
        //
        // ���� �� ������� ��������������
        // ����������, �� ������� ���������� ���������
        //
        ERR_ShowHelp();
        return TRUE;
    }

    for (i = 1; i < arg; i++)
    {
        //
        // ���������� ������������ ����� � ��������� ��������� ��������� ������
        //
        if (CL_EnumerateKey(argv[i]))
            return TRUE;
    }

    //
    // ���������� �������� ������������ �������� � ������������� ������
    // �������� �� ������ �����, ����� ��� ����� �������� � ��������������
    // ����������
    //
    if (CL_CheckValues()|| CL_CheckCompatibility())
        return TRUE;
    return FALSE;
}

//
// ������� ��������� ���� �������� � ��������� ������, ���� �����
// �� ���� �������, �� ���������� NULL
//
#ifdef  KEY_INFILE_BIT
char* CL_GetInFile(void)
{
    //
    // ��������, ���� �� ������� ��� �������� � ����� � ��������� ������
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
    // ��������, ���� �� ������� ��� ��������� � ����� � ��������� ������
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
// ������� ��������� ��������� �� �������� ����� (���� ���� �������
// � ��������� ������, ����� ������������ ��������� �� ��������
// �� ���������), ���������� ��������� ������� �� ���� ��������
// �����. ���� ���� �� ��� ������, �� ���������� NULL
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
                // ���� ���� �� ������������ � ��������� ������ ������ NULL
                //
                break;
            }
            switch(Desc->Type)
            {
//
// ���� �� ����� ����� ������� ��������
//
#ifdef SWTYP_NOVALUE
                case SWTYP_NOVALUE:
                {
                    break;
                }
#endif SWTYP_NOVALUE

//
// ���� ����� ����� �������������� '+'
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
// ���� ����� ����� ����������� ���������� ��������
//
#ifdef SWTYP_DECVALUE
                case SWTYP_DECVALUE:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_DECVALUE

//
// ���� ����� ����� ����������� ����������������� ��������
//
#ifdef SWTYP_HEXVALUE
                case SWTYP_HEXVALUE:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_HEXVALUE

//
// ���� �������� ������� ��� ������� LPT-�����
//
#ifdef SWTYP_LPTPORT
                case SWTYP_LPTPORT:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_LPTPORT
//
// ���� �������� ������� COM-�����
//
#ifdef SWTYP_COMPORT
                case SWTYP_COMPORT:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_COMPORT
//
// ���� �������� ��������� ������
//
#ifdef SWTYP_BAUDRATE
                case SWTYP_BAUDRATE:
                {
                    Result = &Desc->Value;
                    break;
                }
#endif SWTYP_BAUDRATE
//
// ���� �������� �����
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
// ���� �������� �������� �������
//
#ifdef SWTYP_SERNUM
                case SWTYP_SERNUM:
                {
                    // ��� ��� �����
                    Result  = (PVOID)(Desc->Value);
                    break;
                }
#endif SWTYP_SERNUM
//
// ��� ���������� ����� ����� ������ ������� �������� ����� �����
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
