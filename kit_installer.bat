@echo off
REM This is a sample script
setlocal ENABLEDELAYEDEXPANSION
REM update below path if required
SET PY_LOCATION="C:\Python"
SET PY_VERSION=3.9.8
SET PY_DOWNLOAD_URL=https://www.python.org/ftp/python/3.9.8/python-3.9.8-amd64.exe
where /q python
IF ERRORLEVEL 1 (
    ECHO Python wasn't found in PATH variable
	CALL :Install_python_and_modules
    EXIT /B
) ELSE (
	for /f %%i in ('python -c "import sys; print(sys.version_info[0])"') do set PYTHON_M_VERSION=%%i	
	ECHO !PYTHON_M_VERSION!
	IF !PYTHON_M_VERSION! EQU 2 (
		ECHO python3 will be installed since the version of existing python is 2
		CALL :Install_python_and_modules
	) ELSE (
		IF !PYTHON_M_VERSION! EQU 3 (
			ECHO A valid python is detected and hence installing dependent modules ...
			curl -o requirements.txt https://raw.githubusercontent.com/kandikits/realtime-object-detection/main/requirements.txt
			python -m pip install -r requirements.txt
		) else (
			ECHO Python wasn't detected!
			CALL :Install_python_and_modules
		)	
	)
)

curl -o realtime-object-detection.zip https://codeload.github.com/kandikits/realtime-object-detection/zip/refs/heads/main
ECHO Kit has been installed successfully
EXIT /B %ERRORLEVEL%

:Install_python_and_modules
ECHO Downloading python%PY_VERSION% ... 
curl -o python-%PY_VERSION%-amd64.exe %PY_DOWNLOAD_URL%
python-%PY_VERSION%-amd64.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 TargetDir=%PY_LOCATION%
ECHO Installing python%PY_VERSION% ...
ECHO Python installed in path : %PY_LOCATION%
IF ERRORLEVEL 1 (
		ECHO "There was an error while installing python!"
		EXIT /B
) ELSE (
	ECHO Installing dependent modules ...
	curl -o requirements.txt https://raw.githubusercontent.com/kandikits/realtime-object-detection/main/requirements.txt
	%PY_LOCATION%\python.exe -m pip install -r requirements.txt
)
EXIT /B 0

PAUSE
