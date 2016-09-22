@echo off

REM usage: <regular> <bold> <italic> <bolditalic>
REM  all 4 params are paths of font files

set REGULAR=%~1
set BOLD=%~2
set ITALIC=%~3
set BOLDITALIC=%~4

if "%REGULAR%"=="" (
	echo Regular font path missing.
	GOTO END
)

if "%BOLD%"=="" (
	echo Bold font path missing.
	GOTO END
)

if "%ITALIC%"=="" (
	echo Italic font path missing.
	GOTO END
)

if "%BOLDITALIC%"=="" (
	echo Bold italic font path missing.
	GOTO END
)

cmd /c install_font sans regular "%REGULAR%"
echo ----------------------------------------------
cmd /c install_font sans bold "%BOLD%"
echo ----------------------------------------------
cmd /c install_font sans italic "%ITALIC%"
echo ----------------------------------------------
cmd /c install_font sans bolditalic "%BOLDITALIC%"
echo ----------------------------------------------

:END
	echo Finished