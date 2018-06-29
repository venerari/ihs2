#!/bin/bash

appdirname=sibapp_01
groupname=tso
username=appsib1
userhome=/$appdirname/$username
appzipfile=IBM-WS_IHS_linux-x86_64.zip

echo "Create Application Directory"
mkdir -p /$appdirname/IBM/
cd /$appdirname/IBM/
echo "Create Application Group"
    groupadd $groupname

echo "Create Application User"
    useradd -m -g $groupname -d $userhome -s /bin/bash $username 

echo "change mount permissions"
chown -R $username:$groupname /$appdirname

echo "Downloading IBM HTTP Server file"

wget $appzipfile  http://192.168.3.111/$appzipfile

unzip /$appdirname/IBM/$appzipfile 2>&1 temp.log

chmod 0775 -R /$appdirname

su - $username

echo "Starting IHS Server"

#sudo cp /$appdirname/IBM/HTTPServer/lib* /usr/lib64
link /sibapp_01/IBM/HTTPServer/lib/libpcre.so.0 /usr/lib64/libpcre.so.0
link /sibapp_01/IBM/HTTPServer/lib/libaprutil-1.so.0 /usr/lib64/libaprutil-1.so.0
 link /sibapp_01/IBM/HTTPServer/lib/libapr-1.so.0 /usr/lib64/libapr-1.so.0

sudo /$appdirname/IBM/HTTPServer/bin/apachectl start

