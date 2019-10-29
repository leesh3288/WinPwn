#include <stdio.h>
#include <stdlib.h>
#include <io.h>

void init();
void bof();
void backdoor();

int main(void)
{
	init();
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

void bof()
{
	char str[8];

	_read(0, str, 64);
	printf("%s\n", str);
	_read(0, str, 64);
}

void backdoor()
{
	system("C:\\Windows\\System32\\calc.exe");
	exit(EXIT_SUCCESS);
}