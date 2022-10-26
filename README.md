# AutoHashcat
A collection of automated hash cracking knowledge 

This is a **Batch**, **Bash** or **Python** script that automate the workflow of cracking password hashes captured during a Pentests.

Some concept that you should know before running the script are the following:
- **Hashcat:** hashcat is one of the most advanced password recovery utility, supporting five modes of attack for over 300 highly-optimized hashing algorithms.
- **Wordlist:** A wordlist is a file (a text file in most cases but not limited to it) that contains a set of compromised passwords. 
- **Masks:** A password mask is a string that displays the position of character candidates in a password. This string consists of known characters and/or tokens, which set a range of character candidates for a single position. For example, mask `?l2020` generates passwords like `a2020`, `b2020`, `c2020`, etc., i.e., one lowercase letter followed by a known part “2020”.
- **Rules:** Hash rules are efficient as they can produce complex patterns of words from our target wordlists. By using rules we can attempt more complex passphrases allowing us to crack more passwords from our target hash table. One example of that is convert a password like `secret` to `SECRET` with the `u` token rule that uppercase all letters of a word.

You can read more information about **masks based attacks** in the following link
> https://hashcat.net/wiki/doku.php?id=mask_attack


You can read more information about **rules based attacks** in the following link
> https://hashcat.net/wiki/doku.php?id=rule_based_attack

## How to use AutoHashCat
First is important to **describe some directories** that the script will use:
- `./customs_masks/`: Project directory that contains many masks  that can be use by hashcat (there are some extra masks files that doesn't exists on the original Hashcat Project)
- `./customs_rules/`: Project directory that contains many rules that can be use by hashcat (there are some extra rules files that doesn't exists on the original Hashcat Project)
- `./hashes/`: Directory that should contain the hashes file to decrypt.
- `./inputs/`: This directory contains the `masks2use.txt` and `rules2use.txt` files that can be modified to change the masks and rules that the script will use.
- `./potfiles/`: Here is where the decrypted hashes will appear.
- `./utils/`: Some extra scripts that are kinda useful in some cases.
- `./wordlists/`: Usually here is where you put the `rockyou.txt` file.



**Before you run** make sure everything is as it should be

- The **executable of hashcat project** exist on the current folder (Just For **Windows**)
- There is at least one file on the `./wordlist/` directory.
- Verify that the masks list given on `./inputs/masks2use.txt` exists on the `./customs_masks/` directory files.
- Verify that the rules list given on `./inputs/rules2use.txt` exists on the `./customs_rules/` directory files.
- Execute **Python** ( `./AutoHashcat.py` ) or **Bash** ( `./AutoHashcat.sh` ) script in case you are on a Linux based system.
- Execute **Python** ( `./AutoHashcat.py` ) or **Batch** ( `./AutoHashcat.bat` ) script in case you are on a Windows based system.


### Windows Setup

Download the repository and copy all the files to the **Hashcat executable folder**. Then open a terminal in it.

**Batch Usage:**
> `.\AutoHashcat.bat .\hashes\hashes.txt`

**Python Usage:**

Install the requirements with 
> `pip install .`

Run The Script
> `AutoHashcat --file .\hashes\hashes.txt`

### Linux Setup

Download the repository to any folder as you want. Then open a terminal in it.

**Bash Usage:**
> `.\AutoHashcat.sh .\hashes\hashes.txt`

**Python Usage:**

Install the requirements with 
> `pip install -r python_requirements.txt`

Run The Script
> `python AutoHashcat.py --file .\hashes\hashes.txt`

## How AutoHashcat Works

The script will ask for the hash type (`-m`) and for a `job name` which will be the potfile where the cracked hashes are stored.

After that, the script will take care of the attack modes that will be executed against the hashes file, so you can go on with your life and do other fun things.

1. First, it executes a **wordlist attack** with a battery of **rules**.

2. Second, a battery of **mask attacks** without wordlist.

3. Third, a battery of **wordlist** + **mask attacks**.

4. Fourth, a battery of **mask** + **wordlist** attacks.

5. Finally, it will **bruteforce** all possible characters incrementally up to 7 characters.

We can skip stages of the process using `q`. AutoHashcat will just proceed to the next battery of cracking.

## Custom the Script

- To modify **masks** and **rules**  to use go to `./inputs/` directory and change `masks2use.txt` or `rules2use.txt` files.

- To add any **wordlist** you just need to add it to the `wordlists` directory.

- The rules and masks are currently ordered by **execution time.**

Feel free to fork the script and make it better or add your own masks and rules! 

