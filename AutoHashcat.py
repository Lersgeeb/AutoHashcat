# -*- coding: utf8 -*-
import click
import os
from sys import platform
import subprocess

def find_hashcat():
    HASHCAT_EXE_OPTIONS = ['hashcat64.exe', 'hashcat.exe', 'hashcat32.exe']

    if platform == "linux" or platform == "linux2":
        result = os.popen(f'which {option}')
        return result
    elif platform == "win32":
        for option in HASHCAT_EXE_OPTIONS:
            if(os.path.isfile(f"./{option}")): return f"./{option}"

    return ''

def read_list_file(filename):
    with open(filename) as file:
        lines = file.readlines()
        lineList = [line.rstrip() for line in lines]
    return lineList

@click.command(no_args_is_help=True)
@click.option('--file', default='.\hashes\hashes.txt', help='A filename path with the hashes encrypted')
def AutoHashcat(file):
   
    '''
    Quick Usage: python .\AutoHashcat.py --file .\hashes\hashes.txt
    '''
    HASH_TYPE = input("Enter hash type (-m): ")
    JOB_NAME = input("Enter a name for this job: ")
    HASHCAT_RUN = find_hashcat()
    HASH_FILE = file
    POTFILE = f"./potfiles/AutoHashcat_POTFILE_{JOB_NAME}"
    WORDLIST_DIRECTORY = "./wordlists/"
    RULES_DIRECTORY = "./rules/"
    RULES_LIST = read_list_file("./inputs/rules2use.txt")
    MASKS_DIRECTORY = "./masks/"
    MASK_LIST = read_list_file("./inputs/masks2use.txt")
    
    for wordlist in os.listdir(WORDLIST_DIRECTORY):
        if wordlist != "README.md" : 
            for rule in RULES_LIST:    
                subprocess.run(f"{HASHCAT_RUN} -a 0 -m {HASH_TYPE} -w4 -r {RULES_DIRECTORY}{rule} {HASH_FILE} {WORDLIST_DIRECTORY}{wordlist} -O --potfile-path {POTFILE}.pot")
    
    for mask in MASK_LIST: 
        subprocess.run(f"{HASHCAT_RUN} -a 3 -m {HASH_TYPE} -w4 {HASH_FILE} {MASKS_DIRECTORY}{mask} -O --potfile-path {POTFILE}.pot")

    for wordlist in os.listdir(WORDLIST_DIRECTORY):
        if wordlist != "README.md" : 
            for mask in MASK_LIST:   
                subprocess.run(f"{HASHCAT_RUN} -a 6 -m {HASH_TYPE} -w4 {HASH_FILE} {MASKS_DIRECTORY}{mask} {WORDLIST_DIRECTORY}{wordlist} -O --potfile-path {POTFILE}.pot")

    for wordlist in os.listdir(WORDLIST_DIRECTORY):
        if wordlist != "README.md" : 
            for mask in MASK_LIST:   
                subprocess.run(f"{HASHCAT_RUN} -a 7 -m {HASH_TYPE} -w4 {HASH_FILE} {MASKS_DIRECTORY}{mask} {WORDLIST_DIRECTORY}{wordlist} -O --potfile-path {POTFILE}.pot")

    subprocess.run(f"{HASHCAT_RUN} -i -a 3 -m {HASH_TYPE} -w4 {HASH_FILE} ?a?a?a?a?a?a?a -O --potfile-path {POTFILE}.pot")

if __name__ == "__main__":
    AutoHashcat()