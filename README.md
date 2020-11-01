# WinPwn

My study logs on Windows pwnables, plus some hopefully helpful resources.

## References

These are the list of useful references I've checked out while studying Windows pwnable, dumped from my bookmarks. Note that some resources might be (heavily) outdated or partially mis-categorized.

### Intro
- [Intro to Windows Exploit Techniques for Linux PWNers](https://blog.pwnhub.cn/download/01/WinPWN.pdf)

### Shellcoding
- [Basics of Windows shellcode writing](https://idafchev.github.io/exploit/2017/09/26/writing_windows_shellcode.html)
- [Writing shellcodes for Windows x64](https://nytrosecurity.com/2019/06/30/writing-shellcodes-for-windows-x64/)

### Stack Exploits
- [Stack Based Buffer Overflows on x86 (Windows)](https://nytrosecurity.com/2017/12/09/stack-based-buffer-overflows-on-x86-windows-part-i/)
- [Stack Based Buffer Overflows on x64 (Windows)](https://nytrosecurity.com/2018/01/24/stack-based-buffer-overflows-on-x64-windows/)
- [Windows System Hacking Technique - Stack Exploit Tutorial](https://ruinick.tistory.com/79) (KR)

### SEH (Structured Exception Handler)
- [Structured Exception handler Exploitation](https://www.exploit-db.com/docs/english/17505-structured-exception-handler-exploitation.pdf)
- [Windows Exploit Development - Part 6: SEH Exploits](http://web.archive.org/web/20200324143130/https://www.securitysift.com/windows-exploit-development-part-6-seh-exploits/)
- [bartender - InCTF Internationals 2019](https://blog.bi0s.in/2019/10/11/Pwn/bartender/)
- [Exploit writing tutorial part 6 : Bypassing Stack Cookies, SafeSeh, SEHOP, HW DEP and ASLR](https://www.corelan.be/index.php/2009/09/21/exploit-writing-tutorial-part-6-bypassing-stack-cookies-safeseh-hw-dep-and-aslr/)
- [Exceptional Behavior - x64 Structured Exception Handling](https://www.osronline.com/article.cfm%5Earticle=469.htm)
- [Memory protection mechanisms in Windows](https://www.cnblogs.com/hyq20135317/p/6377880.html)
- [Dive into exceptions: caution, this may be hard](https://hackmag.com/uncategorized/exceptions-for-hardcore-users/)
- [Reversing Microsoft Visual C++ Part I: Exception Handling](http://www.openrce.org/articles/full_view/21)

### CFG (Control Flow Guard)
- [Bypassing Control Flow Guard in Windows 10](https://improsec.com/tech-blog/bypassing-control-flow-guard-in-windows-10)
- [Exploring Control Flow Guard in Windows 10](https://www.trendmicro.com/en_us/research/15/a/exploring-control-flow-guard-in-windows-10.html)
- [Windows 10 Control Flow Guard Internals](http://www.powerofcommunity.net/poc2014/mj0011.pdf)
- [Disarming Control Flow Guard Using Advanced Code Reuse Attacks](https://web.archive.org/web/20170522011815/https://www.endgame.com/blog/disarming-control-flow-guard-using-advanced-code-reuse-attacks)
- [Let’s talk about CFI: Microsoft Edition](https://blog.trailofbits.com/2016/12/27/lets-talk-about-cfi-microsoft-edition/)
- [CFG Improvements in Windows 10 Anniversary Update](https://www.trendmicro.com/en_us/research/16/j/control-flow-guard-improvements-windows-10-anniversary-update.html)

### Heap Exploits
TIP: If you want to work on LFH with debuggers, `set _NO_DEBUG_HEAP=1`
- [Windows 10 Nt Heap Exploitation (English version)](https://www.slideshare.net/AngelBoy1/windows-10-nt-heap-exploitation-english-version)
- [winhttpd writeup: private heaps pwning on Windows](https://blog.scrt.ch/2019/01/24/private-heaps-pwning-on-windows/)
- [Disclosing stack data (stack frames, GS cookies etc.) from the default heap on Windows](https://j00ru.vexillium.org/2016/07/disclosing-stack-data-from-the-default-heap-on-windows/)
- [Deterministic LFH](https://github.com/saaramar/Deterministic_LFH)
- Windows 10 Segment Heap Internals [presentation](https://www.blackhat.com/docs/us-16/materials/us-16-Yason-Windows-10-Segment-Heap-Internals.pdf) & [whitepaper](https://www.blackhat.com/docs/us-16/materials/us-16-Yason-Windows-10-Segment-Heap-Internals-wp.pdf)
- [Heap Overflow Exploitation on Windows 10 Explained](https://blog.rapid7.com/2019/06/12/heap-overflow-exploitation-on-windows-10-explained/)
- [Understanding the Low Fragmentation Heap](http://illmatics.com/Understanding_the_LFH.pdf)
- Windows 8 Heap Internals [presentation](https://media.blackhat.com/bh-us-12/Briefings/Valasek/BH_US_12_Valasek_Windows_8_Heap_Internals_Slides.pdf) & [whitepaper](http://illmatics.com/Windows%208%20Heap%20Internals.pdf)
- [Advanced Heap Manipulation in Windows 8](https://media.blackhat.com/eu-13/briefings/Liu/bh-eu-13-liu-advanced-heap-WP.pdf)
- [\[Writeup\] LazyFragmentationHeap - WCTF 2019](https://null2root.github.io/blog/2020/02/07/LazyFragmentationHeap-WCTF2019-writeup.html)
- [Low Fragmentation Heap (LFH) Exploitation - Windows 10 Userspace](https://github.com/peleghd/Windows-10-Exploitation/blob/master/Low_Fragmentation_Heap_(LFH)_Exploitation_-_Windows_10_Userspace_by_Saar_Amar.pdf)

### Kernel
- [Windows Kernel Shellcode on Windows 10 – Part 1](https://improsec.com/tech-blog/windows-kernel-shellcode-on-windows-10-part-1)
- [Windows Kernel Address Leaks](https://github.com/sam-b/windows_kernel_address_leaks)
- TAKING WINDOWS 10 KERNEL EXPLOITATION TO THE NEXT LEVEL – LEVERAING WRITE-WHAT-WHERE
VULNERABILITIES IN CREATORS UPDATE [presentation](https://www.blackhat.com/docs/us-17/wednesday/us-17-Schenk-Taking-Windows-10-Kernel-Exploitation-To-The-Next-Level%E2%80%93Leveraging-Write-What-Where-Vulnerabilities-In-Creators-Update.pdf) & [whitepaper](https://www.blackhat.com/docs/us-17/wednesday/us-17-Schenk-Taking-Windows-10-Kernel-Exploitation-To-The-Next-Level%E2%80%93Leveraging-Write-What-Where-Vulnerabilities-In-Creators-Update-wp.pdf)
- [Windows Kernel Debugging & Exploitation Part1 – Setting up the lab](https://voidsec.com/windows-kernel-debugging-exploitation/)
- [\[Kernel Exploitation\] 4: Stack Buffer Overflow (SMEP Bypass)](https://www.abatchy.com/2018/01/kernel-exploitation-4)
- [A Deep Dive Analysis of Microsoft’s Kernel Virtual Address Shadow Feature](https://www.fortinet.com/blog/threat-research/a-deep-dive-analysis-of-microsoft-s-kernel-virtual-address-shadow-feature)
- [When Kernel Debugging - Find The Page Protection of a User Mode Address](https://stackoverflow.com/questions/16749764/when-kernel-debugging-find-the-page-protection-of-a-user-mode-address)
- [HITCON CTF 2019 Breath of Shadow](https://github.com/scwuaptx/CTF/tree/master/2019-writeup/hitcon/breathofshadow/challenge)
- [windows_kernel_resources](https://github.com/sam-b/windows_kernel_resources)
- [Kernel Exploitation -> RS2 Bitmap Necromancy](https://www.fuzzysecurity.com/tutorials/expDev/22.html)
- [A Tale Of Bitmaps: Leaking GDI Objects Post Windows 10 Anniversary Edition](https://labs.f-secure.com/archive/a-tale-of-bitmaps/)
- [NT Diff](https://ntdiff.github.io/)
- [Exploit Development: Leveraging Page Table Entries for Windows Kernel Exploitation](https://connormcgarr.github.io/pte-overwrites/)

### NTAPI, Syscalls, Undocumented etc.
- [NTAPI Undocumented Functions](https://undocumented.ntinternals.net/)
- [processhacker/ntpsapi.h](https://github.com/processhacker/processhacker/blob/master/phnt/include/ntpsapi.h)
- [Windows System Call Tables](https://github.com/j00ru/windows-syscalls)
- [An Analysis of Address Space Layout Randomization on Windows Vista™](https://web.archive.org/web/20190715102700/https://www.symantec.com/avcenter/reference/Address_Space_Layout_Randomization.pdf)
- [Undocumented 32-bit PEB and TEB Structures](http://bytepointer.com/resources/tebpeb32.htm)
- [Vergilius Project](https://www.vergiliusproject.com/)
- [Winbindex - The Windows Binaries Index](https://winbindex.m417z.com/)

### CTF Chals
- [j00ru/ctf-tasks](https://github.com/j00ru/ctf-tasks)
- [Awesome Windows CTF](https://zaratec.github.io/2019/09/19/awesome-windows-ctf/)
- [WCTF 2019 LazyFragmentationHeap](https://github.com/scwuaptx/LazyFragmentationHeap)
- [Hack.lu CTF 2020 LowFunHeap](https://ctftime.org/task/13503)
- CODEGATE 2020 CTF [winterpreter](https://github.com/leesh3288/CTF/tree/master/2020/CODEGATE_2020_Preliminary/winterpreter) & [winsanity](https://github.com/leesh3288/CTF/tree/master/2020/CODEGATE_2020_Finals/winsanity) 😉

### Tools
TODO, will update after campus power outage is over :(

### (Automated) Deployment
- [Running Windows Server 2k16 with Docker under Linux, KVM or Virtualbox](https://gist.github.com/mustafaakin/0cfbc1b4bb346a05a615)
- [Building the perfect Windows Server 2016 reference image](https://deploymentresearch.com/building-the-perfect-windows-server-2016-reference-image/)
- [Answer files (unattend.xml)](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs)
- [Creating an Offline MDT Deployment Media](https://www.vkernel.ro/blog/creating-an-offline-mdt-deployment-media)
- [TechBench by WZT](https://tb.rg-adguard.net/public.php)
- [UUP dump](https://uupdump.ml/)
- [UUP Generation Project](https://uup.rg-adguard.net/)
