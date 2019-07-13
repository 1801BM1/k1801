//
// ������:			������������ ���� ��� �������� ������ ��������������� ���������
//
#ifndef __ERRORS_H__
#define __ERRORS_H__

//
// ����������� ����������� ��������� ��������������� ���������
// ��� ������� ���������� ������ ������������ �������������
//
#define ERR_FATAL		"\n\r?REV16-F-"
#define ERR_INFO		"\n\r?REV16-I-"
#define ERR_DEBUG		"\n\r*** INTERNAL ERROR *** "

//
// ������� ������ ���������� ��������� � ������ � ���������
//
void ERR_ShowStart(void);

//
// ������� ������ ����������� ���������
//
void ERR_ShowHelp(void);

//
// ������� ������ ��������� �� ������
//
#define ERR_ShowError	printf

//
// ������� ������ ��������������� ���������
//
void __cdecl ERR_Verbose(char* Format, ...);
void ERR_VerboseHex(DWORD Hex);
void ERR_VerboseDec(DWORD Dec);
void ERR_VerboseDone(void);
void ERR_VerboseFail(void);

#ifdef	__ERRORS_INTERNAL__			// ����������� ���������� ������� � ������
#endif
#endif	// __ERRORS_H__

