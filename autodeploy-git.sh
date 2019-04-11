#!/bin/bash

printf "\033[1;31m* Creating autodeployment directory... \033[0m\n"
mkdir autodeployment;
printf "\033[1;31m* Please enter autodeployment service for: \033[0m\n"
read deployment_folder;
mkdir $deployment_folder;
git init --bare autodeployment/$deployment_folder.git
printf "\033[1;31m* Enter the deployed branch name: \033[0m\n"
read branch_name;
script="#!/bin/sh
git --work-tree="$PWD/$deployment_folder" --git-dir="$PWD/autodeployment/$deployment_folder.git" checkout -f "$branch_name;

echo "$script" > "$PWD/autodeployment/$deployment_folder.git/hooks/post-receive"
chmod +x $PWD/autodeployment/$deployment_folder.git/hooks/post-receive
printf "\033[1;31m* Paste additional script (End with Ctrl+D) \033[0m\n"
additional_script=$(cat)
echo "$additional_script" >> "$PWD/autodeployment/$deployment_folder.git/hooks/post-receive"
printf "\033[1;31m* Auto-Deployment setting done! \033[0m\n"
printf "\033[1;31m* Copy and Paste the following settings in your SSH \033[0m\n"
printf "\033[1;31m/* ---SSH Configuration Start--- /\033[0m\n
\033[1;32m
HOST <example||IP_Address>
HOSTNAME <IP_Address>
User <username>
IdentityFile <path/of/pem.file>
\033[0m\n
"
printf "\033[1;31m/* ---Add Git Remote--- /\033[0m\n"
printf "\033[1;32m\033[1;4mgit remote add <<origin>> ssh://<<username>>@<<mydomain.com>>$PWD/autodeployment/$deployment_folder.git\033[0m\n"
