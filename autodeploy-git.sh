#!/bin/bash

echo "Creating autodeployment directory";
mkdir autodeployment;
echo "Enter service name:";
read deployment_folder;
mkdir $deployment_folder;
git init --bare autodeployment/$deployment_folder.git
echo "Enter the branch name:";
read branch_name;
script="#!/bin/sh
git --work-tree="$PWD/$deployment_folder" --git-dir="$PWD/autodeployment/$deployment_folder.git" checkout -f "$branch_name;

echo "$script" > "$PWD/autodeployment/$deployment_folder.git/hooks/post-receive"
echo "Paste additional script (End with Ctrl+D)";
additional_script=$(cat)
echo "$additional_script" >> "$PWD/autodeployment/$deployment_folder.git/hooks/post-receive"
echo "Auto-Deployment setting done!"
echo "Copy and Paste the following settings in your SSH";
echo "git remote add <<origin>> ssh://<<username>>@<<mydomain.com>>$PWD/autodeployment/$deployment_folder.git"
