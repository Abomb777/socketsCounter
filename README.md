# socketsCounter
windows and linux count sockets states

## Windows
```bat

    netsh int ipv4 show dynamicport tcp
    netsh int ipv4 show dynamicport udp
    netsh int ipv6 show dynamicport tcp
    netsh int ipv6 show dynamicport udp
```

```bat
    netsh int ipv4 set dynamicport tcp start=10000 num=1000
    netsh int ipv4 set dynamicport udp start=10000 num=1000
    netsh int ipv6 set dynamicport tcp start=10000 num=1000
    netsh int ipv6 set dynamicport udp start=10000 num=1000
	
	>>>>
	netsh int ipv4 set dynamicport udp start=9000 num=56000
	netsh int ipv4 set dynamicport tcp start=9000 num=56000
```

```bat
; Set the TIME_WAIT delay to 30 seconds (0x1E)

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters]
"TcpTimedWaitDelay"=dword:0000001E
```

## Linux
```sh
	sysctl net.ipv4.ip_local_port_range
	sysctl net.ipv4.tcp_fin_timeout
```

## calulation
# sysctl net.ipv4.ip_local_port_range
net.ipv4.ip_local_port_range = 32768	60999
# sysctl net.ipv4.tcp_fin_timeout
net.ipv4.tcp_fin_timeout = 60


>> (60999 - 32768) / 120  = sockets per sec