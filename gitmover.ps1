Function GitFetchRemoteBranches{
   
    $orginal = (git symbolic-ref HEAD).split("/")[-1]
       
    Foreach($entry in (git branch -r)){
        
        If($entry -like "*->*"){
            $branch = $entry.split("->")[2].split("/")[1]
        }else{
            $branch = $entry.split("/")[1]
        }

        git checkout -b $branch origin/$branch

        Remove-Variable branch -Force
    }
}


$oldrepo = Read-Host "Eski Repo Adresi "
$newrepo = Read-Host "Yeni Repo Adresi "
$appname = $oldrepo.split("/")[-1]

git clone $oldrepo
cd $appname

git fetch origin

GitFetchRemoteBranches

git remote add new-origin $newrepo
git push --all new-origin
git remote -v
git remote rm origin
git remote rename new-origin origin

cd ..