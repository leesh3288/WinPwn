@echo off

set PORT=12345

..\..\..\Tools\appjaillauncher-rs\target\i686-pc-windows-msvc\debug\appjaillauncher-rs.exe run .\bartender_patched.exe -k .\flag -p %PORT%

pause