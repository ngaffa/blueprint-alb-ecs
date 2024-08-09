import sys
import os, fnmatch
import re


# Find and Replace a string by another in all file pattern in directory
# ie *.tf file in c:\user...
def findReplace(directory, find, replace, filePattern):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath) as f:
                s = f.read()
            s = s.replace(find, replace)
            with open(filepath, "w") as f:
                f.write(s)


def input_or_exit(entry,comment,file_input=False):
    if file_input:
        print("Modify your environment variables")
        exit()
    else:
        return EnterAndCheckEntry(entry, comment)


def is_valid_vpc_cidr(cidr):
    pattern = r'^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])/(1[6-9]|2[0-8])$'
    
    return bool(re.match(pattern, cidr))





# Populate Variables with prompt questionnaires
# Basic check if not empty
def EnterAndCheckEntry(entry,comment):

    if entry in os.environ:
        answer = os.getenv(entry)
        file_input = True
    else:
        answer = input(comment)
        file_input = False

    if(not (answer and not answer.isspace())):
        print("String can't be empty... Type again")
        return input_or_exit(entry,comment,file_input)
    else:  
        if(entry == 'VPC_CIDR'):
            if not is_valid_vpc_cidr(answer): # If the answer doese not respect the REGEX of an CIDR
                print("Wrong CIDR ... Type again")
                return input_or_exit(entry,comment,file_input)
        
    return(answer.lower())
    



# Get Current DIR
WORK_DIR = os.getcwd()
print("Will search and replace in default.tfvars in "+ WORK_DIR)

ENTRIES = {}
ENTRIES["VPC_CIDR"] = "Enter the VPC CIDR Please  (should respect the cidr REGEX ): " 

VARS = {}

# Populate VARS hashmap
for KEY in ENTRIES:
    VARS[KEY] = EnterAndCheckEntry(KEY,ENTRIES[KEY])   

# Print SUMUP
print("Please verify your information before validating ")
print("########################################################")
for KEY in VARS:
    print(KEY + " -> " + VARS[KEY])

# Start replace
print("########################################################")
print("Do you want to continue ?")
accept = input("only yes or no are valid answers: ")
if(accept == "yes"):
    print("Scanning and replacing variables in default.tfvars file in " + WORK_DIR)
    for KEY in VARS:
        print("Replacing " + KEY)
        findReplace(WORK_DIR,"<"+KEY+">",VARS[KEY],"default.tfvars")
else:
    print("Replacement cancelled... Exiting ")    
    exit    
