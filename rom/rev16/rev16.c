//
// ������:      ������� ����������� ��������
//
// ����������:                          Microsoft Visual C++ v6.0
// �������:                                �� 9 ������� 2013 ����
//
// 9 ������� 2013
//      ������� ������ ���
//
#include "config.h"
#include "rev16.h"

//
// �������� �������� ����� � ����� ������
//
BOOL EXE_Read(PBUF pBuf)
{
    char* name;

    name = CL_GetInFile();
    if (name == NULL)
    {
        ERR_ShowError(ERR_FATAL"Unable to get input file name\n\r");
        return TRUE;
    }
    //
    // ���������� �������� HEX-�����
    //
    return FL_LoadHex(name, pBuf, 0);
}

//
// ���������� ������ � �������� �����
//
BOOL EXE_Write(PBUF pBuf)
{
    char* name;

    name = CL_GetOutFile();
    if (name == NULL)
    {
        ERR_ShowError(ERR_FATAL"Unable to get output file name\n\r");
        return TRUE;
    }
    return FL_SaveHex(name, pBuf, 0);
}

//
// ���������� �������������� - ������������� ������ � ������ 16-������ ����
//
BOOL EXE_Convert(PBUF Inp, PBUF Out)
{
    DWORD Addr, Data;

    ERR_Verbose("\nConverting data        : Wait..");
    Addr = 0;
    while(Addr < REV16_SIZE)
    {
        Addr = BF_NextByte(Inp, Addr);
        if(Addr == BF_ERR_NOMORE)
        {
            break;
        }
        if( Addr >= REV16_SIZE)
        {
            break;
        }
        Data = BF_ReadByte(Inp, Addr);
        Data = (~Data) & 0xFF;
        BF_WriteByte(Out, Addr ^ (REV16_SIZE-2), (BYTE)Data);
        Addr++;
    }
    ERR_VerboseDone();
    return FALSE;
}

//
// ���������� �������� �������� ������ ��������� �������
//
BOOL EXE_Fill(PBUF pBuf)
{
    if(CL_KeyPresent(KEY_F_BIT))
    {
        DWORD Addr, Data;

        Data = *(DWORD*)CL_GetValuePtr(KEY_F_BIT);
        ERR_Verbose("\nFilling gaps in data   : Wait..");
        for(Addr=0; Addr<REV16_SIZE; Addr++)
        {
            if (!BF_TestByte(pBuf, Addr))
            {
                BF_WriteByte(pBuf, Addr, (BYTE)Data);
            }
        }
        ERR_VerboseDone();
    }
    return FALSE;
}

//
// ���������� chipcode � ����� ����� (������ ������������� "�����")
//
BOOL EXE_Chipcode(PBUF pBuf)
{
    if(CL_KeyPresent(KEY_C_BIT))
    {
        DWORD Data;

        Data = *(DWORD*)CL_GetValuePtr(KEY_C_BIT);
        ERR_Verbose("\nWriting the chip code  : %d", Data);

        BF_WriteByte(pBuf, REV16_SIZE, (BYTE)Data);
        BF_WriteByte(pBuf, REV16_SIZE+1, 0x03);
    }
    return FALSE;
}

//
// �������� ������� ��������� - ����� �����
//
int __cdecl main(int argc, char* argv[])
{
    PBUF Input  = NULL;
    PBUF Output = NULL;
    int ExitCode = -1;

    //
    // ������� ��������� � ������� ���������
    //
    ERR_ShowStart();
    __try
    {
        //
        // ������� ������������ ��������� ������
        // ���� ��������� ������, �� ������ �������
        //
        if (CL_ParseCmdLine( argc, argv)) __leave;

        if (CL_KeyPresent(KEY_HELP_BIT))
        {
            ERR_ShowHelp();
            __leave;
        }
        if (!CL_KeyPresent(KEY_INFILE_BIT))
        {
            ERR_ShowError(ERR_FATAL"No input file name specified\n\r");
            __leave;
        }
        if (!CL_KeyPresent(KEY_OUTFILE_BIT))
        {
            ERR_ShowError(ERR_FATAL"No output file name specified\n\r");
            __leave;
        }
        ERR_Verbose("\n");
        //
        // ������� ������ ��� �������� ������
        //
        Input = BF_Create(REV16_SIZE + 2);
        if (NULL == Input)
        {
            ERR_ShowError(ERR_FATAL"Unable to allocate buffer memory\n\r");
            __leave;
        }
        Output = BF_Create(REV16_SIZE + 2);
        if (NULL == Output)
        {
            ERR_ShowError(ERR_FATAL"Unable to allocate buffer memory\n\r");
            BF_Close(Input);
            Input = NULL;
            __leave;
        }
        //
        // ���������� ������ �������� �����
        //
        if (EXE_Read(Input)) __leave;
        //
        // ��������� ��������������� ������� ������
        //
        if (EXE_Convert(Input, Output)) __leave;
        //
        // ����������� �������� ������
        //
        if (EXE_Fill(Output)) __leave;
        //
        // ���������� chipcode
        //
        if (EXE_Chipcode(Output)) __leave;
        //
        // ���������� ������ ��������� �����
        //
        if (EXE_Write(Output)) __leave;
        ERR_Verbose("\n");
        //
        // ��� �������� ������� ���������
        //
        ExitCode = 0;

    }
    __finally
    {
        //
        // ���������� ������������ ���� �������������� ��������
        //
        if (NULL != Input) BF_Close(Input);
        if (NULL != Output) BF_Close(Output);
    }
    exit(ExitCode);
}

