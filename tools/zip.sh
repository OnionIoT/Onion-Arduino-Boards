#!/bin/bash

# get current directory name
dirName=${PWD##*/} 
if [ "$dirName" != 'tools' ]; then
    echo "Please run in the 'repo/tools' directory."
    exit
fi

# get version number
versionNumber=$1
if [ "$versionNumber" == "" ]; then
    echo "Please specify a version number."
    exit
fi

srcDirName=onion-arduino-dock-$versionNumber
archiveName=$srcDirName.tar.gz


# zip the archive
cd ..
mkdir -p ./tmp/$srcDirName
cp -r ./onion/avr/* ./tmp/$srcDirName
tar -zcvf ./IDE_Board_Manager/$archiveName -C ./tmp $srcDirName
rm -rf tmp

# get the size and checksum
archiveSize=$(stat --printf="%s" ./IDE_Board_Manager/$archiveName)
checksum=$(shasum -a 256 ./IDE_Board_Manager/$archiveName | awk '{print $1}')
echo "Size: $archiveSize"
echo "SHA-256: $checksum"