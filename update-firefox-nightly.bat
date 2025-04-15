@ECHO OFF
SETLOCAL EnableDelayedExpansion

REM update firefox nightly
REM usage: update-firefox-nightly.bat distFilePath updateDir

ECHO:
ECHO update firefox nightly
ECHO:

SET distPath=C:\Users\borys\dev\mozilla\mozilla-source\mozilla-unified\obj-x86_64-pc-windows-msvc\dist
SET packageNameFile=package_name.txt
SET updateDir=C:\Users\borys\AppData\Local\Programs\mozilla
SET distZip=

REM get package name from file

FOR /F "delims=" %%i in (%distPath%\%packageNameFile%) do (
    SET distZip=%%~nxi
)

ECHO:
ECHO using distPath: %distPath%
ECHO using updateDir: %updateDir%

REM check if zipfile exists

SET zipFile=%distPath%\%distZip%

IF EXIST %zipFile% (
    REM zip file exists
    ECHO using zipFile: %zipFile%
    ECHO:
) ELSE (
    REM error exit
    ECHO:
    ECHO ERROR: bad path for dist zip file
    GOTO :end
)

REM check if update dir exists

IF EXIST %updateDir%\NUL (
    ECHO updating firefox nightly...
    ECHO:
) ELSE (
    REM error exit
    ECHO:
    ECHO ERROR: bad path for update dir
    GOTO :end
)

REM check for existing zip

IF EXIST %updateDir%\%distZip% (
    REM checkfor existing backup

    SET backupFile=%updateDir%\backup-%distZip%

    IF EXIST !backupFile! (
        REM delete existing backup

        ECHO deleting existing backupfile: !backupFile!
        ECHO:
        DEL !backupFile!
    )

    REM backup existing zip

    ECHO backing up existing zip to: !backupFile!
    MOVE %updateDir%\%distZip% !backupFile!
)

REM copy new zip

ECHO copying dist zip file
ECHO:

COPY %zipFile% %updateDir%

REM check for existing firefox folder

SET ffFolder=%updateDir%\firefox

IF EXIST %ffFolder%\NUL (
    REM delete exist firefox folder

    ECHO deleting existing firefox folder
    RD /S /Q %ffFolder% || GOTO :end
)

REM unzip new zip

ECHO extracting firefox nightly
ECHO:

call TAR -xf %updateDir%\%distZip% -C %updateDir%

ECHO done.

REM end

:end
ENDLOCAL
ECHO:
pause
