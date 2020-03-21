#include <stdio.h>
#include <stdlib.h>
#include <io.h>
#include <Windows.h>

void init();
void leak();
void bof();

int main(void)
{
	init();
	leak();
	bof();
	printf("too bad :(\n");
	return 0;
}

void init()
{
	if (setvbuf(stdin, NULL, _IONBF, 0) ||
		setvbuf(stdout, NULL, _IONBF, 0) ||
		setvbuf(stderr, NULL, _IONBF, 0))
	{
		printf("o shit\n");
		exit(EXIT_FAILURE);
	}
}

void leak()
{
	printf("kernel32.dll @ %p\n", GetModuleHandleA("kernel32.dll"));
}

void bof()
{
	char str[8];
	_read(0, str, 0x80);
}
