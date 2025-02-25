@ECHO OFF
SETLOCAL EnableDelayedExpansion

REM update firefox nightly
REM usage: update-firefox-nightly.bat distFilePath updateDir

ECHO:
ECHO update firefox nightly
ECHO:

SET distZipPath=%~dpnx1
SET updateDir=%~dpn2

REM check if distZipPath/updateDir was passed
REM if not passed, prompt user for paths

IF NOT DEFINED distZipPath (
    ECHO provide dist zip file path
    SET /P distZipPath="distZipPath: "
)
IF NOT DEFINED updateDir (
    ECHO provide update dir
    set /P updateDir="updateDir: "
)

ECHO:
ECHO using distZipPath: %distZipPath%
ECHO using updateDir: %updateDir%

REM check if zipfile exists

SET zipFile=

IF EXIST %distZipPath% (
    REM get zip file from path
    FOR /F %%i in ("%distZipPath%") DO SET zipFile=%%~nxi
) ELSE (
    REM error exit
    ECHO:
    ECHO ERROR: bad path for dist zip file
    GOTO :end
)

ECHO using zipFile: %zipFile%
ECHO:

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

IF EXIST %updateDir%\%zipFile% (
    REM checkfor existing backup

    SET backupFile=%updateDir%\backup-%zipFile%

    IF EXIST !backupFile! (
        REM delete existing backup

        ECHO deleting existing backupfile: !backupFile!
        ECHO:
        DEL !backupFile!
    )

    REM backup existing zip

    ECHO backing up existing zip to: !backupFile!
    MOVE %updateDir%\%zipFile% !backupFile!
)

REM copy new zip

ECHO copying dist zip file
ECHO:

COPY %distZipPath% %updateDir%

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

call TAR -xf %updateDir%\%zipFile% -C %updateDir%

ECHO done.

REM end

:end
ENDLOCAL
ECHO:
pause