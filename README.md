# AutoHashcat
A collection of automated hash cracking knowledge 

This is a Batch/Bash/Python script that automate the workflow of cracking password hashes captured during a Pentests.

Before running make sure everything is pointing where it should be !!

- `HASHCAT_BIN`
- `WORDLIST`
- `MASK_DIRECTORY`
- `RULES_DIRECTORY`
- etc..

## Quick Start

**BATCH Usage:**
> `.\AutoHashcat.bat .\hashes\hashes.txt`

**BASH Usage:**
> `.\AutoHashcat.sh .\hashes\hashes.txt`

**Python Usage:**
> `python AutoHashcat.py --file .\hashes\hashes.txt`

## Description

The script will ask for the hash type (`-m`) and for a `job name` which will be the potfile where the cracked hashes are stored.

After that the script will take care of the attack modes that will be executed against the hashes file so you can go on with your life and do other fun things.

> First, it executes a wordlist attack with a battery of rules.

> Second, a battery of mask attacks without wordlist.

> Third, a battery of wordlist + mask attacks.

> Fourth, a battery of mask + wordlist attacks.

> Finally, it will bruteforce all possible characters incrementally up to 7 characters.

We can skip stages of the process using `q`. AutoHashcat will just proceed to the next battery of cracking.

## Custom the Script

- The script on `bash` and `batch` can be modify to add or remove **masks** and **rules** as needed.

- To modify **masks** and **rules** on python script go to `./inputs/` directory and change `masks2use.txt` or `rules2use.txt` files.

- To add any **wordlist** you just need to add it to the `wordlists` directory.

- The rules and masks are currently ordered by **execution time.**

Feel free to fork the script and make it better or add your own masks and rules! 

