# BabyKernel

| Task             | BabyKernel                 |
|------------------|----------------------------|
| Competition      | [Dragon CTF 2019](https://ctftime.org/event/887)            |
| Location				 | Warsaw, Poland				 		  |
| Category         | Exploitation               |
| Platform         | Windows x64                |
| Scoring          | 460 pts (medium)           |
| Number of solves | 2 out of 14 teams          |

## Description

I think it's nice that Windows exploitation CTF tasks are gaining in popularity. Now it's time to promote Windows ring-0 security too, and what better chance for it than Dragon CTF 2019! Let's get you started with a baby kernel challenge :)

## Setup

During the CTF, the challenge was running on Windows Server 1809 x64. In order to load the `SecureDrv.sys` driver, disable the Driver Signature Enforcement mechanism from an elevated command prompt:

```
>bcdedit /set testsigning on
```

Then reboot the system, and register a service (again from an elevated prompt), e.g.:

```
>sc create SecureDrv binPath=C:\Users\test\Desktop\SecureDrv.sys type=kernel
```

and start it:

```
>sc start SecureDrv
```

Now you should be able to run `SecureClient.exe` and see the following output:

```
>SecureClient.exe
---===[ SecureStorage Client, Dragon CTF 2019 ]===---
[ ] Protect, unprotect?
```

If you wish to accurately model the CTF conditions, you can also configure Windows to automatically reboot on BSoD:

```
>wmic RecoverOS set AutoReboot = True
```

Then create a normal user called "ctf", and create a `C:\flag.txt` file with any access denied for that user. Now you're all set and ready to pwn!
