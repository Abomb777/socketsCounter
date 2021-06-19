@Echo off
netstat -n > temp-sockets-counter
Set _File=temp-sockets-counter



set Arr[0]=CLOSING
set Arr[1]=FIN_WAIT2
set Arr[2]=CLOSE_WAIT
set Arr[3]=FIN_WAIT1
set Arr[4]=LAST_ACK
set Arr[5]=SYN_RECV
set Arr[6]=ESTABLISHED
set Arr[7]=LISTEN
set Arr[8]=TIME_WAIT
set Arr[9]=SYN_SENT

set "x=0"

:SymLoop
if defined Arr[%x%] (
	rem call echo %%Arr[%x%]%%
	Set /a _Lines=0
	
	For /f %%j in ('Find "%%Arr[%x%]%%" /c ^< %_File%') Do (
	Set /a _Lines=%%j
	if %%j gtr 0 (
		call echo %%Arr[%x%]%% %%j)
	)
    set /a "x+=1"
    GOTO :SymLoop
)

Set /a _Lines=0

rem  /v -exclude
Set /a _Lines=0
For /f %%j in ('Find "TCP" /c ^< %_File%') Do Set /a _Lines=%%j

Echo %date% %time% Number of connections: %_Lines% 
del %_File%


@ECHO OFF
for /f "tokens=1-3 delims=:" %%i in ('netsh int ipv4 show dynamicport tcp') do (
	if "%%i"=="Start Port      " set /a STARTIPADDR=%%j
	if "%%i"=="Number of Ports " set /a NUMBERIPADDR=%%j
)
rem echo %STARTIPADDR%
rem echo %NUMBERIPADDR%

set /a "c=(%STARTIPADDR%-%NUMBERIPADDR%) /120"
echo Maximum sockets per sec %c%

set /a "used=%c%-%_Lines%"
echo Free sockets: %used%
