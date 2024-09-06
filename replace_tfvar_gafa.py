import sys  # l'accès aux arguments de ligne de commande et à la gestion des chemins.
import os, fnmatch  #  os : la gestion des chemins, la création de répertoires, et la suppression de fichiers. fnmatch:  filtrer des fichiers dans des répertoires en fonction de critères spécifiques.
import re  # des outils pour travailler avec les expressions régulières.


# Find and Replace a string by another in all file pattern in directory
# ie *.tf file in c:\user...
def findReplace(directory, find, replace, filePattern):  # Définir une fonction avec des arguments définis dans les parenthèses. 
    for path, dirs, files in os.walk(os.path.abspath(directory)): # Dans le chemin absolu du répertoire "directory", Utiliser os.walk pour parcourir tous les sous-répertoires et fichiers.
        for filename in fnmatch.filter(files, filePattern): # Filtrer les fichiers correspondant à un motif spécifique avec fnmatch.filter.
            filepath = os.path.join(path, filename) # Créer le chemin complet du fichier en joignant le chemin du répertoire et le nom du fichier.
            # Cette portion de code sert à lire le contenu d'un fichier, à remplacer un texte spécifique, puis à réécrire le contenu modifié dans le même fichier.
            with open(filepath) as f: # Ouvrir le fichier et lire son contenu.
                s = f.read() # une méthode en Python utilisée pour lire tout le contenu d'un fichier et le retourner sous forme de chaîne de caractères. 
            s = s.replace(find, replace) # Remplacer l'ancienne chaîne par la nouvelle dans le contenu du fichier.
            # Rouvrir le fichier en mode écriture et écrire le contenu modifié.
            with open(filepath, "w") as f: # w: write
                f.write(s)

# Définir une fonction input_or_exit pour continuer l'exécution ou quitter le programme selon l'entrée.
def input_or_exit(entry,comment,file_input=False):
    # Si file_input est vrai, demander à l'utilisateur de modifier ses variables d'environnement et quitter le programme.
    if file_input:
        print("Modify your environment variables")
        exit()
    # Sinon, appeler la fonction EnterAndCheckEntry et retourner son résultat.
    else:
        return EnterAndCheckEntry(entry, comment)

# Définir une fonction is_valid_vpc_cidr pour valider un CIDR donné en utilisant une expression régulière.
def is_valid_vpc_cidr(cidr):
    pattern = r'^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])/(1[6-9]|2[0-8])$'
    
    return bool(re.match(pattern, cidr))





# Populate Variables with prompt questionnaires
# Basic check if not empty
def EnterAndCheckEntry(entry,comment): # pour vérifier si une entrée est valide.
    # Vérifier si l'entrée est dans les variables d'environnement ; si oui, la récupérer, sinon demander à l'utilisateur de l'entrer.
    if entry in os.environ:
        answer = os.getenv(entry)
        file_input = True
    else:
        answer = input(comment)
        file_input = False
    # Si l'entrée est vide, demander à l'utilisateur de réessayer ; si l'entrée est VPC_CIDR, vérifier si le format du CIDR est correct.
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
