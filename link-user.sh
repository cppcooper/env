#!/usr/bin/bash
if [ -z "$1" ]; then
    echo "You must provide the user name as an argument"
    exit 1
fi

dest="/home/$1"
cd $dest
function chkfile(){
 if stat $1 &> /dev/null; then
  return 0
 else
  return 1
 fi
}
if chkfile .bashrc; then
    rm .bashrc
fi
# if chkfile .bash_profile; then
#     rm .bash_profile
# fi
if chkfile .gitconfig; then
    rm .gitconfig
fi
if chkfile scripts; then
    rm scripts
fi
ln -s $HOME/env/user.bashrc .bashrc
ln -s $HOME/env/.gitconfig .gitconfig

cd /.system/home/.ssh
rm -rf $dest/.ssh
mkdir $dest/.ssh
for file in $(find * -not -type d); do
    cp $file $dest/.ssh/$file
done

cd $dest/
chmod og-rwx .ssh -R
chown $1:$1 .ssh -R
