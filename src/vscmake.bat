@echo off

rem $Id: vscmake.bat,v 1.2 2005/03/08 18:18:33 stefano Exp $

cl
if %ERRORLEVEL% == 0 goto :build

goto :nocompiler

:build
cls

echo **************************
echo * Building with Visual C *
echo **************************
echo *
echo *
md ..\bin
cd appmake
call vscmake
cd ..
cd copt
call vscmake
cd ..
cd cpp
call vscmake
cd ..
cd sccz80
call vscmake
cd ..
cd z80asm
call vscmake
cd ..
cd zcc
call vscmake
cd ..
goto :end

:nocompiler
cls
echo *
echo * 'cl' not found
echo *
echo * Visual Studio is missing or environment isn't set correctly
echo * please use the "Visual Studio command prompt" shortcut 
echo * or execute vcvars32.bat
echo *

:end
