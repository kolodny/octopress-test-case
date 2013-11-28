#!/bin/bash                                                                                                                                             
                                                                                                                                                        
if [ $# -eq 0 ]                                                                                                                                         
  then                                                                                                                                                  
    echo "Please supply the github repo as an argument";                                                                                                
    exit;                                                                                                                                               
fi                                                                                                                                                      

rm -rf octopress1 octopress2
git clone git://github.com/imathis/octopress.git octopress1
cd octopress1
gem install bundler
rbenv rehash
bundle install
rake install
rake new_post['First Post']
echo This is the first post >> source/_posts/$(ls source/_posts)
echo $1 | rake setup_github_pages
rake generate
rake deploy
git add .
git commit -m "first commit"
git remote rm origin
git remote add origin $1
git push origin master

cd ..
git clone $1 octopress2
cd octopress2
git checkout master
rake new_post['Second Post']
echo This is the second post >> source/_posts/$(ls source/_posts | grep second)
echo $1 | rake setup_github_pages
rake generate
rake deploy

