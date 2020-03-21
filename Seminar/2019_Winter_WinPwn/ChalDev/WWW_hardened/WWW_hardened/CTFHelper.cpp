#define _CRT_SECURE_NO_WARNINGS

#include <Windows.h>
#include <iostream>
#include "CTFHelper.h"

#define _SECOND 10000000


static DWORD Timer(LPVOID seconds);
static void Timeout(LPVOID lpArg, DWORD dwTimerLow, DWORD dwTimerHigh);


void CTF_IOInit()
{
	if (setvbuf(stdin, NULL, _IONBF, 0) ||
		setvbuf(stdout, NULL, _IONBF, 0) ||
		setvbuf(stderr, NULL, _IONBF, 0))
	{
		ExitProcess(EXIT_FAILURE);
	}
}

void CTF_SetTimer(unsigned int seconds)
{
	HANDLE hTimerThread;

	// appease possible size difference warning between pointer-int cast
	hTimerThread = CreateThread(NULL, 0, Timer, (LPVOID)(UINT_PTR)seconds, 0, NULL);
	if (hTimerThread == NULL || !CloseHandle(hTimerThread))
		ExitProcess(EXIT_FAILURE);
}

static DWORD Timer(LPVOID seconds)
{
	HANDLE hTimer;
	LARGE_INTEGER timeLI;

	hTimer = CreateWaitableTimer(NULL, FALSE, NULL);
	if (hTimer == NULL)
		ExitProcess(EXIT_FAILURE);

	timeLI.QuadPart = -(LONGLONG)(UINT_PTR)seconds * _SECOND;
	if (SetWaitableTimer(hTimer, &timeLI, 0, Timeout, NULL, FALSE))
		while (1)
			SleepEx(INFINITE, TRUE);
	else
		ExitProcess(EXIT_FAILURE);

	// never reached
	return EXIT_FAILURE;
}

static void Timeout(LPVOID lpArg, DWORD dwTimerLow, DWORD dwTimerHigh)
{
	UNREFERENCED_PARAMETER(lpArg);
	UNREFERENCED_PARAMETER(dwTimerLow);
	UNREFERENCED_PARAMETER(dwTimerHigh);

	ExitProcess(EXIT_FAILURE);
}