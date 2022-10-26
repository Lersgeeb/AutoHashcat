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
	POTFILE="./potfiles/AutoHashcat_POTFILE_"$JOBNAME
	WORDLIST_DIRECTORY="./wordlists"
	RULES_DIRECTORY="./custom_rules/"
	MASKS_DIRECTORY="./custom_masks/"
	RULES2USE_FILE="./inputs/rules2use.txt"
	MASKS2USE_FILE="./inputs/masks2use.txt"

	for wordlist in $WORDLIST_DIRECTORY/* 
	do
		[[ $wordlist -ef "./wordlists/README.md"  ]] && continue
		for RULE in $(cat $RULES2USE_FILE)
		do
			$HASHCAT_BIN -a 0 -m $HASH_TYPE -w4 -r $RULES_DIRECTORY$RULE $HASHES_FILE $wordlist -O --potfile-path $POTFILE.pot
		done
	done

	for MASK in $(cat $MASKS2USE_FILE); do
		$HASHCAT_BIN -a 3 -m $HASH_TYPE -w4 $HASHES_FILE $MASKS_DIRECTORY$MASK -O --potfile-path $POTFILE.pot
	done

	for wordlist in $WORDLIST_DIRECTORY/* 
	do
		[[ $wordlist -ef "./wordlists/README.md"  ]] && continue
		for MASK in $(cat $MASKS2USE_FILE); do
			$HASHCAT_BIN -a 6 -m $HASH_TYPE -w4 $HASHES_FILE $wordlist $MASKS_DIRECTORY$MASK -O --potfile-path $POTFILE.pot
		done
	done

	for wordlist in $WORDLIST_DIRECTORY/* 
	do
		[[ $wordlist -ef "./wordlists/README.md"  ]] && continue
		for MASK in $(cat $MASKS2USE_FILE); do
			$HASHCAT_BIN -a 7 -m $HASH_TYPE -w4 $HASHES_FILE $MASKS_DIRECTORY$MASK $wordlist -O --potfile-path $POTFILE.pot
		done
	done

	$HASHCAT_BIN -i -a 3 -m $HASH_TYPE -w4 $HASHES_FILE ?a?a?a?a?a?a?a -O --potfile-path $POTFILE.pot
fi
