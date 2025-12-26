#!/bin/bash
echo "Installing Eclipse-X minimal..."
apt update && apt install -y python3 python3-pip
pip3 install aiohttp requests
mkdir -p /opt/Eclipse-X
cd /opt/Eclipse-X
wget https://raw.githubusercontent.com/Daffastorevps/Eclipse-X/main/eclipse_x.py
chmod +x eclipse_x.py
echo "Done! Run: python3 eclipse_x.py"
