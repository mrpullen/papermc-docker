#!/bin/bash

# Enter server directory
mkdir -p /papermc
cd papermc

# Lowercase these to avoid 404 errors on wget
MC_VERSION="${MC_VERSION,,}"
PAPER_MC_BUILD="${PAPER_MC_BUILD,,}"

# Get version information and build download URL and jar name
JAR_NAME="paper-${MC_VERSION}-${PAPER_MC_BUILD}.jar"
PAPERMC_URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${PAPER_MC_BUILD}/downloads/${JAR_NAME}"

# Update if necessary
if [[ ! -e $JAR_NAME ]]
then
  # Remove old server jar(s)
  rm -f *.jar
  # Download new server jar
  wget "$PAPERMC_URL" -O "$JAR_NAME"
fi

# Update eula.txt with current setting
echo "eula=true" > eula.txt

# Start server
#!/usr/bin/env sh

exec java "-Xms${MC_MEM}" "-Xmx${MC_MEM}" -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar "$JAR_NAME" nogui
