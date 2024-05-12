@echo off

REM Create putty shortcuts and put them into a directory
REM Change USER to your user
REM Change SERVER to your server
REM Change REMOTEPATH to your remote path

start "" "C:\Users\USER\ww\putty-shortcut.lnk"
ping -n 2 SERVER > nul
start "" "C:\Users\USER\ww\putty-shortcut.lnk"
ping -n 2 SERVER > nul
start "" "S:\REMOTEPATH\working"
ping -n 2 SERVER > nul
start "" "C:\Users\USER\ww\putty-shortcut.lnk"
ping -n 2 SERVER > nul
start "" "S:\REMOTEPATH\warc-chk"
