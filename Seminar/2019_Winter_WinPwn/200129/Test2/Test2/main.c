#include <stdio.h>
#include <Windows.h>

inline uintptr_t __ROR8__(uintptr_t val, int rot) {
	return (val >> rot) | (val << (0x40 - rot));
}

inline void *_encode_pointer(void *ptr) {
	return (void*)__ROR8__((uintptr_t)ptr ^ __security_cookie, __security_cookie & 0x3f);
}

inline void *_decode_pointer(void *ptr) {
	return (void*)(__ROR8__((uintptr_t)ptr, 0x40 - (__security_cookie & 0x3f)) ^ __security_cookie);
}

int main(void)
{
	void *encoded;
	printf("main:                  %p\n", main);
	printf("_encode_pointer(main): %p\n", encoded = _encode_pointer(main));
	printf("__security_cookie:     %016llX\n", __security_cookie);
	
	printf("Try __security_cookie leak with main & _encode_pointer(main)\n");
	for (int i = 0; i < 0x40; i++)
	{
		uintptr_t cand = (uintptr_t)__ROR8__((uintptr_t)encoded, 0x40 - i) ^ (uintptr_t)main;
		if ((cand >> 0x30) == 0 && ((cand ^ i) & 0x3f) == 0)
			printf("__security_cookie:     %016llX\n", cand);
	}

	return 0;
}