@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
:menu
cls
echo "-----CountSort----"
echo "|  1 :  Dane     |"
echo "|  2 :  Backup   |"
echo "|  3 :  Raport   |"
echo "|  4 :  Autor    |"
echo "|  e :  Wyjscie  |"
echo "------------------"
:ask

set /p ans=Wybierz opcje? 
if %ans%==1 goto dane
if %ans%==2 goto backup
if %ans%==3 goto raport
if %ans%==4 goto author
if %ans%==q goto wyjscie
if not %ans%==1 goto menu
if not %ans%==2 goto menu
if not %ans%==3 goto menu
if not %ans%==4 goto author
if not %ans%==q goto menu
if not exist ./input (
  if not exist ./output(
    goto error
  )
)
if not exist CountSort.exe (
  goto error
)
if not exist raport.py (
  goto error
)


goto zapytanie

:author
echo Mateusz Lutecki 
echo Wydział Matematyki Stosowanej
echo Informatyka semestr III
pause
goto menu


:dane
echo ==========Generowanie raportu danych==========
FOR %%X IN (./input/*.txt) DO (
set "outname=%%X"
"CountSort.exe" ./input/%%X ./output/out!outname:~2!
)
pause
goto menu

:backup
echo ==========Tworzenie kopii zapasowej raportu==========
if not exist "./backup/raport[%DATE%][%TIME:~0,2%][%TIME:~3,2%].html" (
  cd ./raport
  xcopy "raport.html" "../backup/raport[%DATE%][%TIME:~0,2%][%TIME:~3,2%].html" /f /j /w /z /d
  echo  "Zapisano w lokalizacji ./backup/raport[%DATE%][%TIME:~0,2%][%TIME:~3,2%].html"
)


pause
goto menu

:raport
echo ==========Tworzenie raportu z danych==========
py raport.py
pause
goto menu

:error
echo --Error: brak jednego z kluczowych elementów systemu--
pause
exit

:wyjscie
exit