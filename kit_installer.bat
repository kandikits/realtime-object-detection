@echo off
REM This is a sample script
setlocal ENABLEDELAYEDEXPANSION
REM update below path if required
SET PY_LOCATION="C:\Python"
where /q python
IF ERRORLEVEL 1 (
    ECHO Python is not found in PATH variable
	curl -o python-3.9.8-amd64.exe https://www.python.org/ftp/python/3.9.8/python-3.9.8-amd64.exe
	python-3.9.8-amd64.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 TargetDir=%PY_LOCATION%
	ECHO Installing python3.9.8 ...
	ECHO Python installed in path : %PY_LOCATION%
	IF ERRORLEVEL 1 (
    		ECHO "There was an error while installing python!"
    		EXIT /B
	) ELSE (
		ECHO Installing dependent modules ...
		curl -o requirements.txt https://raw.githubusercontent.com/kandikits/realtime-object-detection/main/requirements.txt
		%PY_LOCATION%\python.exe -m pip install -r requirements.txt
	)
    EXIT /B
) ELSE (
	for /f %%i in ('python -c "import sys; print(sys.version_info[0])"') do set PYTHON_M_VERSION=%%i	
	ECHO !PYTHON_M_VERSION!
	IF !PYTHON_M_VERSION! EQU 2 (
		ECHO python3 will be installed since the version of existing python is 2
		curl -o python-3.9.8-amd64.exe https://www.python.org/ftp/python/3.9.8/python-3.9.8-amd64.exe
		python-3.9.8-amd64.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 TargetDir=%PY_LOCATION%
		ECHO Installing python3.9.8 ...
		ECHO Python installed in path : %PY_LOCATION%
		IF ERRORLEVEL 1 (
			ECHO There was an error while installing python!
			EXIT /B
		) ELSE (
			ECHO Installing dependent modules ...
			curl -o requirements.txt https://raw.githubusercontent.com/kandikits/realtime-object-detection/main/requirements.txt
			%PY_LOCATION%\python.exe -m pip install -r requirements.txt
		)

	) ELSE (
		IF !PYTHON_M_VERSION! EQU 3 (
			ECHO A valid python is detected and hence installing dependent modules ...
			curl -o requirements.txt https://raw.githubusercontent.com/kandikits/realtime-object-detection/main/requirements.txt
			python -m pip install -r requirements.txt
		) else (
			ECHO Python wasn't detected!
			curl -o python-3.9.8-amd64.exe https://www.python.org/ftp/python/3.9.8/python-3.9.8-amd64.exe
			python-3.9.8-amd64.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 TargetDir=%PY_LOCATION%
			ECHO Installing python3.9.8 ...
			ECHO Python installed in path : %PY_LOCATION%
			IF ERRORLEVEL 1 (
				ECHO There was an error while installing python!
				EXIT /B
			) ELSE (
				ECHO Installing dependent modules ...
				curl -o requirements.txt https://raw.githubusercontent.com/kandikits/realtime-object-detection/main/requirements.txt
				%PY_LOCATION%\python.exe -m pip install -r requirements.txt
			)
		)	
	)
)

curl -o realtime-object-detection.zip https://codeload.github.com/kandikits/realtime-object-detection/zip/refs/heads/main
