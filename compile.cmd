@ECHO OFF>nul

(
	TYPE meta.txt
	TYPE header.txt
	TYPE main.txt
	TYPE footer.txt
) > UserCSS.css

EXTENSION = .md
EXTENSION_VAR = markdown


PAUSE