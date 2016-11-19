@echo off
set regpath="HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
set reglist=ProxyEnable\reg_dword
for /f "skip=2 tokens=3" %%i in ('reg query %regpath% /v ProxyEnable') do (
  if /i "%%i"=="0x1" (
      call :add "0"
      call :end
    ) else (
      call :add "1"
      call :end      
   )
)
pause>nul&exit

:add   
for /f "tokens=1-2 delims=\" %%b in ("%reglist%") do (
   reg add %regpath% /v %%b /t %%c /d %~1 /f>nul   
) 
goto :eof

:end
for /f "skip=2 tokens=3" %%a in ('reg query %regpath% /v ProxyEnable') do (
   if /i "%%a"=="0x1" (
      echo 代理服务器已经打开
    ) else (
      echo 代理服务器已经关闭
    )
)
goto :eof
