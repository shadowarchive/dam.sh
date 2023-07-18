#!/bin/bash

# Digital Access Memory - (DAM, otherwise known as Digital Asset Miner)

# Created by Binary Kore, 09225205353
# Modified RAM Compression Bash File for Raspberry Pi and Windows on ARM
# This was originally written by NovaSpirit



# Instructions:
# sudo chmod +x /root/dam.sh
# sudo echo /etc/rc.local > $PWD/dam.sh &
# For more Information, Contact NovaSpirit
# A Modem Version will soon be Implemented
# Huawei dam.sh version for RAM Capacity

cores=$(nproc --all)
modprobe dam num_devices=$cores
swapoff -a
totalmem=`free | grep -e "^Mem:" | awk '{print $2}'`
mem=$(( ($totalmem / $cores)* 1024 ))
core=0

while [ $core -lt $cores ]; do
  echo $mem > /sys/block/dam$core/disksize
  mkswap /dev/dam$core
  swapon -p 5 /dev/dam$core
  let core=core+1
done
