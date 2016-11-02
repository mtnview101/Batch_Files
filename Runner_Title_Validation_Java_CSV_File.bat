@ECHO OFF
::========================================
SET GITHUB_ACCOUNT=mtnview101
SET WS_DIR=Workspace
SET REPO_NAME=Title_Validation_Java_CSV_File 
SET APP_VERSION=1.104
SET MAIN_CLASS=core.HtmlUnit
SET ARGS_01=
::========================================

::========================================
::SET GITHUB_ACCOUNT=%1
::SET WS_DIR=%2
::SET REPO_NAME=%3
::SET APP_VERSION=%4
::SET MAIN_CLASS=%5
::SET ARGS_01=%6
::========================================

IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1 
:: nul 2>&1 This says to pipe the standard-error stream to the same place as the standard-output stream => nul
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed

GOTO NEXT

:NEXT
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST C:\%WS_DIR%\%REPO_NAME% RMDIR /S /Q C:\%WS_DIR%\%REPO_NAME%
CD C:\%WS_DIR%
git clone https://github.com/mtnview101/Title_Validation_Java_CSV_File.git
::git clone https://github.com/%GITHUB_ACCOUNT%/%REPO_NAME%.git
CD %REPO_NAME%
timeout 2
CALL mvn package -Dbuild.version="%APP_VERSION%"
ECHO.
ECHO Executing Java programm ...
:: java -cp C:\%WS_DIR%\%REPO_NAME%\target\%REPO_NAME%-%APP_VERSION%.jar %MAIN_CLASS% %ARG_01%
:: java -jar C:\%WS_DIR%\%REPO_NAME%\target\%REPO_NAME%-%APP_VERSION%-jar-with-dependencies.jar
java -jar C:\Workspace\Title_Validation_Java_CSV_File\target\Title_Validation_Java_CSV_File-1.104-jar-with-dependencies.jar
GOTO END

:EXIT_JAVA
ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END
:NO_WORKSPACE
ECHO %WS_DIR% is not exists
GOTO END
:END
CD c:\batch_files