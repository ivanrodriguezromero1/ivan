@echo off
adb tcpip 5555
adb connect 192.168.1.3:5555
adb devices