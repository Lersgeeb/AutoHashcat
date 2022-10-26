@ECHO OFF

set /p HASH_TYPE="Enter hash type (-m): "
set HASHCAT_BIN=.\hashcat64.exe
set HASHES_FILE=%1
set /p JOBNAME="Enter a name for this job: "
set POTFILE=".\potfiles\AutoHashcat_POTFILE_"%JOBNAME%
set WORDLIST_DIRECTORY=.\wordlists\
set RULES_DIRECTORY=.\custom_rules\
set RULES2USE_FILE=.\inputs\rules2use.txt
set MASKS_DIRECTORY=.\custom_masks\
set MASKS2USE_FILE=.\inputs\masks2use.txt

(for %%a in (%WORDLIST_DIRECTORY%*) do (
    if not %%a == .\wordlists\README.md (
        (for /F "tokens=*" %%b in (%RULES2USE_FILE%) do (
            START "AutoHashcat - WORDLIST %%a RULE %%b" /W %HASHCAT_BIN% -a 0 -m %HASH_TYPE% -w4 -r %RULES_DIRECTORY%%%b %HASHES_FILE% %%a -O --potfile-path %POTFILE%.pot
        )) 
    )
))

(for /F "tokens=*" %%a in (%MASKS2USE_FILE%) do (
    START "AutoHashcat - MASK_LIST %%a" /W %HASHCAT_BIN% -a 3 -m %HASH_TYPE% -w4 %HASHES_FILE% %MASKS_DIRECTORY%%%a -O --potfile-path %POTFILE%.pot
)) 

(for %%a in (%WORDLIST_DIRECTORY%*) do (
    if not %%a == .\wordlists\README.md (
        (for /F "tokens=*" %%b in (%MASKS2USE_FILE%) do (
            START "AutoHashcat - WORDLIST %%a -> MASK_LIST %%b" /W %HASHCAT_BIN% -a 6 -m %HASH_TYPE% -w4 %HASHES_FILE% %%a %MASKS_DIRECTORY%%%b -O --potfile-path %POTFILE%.pot
        )) 
    )
))

(for %%a in (%WORDLIST_DIRECTORY%*) do (
    if not %%a == .\wordlists\README.md (
        (for /F "tokens=*" %%b in (%MASKS2USE_FILE%) do (
            START "AutoHashcat - MASK_LIST %%b -> WORDLIST %%a" /W %HASHCAT_BIN% -a 7 -m %HASH_TYPE% -w4 %HASHES_FILE% %MASKS_DIRECTORY%%%b %%a -O --potfile-path %POTFILE%.pot
        )) 
    )
))

START "AutoHashcat - BRUTEFORCE (-i) ?a?a?a?a?a?a?a" /W %HASHCAT_BIN% -i -a 3 -m %HASH_TYPE% -w4 %HASHES_FILE% ?a?a?a?a?a?a?a -O --potfile-path %POTFILE%.pot
