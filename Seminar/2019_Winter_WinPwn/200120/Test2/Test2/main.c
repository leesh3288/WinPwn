#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <string.h>

#define BUFSZ 10

void vuln(char *buf1, char *buf2, char *buf3)
{
	int choice;
	char local_buf[0x20];

	while (1)
	{
		scanf("%d", &choice);
		if (choice == 0)
			scanf("%s", local_buf);  // overflow!
		else if (choice == 1)
			strncpy(buf1, local_buf, BUFSZ);
		else if (choice == 2)
			strncpy(buf2, local_buf, BUFSZ);
		else if (choice == 3)
			strncpy(buf3, local_buf, BUFSZ);
		else
			break;
	}
}

int main()
{
	char buf1[BUFSZ], buf2[BUFSZ], buf3[BUFSZ];

	vuln(buf1, buf2, buf3);

	return 0;
}