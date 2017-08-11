:: don't display commands from this script in terminal
@echo off

:: make sure that we are running script as admin
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
  ECHO Error: You need to run this script as ADMIN.
  pause
  exit /b	
)

:: move to pni-platform folder
for %%* in (.) do set CurrDirName=%%~nx*
if %CurrDirName% neq pni-platform (
  ECHO Error: something is wrong with the script. Current folder should be pni-platform but was %CurrDirName%
  pause
  exit /b	
)
SET "platformPath=%cd%"

:: make sure that there is a pni-platform\phoenix folder, otherwise it means that script has been executed already and we should stop execution
if exist phoenix (
  echo pni-platform\phoenix folder already exists. Script aborted.
  pause
  exit /b
)

:: install chocolatey
powershell -noProfile -executionPolicy bypass -command "& {iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex }"
SET PATH=%PATH%;C:\ProgramData\chocolatey\bin

:: install git
choco install git -y
SET PATH=%PATH%;C:\Program Files\Git\cmd

:: clone phoenix repository and switch to develop branch
git clone https://pnimedia.visualstudio.com/Phoenix/_git/PHX phoenix --branch develop

:: call rest of the script from a private repository
call phoenix\Build\setup-environment.bat

:: delete this script, as we have it now in a build folder
(goto) 2>nul & del "%~f0"
