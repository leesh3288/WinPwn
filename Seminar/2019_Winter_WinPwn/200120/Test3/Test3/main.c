#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>	
#include <Windows.h>

int filter(int exc)
{
	if (exc == EXCEPTION_INT_DIVIDE_BY_ZERO)
		return EXCEPTION_EXECUTE_HANDLER;
	return EXCEPTION_CONTINUE_SEARCH;
}

int main(void)
{
	int divide;

	printf("start\n");
	__try
	{
		printf("try\n");
		scanf("%d", &divide);
		divide = 1 / divide;
	}
	__except (filter(GetExceptionCode()))
	{
		printf("except (int div0)\n");
	}

	printf("out of try-except\n");

	return 0;
}