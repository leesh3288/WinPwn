#include <stdio.h>

typedef int(*callback)(int, int);
int foldLeft(int *arr, int sz, int acc, callback fn)
{
	if (sz <= 0)
		return acc;
	return foldLeft(arr + 1, sz - 1, fn(*arr, acc), fn);
}

int add(int rhs, int lhs)
{
	return rhs + lhs;
}

int main(void)
{
	int arr[] = { 2, 3, 1, 4, 5 };
	printf("%d\n", foldLeft(arr, sizeof(arr) / sizeof(int), -5, add));
	return 0;
}