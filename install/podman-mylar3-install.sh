source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y sudo
$STD apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing Podman"
$STD apt-get -y install podman
$STD systemctl enable --now podman.socket
msg_ok "Installed Podman"

msg_info "Pulling Mylar3 Image"
$STD podman pull lscr.io/linuxserver/mylar3:latest
msg_ok "Pulled Mylar3 Image"

msg_info "Installing Mylar3"
$STD podman volume create mylar3_config
$STD podman volume create comics
$STD podman volume create mylar3
$STD podman run -d \
  --name mylar3 \
  --restart unless-stopped \
  -v /dev:/dev \
  -v mylar3_config:/config \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  --net=host \
  linuxserver/mylar3:latest
podman generate systemd \
  --new --name mylar3 \
  >/etc/systemd/system/mylar3.service
$STD systemctl enable --now mylar3
msg_ok "Installed Mylar3"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
