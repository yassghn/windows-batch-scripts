@echo off
setlocal enabledelayedexpansion

rem
rem mdn-canvas-tutorial neocities release
rem   - convert mjs files to js
rem   - rename mjs imports to js
rem
rem usage: mct-neocities-release.bat .\mdn-canvas-tutorial\dist\js\
rem        (needs "\" at the end)

echo:
echo -------------------------------------
echo mdn-canvas-tutorial neocities release
echo -------------------------------------
echo:

rem check argument was provided
if "%~1" == "" (
	echo error: missing directory param
	goto end
)

rem todo better directory checking, needs \ at the end

rem get dispath from command args as absolute path
set distPath=%~dp1

rem set vars
set mjsExt=.mjs
set jsExt=.js

rem echo
echo using path: %distPath%
echo:

rem recursively iterate files
echo iterating files...
echo:

for /R %distPath% %%f in (*%jsExt%, *%mjsExt%) do (
	rem print file info
	echo %%~nxf
	echo drive: %%~df
	echo dir: %%~pf
	echo ext: %%~xf

	rem check if file is mjs file
	if %%~xf == !mjsExt! (
		rem change file extension
		echo renaming file to %%~nf!jsExt!
		ren %%f %%~nf!jsExt!
	)
	rem replace text in file
	echo replacing mjs extension in imports
	set file=%%~dpnf!jsExt!
	powershell -Command "(gc !file!) -replace '!mjsExt!', '!jsExt!' | Out-File -encoding ASCII !file!"

	rem print spacer
	echo -----------------------------
)

echo:
echo done

:end
endlocal
echo:
pause
exit 0