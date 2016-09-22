@echo off

REM make sure to back up /system/fonts directory before running this script
REM
REM usage: <batch-file> <type> <style> <fontpath>
REM  type: sans/serif/mono
REM  style: regular/italic/bold/bolditalic
REM  fontpath: path of font file
REM

setlocal enabledelayedexpansion

set TYPE=%~1
set STYLE=%~2
set FONTPATH=%~3
set FILES=

if "%TYPE%"=="" (
	echo Font type missing. See usage.
	GOTO END
)

if "%STYLE%"=="" (
	echo Font style missing. See usage.
	GOTO END
)

if "%FONTPATH%"=="" (
	echo Font path missing. See usage.
	GOTO END
)

if "%TYPE%"=="sans" (
	if "%STYLE%"=="regular" (
		echo Sans Regular
		set FILES=Roboto-Thin.ttf Roboto-Light.ttf Roboto-Regular.ttf Roboto-Medium.ttf RobotoCondensed-Light.ttf RobotoCondensed-Regular.ttf
		GOTO PERFORM
	)
	
	if "%STYLE%"=="italic" (
		echo Sans Italic
		set FILES=Roboto-ThinItalic.ttf Roboto-LightItalic.ttf Roboto-Italic.ttf Roboto-MediumItalic.ttf RobotoCondensed-LightItalic.ttf RobotoCondensed-Italic.ttf
		GOTO PERFORM
	)
	
	if "%STYLE%"=="bold" (
		echo Sans Bold
		set FILES=Roboto-Black.ttf Roboto-Bold.ttf RobotoCondensed-Bold.ttf
		GOTO PERFORM
	)
	
	if "%STYLE%"=="bolditalic" (
		echo Sans Bold Italic
		set FILES=Roboto-BlackItalic.ttf Roboto-BoldItalic.ttf RobotoCondensed-BoldItalic.ttf
		GOTO PERFORM
	)
)

if "%TYPE%"=="serif" (
	if "%STYLE%"=="regular" (
		echo Serif Regular
		set FILES=NotoSerif-Regular.ttf
		GOTO PERFORM
	)
	
	if "%STYLE%"=="italic" (
		echo Serif Italic
		set FILES=NotoSerif-Italic.ttf
		GOTO PERFORM
	)
	
	if "%STYLE%"=="bold" (
		echo Serif Bold
		set FILES=NotoSerif-Bold.ttf
		GOTO PERFORM
	)
	
	if "%STYLE%"=="bolditalic" (
		echo Serif Bold Italic
		set FILES=NotoSerif-BoldItalic.ttf
		GOTO PERFORM
	)
)

if "%TYPE%"=="mono" (
	if "%STYLE%"=="regular" (
		echo Monospace Regular
		set FILES=DroidSansMono.ttf
		GOTO PERFORM
	)
	
	if "%STYLE%"=="italic" (
		echo Monospace Italic
		echo No font to replace
		GOTO END
	)
	
	if "%STYLE%"=="bold" (
		echo Monospace Bold
		echo No font to replace
		GOTO END
	)
	
	if "%STYLE%"=="bolditalic" (
		echo Monospace Bold Italic
		echo No font to replace
		GOTO END
	)
)

GOTO END

:PERFORM
	echo Remounting system as read-write...
	adb shell su -c 'mount -o rw,remount /system'
	
	set PUSH=/storage/sdcard0/font.tmp
	echo Pushing font to device at location '%PUSH%'...
	adb push "%FONTPATH%" %PUSH%
	
	for %%F in (!FILES!) do (
		set SRC=/system/fonts/%%F
		echo Replacing font '!SRC!'...
		adb shell su -c 'cp %PUSH% !SRC!'
	)
	
	echo Remounting system as read-only...
	adb shell su -c 'mount -o ro,remount /system'
	
	echo Reboot device to apply.
		
:END
	echo Finished