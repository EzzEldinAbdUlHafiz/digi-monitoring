#!/bin/bash

# 1. Stop the service
sudo systemctl stop node_exporter

# 2. Update ExecStart to use port 80
sudo sed -i 's|^ExecStart=.*|ExecStart=/usr/local/bin/node_exporter --web.listen-address=":80"|' /etc/systemd/system/node_exporter.service

# 3. Grant permission to bind to port 80
sudo setcap cap_net_bind_service=+ep /usr/local/bin/node_exporter

# 4. Apply changes and restart
sudo systemctl daemon-reload
sudo systemctl restart node_exporter
sudo systemctl enable node_exporter

# 5. Verify status
sudo ss -tulpn | grep :80
sudo systemctl status node_exporter
