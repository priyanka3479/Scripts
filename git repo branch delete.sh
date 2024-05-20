#!/bin/bash

# List of repository URLs or paths
repos=(
  "git@code.siemens.com:blrise/productive/nextwork/testpriyanka.git"
  
  # Add more repositories as needed
)

# Associative array of branches to delete in each repository
declare -A branches_to_delete

# Example: branches_to_delete["repo1"]="branch1 branch2"
branches_to_delete["git@code.siemens.com:blrise/productive/nextwork/testpriyanka.git"]="test--1 test--2"


# Add more repositories and branches as needed

for repo in "${repos[@]}"; do
  # Clone the repository
  repo_name=$(basename "$repo" .git)
  git clone "$repo"
  
  # Enter the repository directory
  cd "$repo_name" || exit

  # Loop through branches and delete each one locally and remotely
  for branch in ${branches_to_delete[$repo]}; do
    # Delete the branch locally
    #git branch -d $branch
	echo "branch name is $branch"

    # Delete the branch on the remote repository
    git push origin --delete $branch
  done

  # Return to the original directory
  cd ..

  # Clean up by removing the cloned repository
  rm -rf "$repo_name"
done
