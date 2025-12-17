@shift /0
@shift /0
@shift /0
@echo off

if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b


for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

title  @TOBIL SHINODA
chcp 65001
color B
mode 103,5
set counter=0
set counterb=000
set core=████████████████████████████████████████████████████████████████████████████████████████████████████
set "valuecore=                                                                                                    "
setLocal EnableDelayedExpansion
:start
cls
echo.╔════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo.║%valuecore:~0,100%║
echo.╚════════════════════════════════════════════════════════════════════════════════════════════════════╝
if %counter% GEQ 100 set msg=complete& set counterb=10000& goto exit
echo. %counterb:~0,-2%%%
set /a counter=counter+1
set /a counterb=counterb+100
set "valuecore=!core:~0,%counter%!                                                                                                    "
set delay=0
:delay
if %delay%==15 goto start
set /a delay=delay+1
goto delay
:exit
echo. %counterb:~0,-2%%% %msg%    
goto:bitch
@echo off
title TOBIL SHINODA  

::Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

:bitch
@echo off
set col= 
title TOBIL SHINODA 
chcp 65001
mode con:cols=120 lines=30

echo. %col%
echo. %col%
echo. %col%  ████████╗░█████╗░██████╗░██╗██╗░░░░░ 
echo. %col%  ╚══██╔══╝██╔══██╗██╔══██╗██║██║░░░░░ 
echo. %col%  ░░░██║░░░██║░░██║██████╦╝██║██║░░░░░ 
echo. %col%  ░░░██║░░░██║░░██║██╔══██╗██║██║░░░░░ 
echo. %col%  ░░░██║░░░╚█████╔╝██████╦╝██║███████╗ 
echo. %col%  ░░░╚═╝░░░░╚════╝░╚═════╝░╚═╝╚══════╝ 
echo. 
echo.                                             
echo.        %col%[96mCLEAN LOG RUN / %col%[97mLOG OPEN FILE
echo.                                                                                                                      
@pause
Del /F /Q %APPDATA%\Microsoft\Windows\Recent\*

Del /F /Q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*

Del /F /Q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*

REG Delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /VA /F

REG Delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths /VA /F 

rundll32 InetCpl.cpl,ClearMyTracksByProcess 1
