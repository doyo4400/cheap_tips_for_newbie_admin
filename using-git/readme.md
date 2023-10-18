# Config git
> git config --global user.name "name" 
> git config --global user.email "mail@mail.com"

## select auth for push
> git config --global credential.credentialStore secretservice --replace-all
> git config --global credential.helper 'cache --timeout=360' --replace-all

</br></br></br>

# Git usage

## create git repo in folder
> git init $/path/of/folder

## add file in index
> git add $file 

## push change in head
> git commit -m $describe_commit

## push change in repo
> git push 

## if remote repo without clone
> git remote add origin $repo/url


## create branch (shortcut for git branch + git checkout)
> git checkout -b $functiun_name

## move to other branch 
> git checkout $branch

## fusion branch iwth master
> git checkout master
> git merge $branch

### if conflict with fusion
> git status

#### for resolv conflict
> git mergetool

#### surrender fusion
> git merge --abort

#### conflict with space
> git merge -Xignore-all-space $branch
> git merge -Xignore-space-change $branch

### after fusion, we can delete the old branch
> git branch -d $branch

