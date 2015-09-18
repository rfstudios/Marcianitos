@echo off
if exist c:\devBennu\bin\stderr.txt  del c:\devBennu\bin\stderr.txt
if exist c:\devBennu\bin\stdout.txt  del c:\devBennu\bin\stdout.txt
if exist %2.dcb    del %2.dcb
pushd  %3 
c:\devBennu\bin\bgdc.exe -s bgdi -Ca -a %1 






pause 
