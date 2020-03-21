# 2019 WinPwn Seminar Preparation / Environment Setup

## Environment
- (**Required**) VMware or VirtualBox + Windows 10 x64

## Compiler
- (**Required**) [Visual Studio 2017 or above](https://visualstudio.microsoft.com/) (for Visual C++ Compiler & Runtime Libraries)

## Assember
- (**Required**) Any Windows assembler (MASM included in VS, I use [FASM](https://flatassembler.net/download.php))
- (Recommended) [WinREPL](https://github.com/zerosum0x0/WinREPL)

## Debugger
- (**Required**) [WinDbg](https://docs.microsoft.com/ko-kr/windows-hardware/drivers/debugger/debugger-download-tools) (Kernel/User-mode debugging)
- (Recommended) [x64dbg](https://x64dbg.com) (More user-friendly user-mode debugging)
- (Optional) [ollydbg](http://www.ollydbg.de) (plugin-rich, but I hardly use it + somewhat defunct)

## Tools
- (**Required**) [Python2](https://www.python.org/downloads/) (or if you really like Python3, good luck porting and installing below modules)
    - (**Required**) [pwintools](https://github.com/leesh3288/pwintools) module (Windows version of pwntools)

        ```
        git clone https://github.com/leesh3288/pwintools.git
        cd pwintools
        python setup.py install
        ```

- (**Required**) IDA
- (**Required**) [winchecksec](https://github.com/trailofbits/winchecksec) (checksec for Windows)
- (Recommended) [Windows Sysinternals Suite](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite) (The Windows Swiss Army Knife)
- (Recommended) [Appjaillauncher-rs](https://github.com/trailofbits/appjaillauncher-rs) (xinetd for Windows + sandbox)
- (Recommended) [CPUID](https://github.com/tycho/cpuid) (Windows equivalent of "cat /proc/cpuinfo")
- (Optional) PEview

----------------

**Required**: You really would want to have these set up. We'll frequently use these, and I'll assume that everyone has it.

Recommended: You'll probably be better off having these. These are not strictly necessary, but it's better to have it set up unless you have reasons not to do so.

Optional: These are literally optional, if you're already familiar with those then feel free to use it. Otherwise, you don't have to bother with it.
