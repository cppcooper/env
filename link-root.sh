#!/usr/bin/bash
dest="/root"
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
if chkfile .bash_profile; then
    rm .bash_profile
fi
if chkfile .gitconfig; then
    rm .gitconfig
fi
if chkfile .ssh; then
    rm -rf .ssh
fi
ln -s /env/.exec-root.bash .bashrc
ln -s /env/.exec-root.bash .bash_profile
ln -s /env/.gitconfig .gitconfig

mkdir /root/.ssh 2>&1 | grep -v "File exists"
cd /.system/home/.ssh
for file in $(find * -not -type d); do
    cp $file /root/.ssh/$file
done

chmod og-rwx /root/.ssh -R
chown root:root /root/.ssh -R
