//
// Модуль:			заголовочный файл для процедур вывода диагностических сообщений
//
#ifndef __ERRORS_H__
#define __ERRORS_H__

//
// Определение необходимых префиксов диагностических сообщений
// Для каждого приложения должны определяться индивидуально
//
#define ERR_FATAL		"\n\r?REV16-F-"
#define ERR_INFO		"\n\r?REV16-I-"
#define ERR_DEBUG		"\n\r*** INTERNAL ERROR *** "

//
// Функция вывода начального сообщения о версии и программе
//
void ERR_ShowStart(void);

//
// Функция вывода справочного сообщения
//
void ERR_ShowHelp(void);

//
// Функция вывода сообщения об ошибке
//
#define ERR_ShowError	printf

//
// Функции вывода диагностических сообщений
//
void __cdecl ERR_Verbose(char* Format, ...);
void ERR_VerboseHex(DWORD Hex);
void ERR_VerboseDec(DWORD Dec);
void ERR_VerboseDone(void);
void ERR_VerboseFail(void);

#ifdef	__ERRORS_INTERNAL__			// определение внутренних функций и данных
#endif
#endif	// __ERRORS_H__

