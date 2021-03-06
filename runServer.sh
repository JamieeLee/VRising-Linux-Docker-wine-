#!/bin/bash
mkdir -p data
mkdir -p data/save-data
sudo docker build . -t vrisingdedserver/wine64:v20052022
sudo docker run --name "VRisingUpdater" --rm -it -v $PWD/data:/data honestventures/steamcmd-linux-wine:latest +force_install_dir /data +login anonymous +app_update 1829350 validate +quit
cp data/VRisingServer_Data/StreamingAssets/Settings/ServerHostSettings.json data/save-data/ServerHostSettings.json
cp data/VRisingServer_Data/StreamingAssets/Settings/ServerGameSettings.json data/save-data/ServerGameSettings.json
cp data/VRisingServer_Data/StreamingAssets/Settings/ServerVoipSettings.json data/save-data/ServerVoipSettings.json
cp data/VRisingServer_Data/StreamingAssets/Settings/adminlist.txt data/save-data/adminlist.txt
cp data/VRisingServer_Data/StreamingAssets/Settings/banlist.txt data/save-data/banlist.txt
sudo docker run -it -d --name vRisingServer --rm -v $PWD/data:/data -p 27015:27015 -p 27016:27016 -p 27015:27015/udp -p 27016:27016/udp vrisingdedserver/wine64:v20052022 /bin/bash -c "cd /data; /usr/bin/xvfb-run wine VRisingServer.exe -persistentDataPath \".\save-data\" -log"
rm ./runServer.sh
mv ./runServer.tmp ./runServer.sh
