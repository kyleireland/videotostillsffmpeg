@echo off
setlocal enabledelayedexpansion

echo WARNING: This script will extract photographs from video files in the current folder.
echo The images will be saved in a folder named after the video file.
echo.
echo Change "fps=1" to 0.5 if you want less images or higher number for more images.
echo Change -q:v 2 if you want different quality. Normal range for JPEG is 2-31 with 31 being the worst quality.
echo.
echo Please type "OK" and press Enter to continue, or press Enter to cancel.

set /p userInput=Input: 

if /i "!userInput!" neq "OK" (
    echo Cancelled.
    exit /b
)

where /Q ffmpeg.exe
if %ERRORLEVEL% neq 0 (
    echo "FFmpeg not found."
    pause
    exit /b
)

for %%f in (*.mp4 *.avi *.mkv *.mov *.flv *.wmv) do (
    set "filename=%%~nf"
    
    set "output_folder=!filename!_output"
    mkdir "!output_folder!"
    
    ffmpeg -i "%%f" -vf "fps=1" -q:v 2 "!output_folder!\image_%%03d.jpg"
    
    echo Stills extracted to "!output_folder!"
)

echo Script finished.
pause
