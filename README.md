# AutoHashcat
A collection of automated hash cracking knowledge 

This is a batch/bash script I put together to automate the workflow of cracking password hashes captured during my Pentests.

Before running make sure everything is pointing where it should be !!

HASHCAT_BIN

WORDLIST

MASK_DIRECTORY

RULES_DIRECTORY

etc..

Usage:

.\AutoHashcat.bat .\hashes.txt

The script will ask for the hash type (-m) and for a job name which will be the potfile where the cracked hashes are stored.
After that the script will take care of the attack modes that will be executed against the hashes file so you can go on with your life and do other fun things.

First, it executes a wordlist attack with a battery of rules.

Second, a battery of mask attacks without wordlist.

Third, a battery of wordlist + mask attacks.

Fourth, a battery of mask + wordlist attacks.

Finally, it will bruteforce all possible characters incrementally up to 7 characters.

We can skip stages of the process using [q]. AutoHashcat will just proceed to the next battery of cracking.

We can modify the script to add or remove wordlists, masks and rules as needed in the WORDLISTS, MASKS, AND RULES variables 

I have made an effort to order the rules and masks in order of execution time.

Feel free to fork the script and make it better or add your own masks and rules! 
