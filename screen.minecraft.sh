#!/bin/sh

# git clone --depth 1 https://github.com/xxalfa/raspberry.pi.minecraft minecraft;

# cd minecraft && sh screen.minecraft.sh;

path_file_minecraft='https://papermc.io/api/v1/paper/1.17.1/latest/download';

if [ ! -f "paperclip.jar" ]; then

    apt-get install openjdk-16-jre-headless screen --yes;

    wget --output-document=paperclip.jar ${path_file_minecraft}

    echo "eula=true" > eula.txt;

fi

if [ -f "paperclip.jar" ] && [ "$1" = 'update' ]; then

    mv paperclip.jar download;

    wget --timestamping --no-if-modified-since ${path_file_minecraft}

    mv download paperclip.jar;

fi

if [ ! -f "server.properties" ]; then

    read -p 'Type in a server name: ' input_prompt;

    echo "server-name=${input_prompt}" >> server.properties;

    echo "motd=${input_prompt}" >> server.properties;

fi

screen_counter=$(screen -list | grep --count --only-matching --extended-regexp --regexp="screen.window.1");

if [ ${screen_counter} -eq 0 ]; then

    memory=2500;

    if [ $(awk '/MemTotal/ { printf "%.0f\n", $2/1024 }' /proc/meminfo) -lt 3000 ]; then

      memory=800;

    fi

    /usr/bin/screen -dmSU screen.window.1 /usr/bin/java -jar -Xms${memory}M -Xmx${memory}M -Dcom.mojang.eula.agree=true paperclip.jar;

fi

screen -r screen.window.1
