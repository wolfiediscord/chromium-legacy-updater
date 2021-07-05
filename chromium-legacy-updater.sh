#!/bin/bash
# credit
echo "Welcome to Chromium Legacy Updater 1.0!"
echo "Made by Wolfie#7968"
echo "#########################################"
# checks if the script is root
if [ "$EUID" -ne 0 ]
	then echo "ERROR! Please run this script as root!"
	exit
fi
# defining our release url so we can download it
echo "Getting newest release URL..."
RELEASE_URL="$(curl -s https://api.github.com/repos/blueboxd/chromium-legacy/releases/latest | grep "browser_download_url.*zip" | cut -d : -f 2,3 | tr -d \")"
echo "Done!"
echo "Release URL is: $RELEASE_URL"
# premake our environment
echo "Creating temporary folder..."
mkdir .tmp
cd .tmp
echo "Done!"
echo "Downloading newest release..."
# I think that curl would be better if it would just download the whole file
wget $RELEASE_URL
echo "Done! Unzipping..."
# find the zip we just downloaded
ZIP="$(find *.zip)"
# unzip that folder
unzip -qq $ZIP
UNZIPPED_FOLDER=$(echo "$ZIP" | cut -f 1 -d '.')
echo "Done! Path is $UNZIPPED_FOLDER" 
echo "Killing existing instances of Chromium Legacy..."
cd $UNZIPPED_FOLDER
pkill Chromium
echo "Done!"
echo "Copying new version to Applications..."
echo "DO NOT ATTEMPT TO OPEN CHROMIUM LEGACY UNTIL THIS IS FINISHED!"
if [ -d "/Applications/Chromium.app" ];
then
rm -rf /Applications/Chromium.app
fi
cp -r Chromium.app /Applications/Chromium.app
echo "Done!" 
echo "Cleaning up..."
cd ../..
rm -rf .tmp
echo "Done! Thank you for using my script!"
exit
