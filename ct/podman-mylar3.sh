#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
                     ____            __                                      
                    / __ \____  ____/ /___ ___  ____ _____                   
                   / /_/ / __ \/ __  / __  __ \/ __  / __ \                  
                  / ____/ /_/ / /_/ / / / / / / /_/ / / / /                  
    __  __       /_/    \____/\__,_/_/ /_/ /_/\__,_/_/ /_/__              __ 
   / / / /___  ____ ___  ___     /   |  __________(_)____/ /_____ _____  / /_
  / /_/ / __ \/ __  __ \/ _ \   / /| | / ___/ ___/ / ___/ __/ __  / __ \/ __/
 / __  / /_/ / / / / / /  __/  / ___ |(__  |__  ) (__  ) /_/ /_/ / / / / /_  
/_/ /_/\____/_/ /_/ /_/\___/  /_/  |_/____/____/_/____/\__/\__,_/_/ /_/\__/  
 
EOF
}
header_info
echo -e "Loading..."
APP="Podman-Mylar3"
var_disk="16"
var_cpu="2"
var_ram="2048"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:8123${CL} \n"
