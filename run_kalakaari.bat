@echo off
cd /d "C:\Users\bapat\OneDrive\Desktop\Kalakaari"
echo Cleaning and rebuilding Kalakaari...
call flutter clean
timeout /t 2 /nobreak >nul
call flutter build web
echo Starting web server...
cd build\web
call npx serve -s . -p 57567