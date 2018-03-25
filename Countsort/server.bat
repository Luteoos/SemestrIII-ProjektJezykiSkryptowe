@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
:menu
cls


echo  -----CountSort----
echo "|  1 :  Dane     |"
echo "|  2 :  Backup   |"
echo "|  3 :  Raport   |"
echo "|  4 :  Autor    |"
echo "|  e :  Wyjscie  |"
echo  ------------------
:ask



set /p ans=Wybierz opcje? 
if %ans%==1 goto dane
if %ans%==2 goto backup
if %ans%==3 goto raport
if %ans%==4 goto author
if %ans%==e goto wyjscie
if not %ans%==1 goto menu
if not %ans%==2 goto menu
if not %ans%==3 goto menu
if not %ans%==4 goto author
if not %ans%==e goto menu



:author
echo Mateusz Lutecki 
echo Wydzial Matematyki Stosowanej
echo Informatyka semestr III
pause
goto menu


:dane
echo -------Generowanie danych-------
FOR %%X IN (./input/*.txt) DO (
CountSort.exe ./input/%%X ./output/%%X_out[%DATE%].txt
)
pause
goto menu

:backup
echo -------Tworzenie kopii zapasowej raportu-------
if not exist "./backup/raport[%DATE%][%TIME:~0,2%][%TIME:~3,2%].html" (
  cd ./raport
  xcopy "raport.html" "../backup/raport[%DATE%][%TIME:~0,2%][%TIME:~3,2%].html" /f /j /w /z /d
)


pause
goto menu

:raport
echo -------Tworzenie raportu z danych-------
py raport.py
pause
goto menu

:error
echo --Error: brak jednego z kluczowych elementów systemu--
pause
exit

:wyjscie
exit