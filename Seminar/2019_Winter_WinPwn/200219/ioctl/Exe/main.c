#include <stdio.h>
#include <string.h>
#include <Windows.h>
#include <lmcons.h>
#include <process.h>

#include "sioctl.h"


int main(void)
{
	char* src = "hello world!", dst[0x10];
	HANDLE drvHandle;
	DWORD bytesReturned, pcbBuffer;
	TCHAR lpBuffer[UNLEN + 1];

	printf("[*] Opening SIOCTL driver\n");
	drvHandle = CreateFileW(L"\\\\.\\IoctlTest", GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
	if (drvHandle == (HANDLE)-1)
	{
		printf("[-] Unable to access SIOCTL driver\n");
		return 1;
	}
	printf("[+] SIOCTL driver opened.\n");

	printf("1. Testing SIOCTL driver memcpy()\n");
	memset(dst, 0, 0x10);
	printf("[*] dst: %s\n", dst);
	printf("[*] IOCTL\n");
	if (!DeviceIoControl(drvHandle, IOCTL_SIOCTL_METHOD_NEITHER, src, (DWORD)(strlen(src) + 1), dst, sizeof(dst), &bytesReturned, NULL))
	{
		printf("[-] IOCTL failed\n");
		return 1;
	}
	printf("[+] dst: %s\n", dst);

	printf("2. Testing SIOCTL driver PrivEsc()\n");
	pcbBuffer = sizeof(lpBuffer) / sizeof(TCHAR);
	if (!GetUserName(lpBuffer, &pcbBuffer))
	{
		printf("[-] GetUserName failed...\n");
		return 1;
	}
	printf("[*] Current User: %ls\n", lpBuffer);
	if (!DeviceIoControl(drvHandle, IOCTL_PRIVESC, _getpid(), 1, NULL, 1, &bytesReturned, NULL))
	{
		printf("[-] IOCTL failed\n");
		return 1;
	}
	pcbBuffer = sizeof(lpBuffer) / sizeof(TCHAR);
	if (!GetUserName(lpBuffer, &pcbBuffer))
	{
		printf("[-] GetUserName failed...\n");
		return 1;
	}
	printf("[+] Current User: %ls\n", lpBuffer);

	return 0;
}