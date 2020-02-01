#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include "CTFHelper.h"

#define TIMEOUT 120


size_t buf[1];


int main(void)
{
	int choice = -1;
	size_t idx = 0;

	CTF_IOInit();
	CTF_SetTimer(TIMEOUT);

	printf("Enter the world of Write-What-Where...\n");
	printf("1. Read\n");
	printf("2. Write\n");
	printf("Other. Exit\n");

	while (1)
	{
		printf("> ");
		scanf("%d", &choice);

		if (choice == 1)
		{
			printf("Index: ");
			scanf("%zd", &idx);
			printf("buf[%zd] = %zd\n", idx, buf[idx]);
		}
		else if (choice == 2)
		{
			printf("Index: ");
			scanf("%zd", &idx);
			printf("buf[%zd] = ", idx);
			scanf("%zd", &buf[idx]);
		}
		else
			break;
	}

	printf("Bye!\n");

	return 0;
}