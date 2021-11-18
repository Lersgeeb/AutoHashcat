@ECHO OFF

set /p HASH_TYPE="Enter hash type (-m): "
set HASHCAT_BIN=.\hashcat64.exe
set HASHES_FILE=%1
set /p JOBNAME="Enter a name for this job: "
set POTFILE=".\potfiles\AutoHashcat_POTFILE_"%JOBNAME%
set WORDLIST_DIRECTORY=.\wordlists\
set WORDLIST=rockyou.txt hashkiller-dict.txt realuniq.lst kaonashi14M.txt
set RULES_DIRECTORY=.\rules\
set RULES_LIST=combinator.rule best64.rule specific.rule leetspeak.rule toggles1.rule hob064.rule toggles2.rule oscommerce.rule T0XlC-insert_space_and_special_0_F.rule toggles3.rule toggles4.rule T0XlC-insert_top_100_passwords_1_G.rule InsidePro-PasswordsPro.rule toggles5.rule T0XlC-insert_00-99_1950-2050_toprules_0_F.rule T0XlC.rule Ninja-leetspeak.rule InsidePro-HashManager.rule T0XlCv1.rule generated.rule Incisive-leetspeak.rule rockyou-30000.rule d3ad0ne.rule d3adhob0.rule generated2.rule dive.rule
set MASKS_DIRECTORY=.\masks\
set MASK_LIST=corp_8.hcmask corp_9.hcmask corp_10.hcmask corp_11.hcmask corp_12.hcmask corp_13.hcmask corp_14.hcmask 

(for %%a in (%WORDLIST%) do (
    (for %%b in (%RULES_LIST%) do (
        START "AutoHashcat - WORDLIST %%a RULE %%b" /W %HASHCAT_BIN% -a 0 -m %HASH_TYPE% -w4 -r %RULES_DIRECTORY%%%b %HASHES_FILE% %WORDLIST_DIRECTORY%%%a -O --potfile-path %POTFILE%.pot
    )) 
))

(for %%a in (%MASK_LIST%) do (
    START "AutoHashcat - MASK_LIST %%a" /W %HASHCAT_BIN% -a 3 -m %HASH_TYPE% -w4 %HASHES_FILE% %MASKS_DIRECTORY%%%a -O --potfile-path %POTFILE%.pot
)) 

(for %%a in (%WORDLIST%) do (
    (for %%b in (%MASK_LIST%) do ( 
        START "AutoHashcat - WORDLIST %%a -> MASK_LIST %%b" /W %HASHCAT_BIN% -a 6 -m %HASH_TYPE% -w4 %HASHES_FILE% %WORDLIST_DIRECTORY%%%a %MASKS_DIRECTORY%%%b -O --potfile-path %POTFILE%.pot
    )) 
))

(for %%a in (%WORDLIST%) do (
    (for %%b in (%MASK_LIST%) do ( 
        START "AutoHashcat - MASK_LIST %%b -> WORDLIST %%a" /W %HASHCAT_BIN% -a 7 -m %HASH_TYPE% -w4 %HASHES_FILE% %MASKS_DIRECTORY%%%b %WORDLIST_DIRECTORY%%%a -O --potfile-path %POTFILE%.pot
    )) 
))

START "AutoHashcat - BRUTEFORCE (-i) ?a?a?a?a?a?a?a" /W %HASHCAT_BIN% -i -a 3 -m %HASH_TYPE% -w4 %HASHES_FILE% ?a?a?a?a?a?a?a -O --potfile-path %POTFILE%.pot
