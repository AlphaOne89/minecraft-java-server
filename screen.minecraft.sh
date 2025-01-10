#!/bin/sh
minecraft_file_path='https://papermc.io/api/v1/paper/1.17.1/latest/download';
if [ ! -f "server.jar" ]; then
apt-get install default-jre screen --yes;
wget --output-document=server.jar ${minecraft_file_path}
echo "eula=true" > eula.txt;
fi
if [ -f "server.jar" ] && [ "$1" = 'update' ]; then
mv server.jar download;
wget --timestamping --no-if-modified-since ${minecraft_file_path}
mv download server.jar;
fi
if [ ! -f "server.properties" ]; then
read -p 'Type in a server name: ' input_prompt;
echo "server-name=${input_prompt}" >> server.properties;
echo "motd=${input_prompt}" >> server.properties;
echo "spawn-protection=0" >> server.properties;
fi
screen_counter=$(screen -list | grep --count --only-matching --extended-regexp --regexp="screen.window.minecraft.one");
if [ ${screen_counter} -eq 0 ]; then
/usr/bin/screen -dmSU screen.window.minecraft.one /usr/bin/java -jar -Xms2500M -Xmx2500M -Dcom.mojang.eula.agree=true server.jar;
fi
screen -r screen.window.minecraft.one
# screen -S screen.window.minecraft.one -p 0 -X stuff "^C";
# screen -S screen.window.minecraft.one -p 0 -X kill;
