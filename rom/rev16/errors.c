//
// Модуль:          функции вывода диагностических сообщений
//
#define __ERRORS_INTERNAL__             // определение внутренних функций
#include "config.h"                     //
#include <windows.h>                    // включаем нужные определения
#include <stdio.h>                      //
#include "errors.h"                     // функции вывода сообщений об ошибках
#include "cmdline.h"

//
// Функция вывода начального сообщения о версии и программе
//
void ERR_ShowStart(void)
{
//
//  printf("\n\r*** Start Message should be here ***\n\r");
//
    printf("\n\r1801PE2 conversion utility (Win32)," \
           " (c) 2002-2013 by VSO team, v%d.%d%c\n\r",
             REV16_MAJOR_REV,
             REV16_MINOR_REV,
             REV16_CHAR_REV );
}

//
// Функция вывода справочного сообщения
//
void ERR_ShowHelp(void)
{
//
//  printf("\n\r*** Help Message should be here ***\n\r");
//
    printf(
        "\n\rUsage: rev16 [[-|/]switch ...] infile outfile"                             \
        "\n\r"                                                                          \
        "\n\r -#    - verbose operations;"                                              \
        "\n\r -c_   - write the chipcode to output fule (0..7);"                            \
        "\n\r -f_   - fill the gaps with specified value (0..FF);"                      \
        "\n\r -?    - show this help screen;"                                           \
        "\n\r" );
}

//
// Функция вывода диагностических сообщений
//
void __cdecl ERR_Verbose(char* Format, ...)
{
    if (CL_KeyPresent(KEY_VERB_BIT))
    {
        va_list ArgList;
        va_start(ArgList, Format);
        vprintf(Format, ArgList);
    }
}

void ERR_VerboseHex(DWORD Hex)
{
    ERR_Verbose("\b\b\b\b\b\b%06X", Hex);
}

void ERR_VerboseDec(DWORD Dec)
{
    ERR_Verbose("\b\b\b\b\b\b%06d", Dec);
}

void ERR_VerboseDone(void)
{
    ERR_Verbose("\b\b\b\b\b\bDone    ");
}

void ERR_VerboseFail(void)
{
    ERR_Verbose("\b\b\b\b\b\bFail    ");
}
