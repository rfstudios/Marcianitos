@echo off
if exist c:\devBennu\bin\stderr.txt  del c:\devBennu\bin\stderr.txt
if exist c:\devBennu\bin\stdout.txt  del c:\devBennu\bin\stdout.txt
if exist %2.dcb    del %2.dcb
pushd  %3 
c:\devBennu\bin\bgdc.exe -g -d %1
if exist c:\devBennu\bin\stdout.txt   type c:\devBennu\bin\stdout.txt
if exist c:\devBennu\bin\stderr.txt   type c:\devBennu\bin\stderr.txt
if exist c:\devBennu\bin\stderr.txt   goto salida
c:\devBennu\bin\bgdi.exe -d %2
if exist c:\devBennu\bin\stderr.txt  type c:\devBennu\bin\stderr.txt
:salida
pause 
