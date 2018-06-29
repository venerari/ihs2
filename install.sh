#!/bin/bash

appdirname=sibapp_01
groupname=tso
username=appsib1
userhome=/$appdirname/$username
appzipfile=IBM-WS_IHS_linux-x86_64.zip

mkdir -p /$appdirname/IBM/
cd /$appdirname/IBM/

groupadd $groupname

useradd -m -g $groupname -d $userhome -s /bin/bash $username 

wget $appzipfile  http://192.168.3.111/$appzipfile

unzip /$appdirname/IBM/$appzipfile

chmod 0775 -R /$appdirname
chown -R $username:$groupname /$appdirname

link /sibapp_01/IBM/HTTPServer/lib/libpcre.so.0 /usr/lib64/libpcre.so.0
link /sibapp_01/IBM/HTTPServer/lib/libaprutil-1.so.0 /usr/lib64/libaprutil-1.so.0
link /sibapp_01/IBM/HTTPServer/lib/libapr-1.so.0 /usr/lib64/libapr-1.so.0

echo '$username ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

su - $username
sudo /$appdirname/IBM/HTTPServer/bin/apachectl start

