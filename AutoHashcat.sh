#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <hashes_file.txt>"
exit 0

else

echo "Enter hash type (-m): "
read HASH_TYPE 
HASHCAT_BIN=$(which hashcat)
HASHES_FILE=$1
echo "Enter a name for this job: "
read JOBNAME
POTFILE="AutoHashcat_POTFILE_"$JOBNAME
WORDLIST_DIRECTORY="./wordlists/"
WORDLIST="rockyou.txt oracle-ebs-passwordlist.txt"
RULES_DIRECTORY="./rules/"
RULES_LIST="combinator.rule best64.rule"
MASKS_DIRECTORY="./masks/"
MASK_LIST="corp_8.hcmask corp_9.hcmask"


	for a in $WORDLIST; do
    		for b in $RULES_LIST; do
        		$HASHCAT_BIN -a 0 -m $HASH_TYPE -w4 -r $RULES_DIRECTORY$b $HASHES_FILE $WORDLIST_DIRECTORY$a -O --potfile-path $POTFILE.pot
    		done
	done
: '


	for a in $MASK_LIST; do
    		echo $HASHCAT_BIN -a 3 -m $HASH_TYPE -w4 $HASHES_FILE $MASKS_DIRECTORY$a -O --potfile-path $POTFILE.pot
	done

	for a in $WORDLIST; do
    		for b in $MASK_LIST; do
        		echo $HASHCAT_BIN -a 6 -m $HASH_TYPE -w4 $HASHES_FILE $WORDLIST_DIRECTORY$a $MASKS_DIRECTORY$b -O --potfile-path $POTFILE.pot
    		done
	done

	for a in $WORDLIST; do
    		for b in $MASK_LIST; do
        		echo $HASHCAT_BIN -a 7 -m $HASH_TYPE -w4 $HASHES_FILE $MASKS_DIRECTORY$b $WORDLIST_DIRECTORY$a -O --potfile-path $POTFILE.pot
    		done
	done

	echo $HASHCAT_BIN -i -a 3 -m $HASH_TYPE -w4 $HASHES_FILE ?a?a?a?a?a?a?a -O --potfile-path $POTFILE.pot
'
fi
