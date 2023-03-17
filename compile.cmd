@ECHO OFF>NUL
PUSHD %~dp0
SETLOCAL EnableDelayedExpansion

ECHO WARNING: this script will rewrite "\UserCSS.css".
ECHO ("%cd%\UserCSS.css")
:choice
SET /p "choice=Do you want to continue [Y,N]? "
IF /I "%choice%" == "N" (EXIT /B)
IF /I NOT "%choice%" == "Y" (
IF /I NOT "%choice%" == "N" (GOTO choice)
)
ECHO.

ECHO Creating "\data\UserCSS-temp.css"...
TYPE "%cd%\data\header.txt" > "%cd%\data\UserCSS-temp.css"
FOR /F "usebackq skip=1 tokens=1,2,3 delims=;" %%A IN ("%cd%\data\filenames.txt") DO (
	FOR /F "usebackq delims=" %%j IN (`TYPE "%cd%\data\selectors.css"`) DO (
		SET string=%%j
		SET string=!string:$filename$=%%A!
		IF "%%B" == "file" 		(SET string=!string:$type$=File!)
		IF "%%B" == "filemask" 	(SET string=!string:$type$=File!)
		IF "%%B" == "dir" 		(SET string=!string:$type$=Directory!)
		SET string=!string:$CSS_var$=%%C!
		ECHO !string!>> "%cd%\data\UserCSS-temp.css"
	)
	ECHO.>> "%cd%\data\UserCSS-temp.css"
)
TYPE "%cd%\data\footer.txt" >> "%cd%\data\UserCSS-temp.css"

ECHO Moving "\data\UserCSS-temp.css" to "\UserCSS.css"...
MOVE "%cd%\data\UserCSS-temp.css" "%cd%\UserCSS.css"
ENDLOCAL
POPD
ECHO Done!
EXIT /B