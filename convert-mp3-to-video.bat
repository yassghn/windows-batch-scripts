@echo off

REM convert mp3 to video
REM usage: convert-mp3-to-video.bat mp3_directory image_file

ECHO convert mp3 to video

REM check if param 1 is empty

IF "%~1" == "" (
  ECHO missing directory parameter
  GOTO end
)

REM todo: check if param 1 is directory

REM check if param 2 is empty
IF "%~2" == "" (
  ECHO missing image parameter
  GOTO end
)

REM todo: check if param 2 is an image
REM todo: check system for ffmpeg presence

ECHO ...
ECHO using directory: %~dp1
ECHO using image: %~dpnx2
ECHO ...

FOR %%F IN ("%~dp1""*.mp3") do (
  ECHO converting: %%F
  ffmpeg -loop 1 -i "%~dpnx2" -i "%%~dpnxF" -c:a copy -c:v libx264 -shortest "%%~dpnF.mp4"
)

ECHO done.

:end
PAUSE

