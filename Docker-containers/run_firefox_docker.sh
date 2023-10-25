#! /bin/bash
# https://hub.docker.com/r/jlesage/firefox

folder_of_firefox="/home/"$USER"/Téléchargements/docker_firefox"
config_folder="$folder_of_firefox/config"


mkdir -p $config_folder
wget https://gitlab.com/magnolia1234/bypass-paywalls-firefox-clean/-/archive/master/bypass-paywalls-firefox-clean-master.zip -P $folder_of_firefox

docker run -d \
--name=firefox \
-p 5800:5800 \
-v $config_folder:/config:rw \
--shm-size 2g \
-e FF_OPEN_URL="about:debugging#/runtime/this-firefox" \
jlesage/firefox


cp $folder_of_firefox/bypass-paywalls-firefox-clean-master.zip $config_folder/downloads/
unzip $config_folder/bypass-paywalls-firefox-clean-master.zip

#docker restart firefox

#echo "install https://addons.mozilla.org/fr/firefox/addon/adblock-plus/"





