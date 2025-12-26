#!/bin/bash
# Eclipse-X Auto Installer | By Dp75x | GitHub: Daffastorevps

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║      ECLIPSE-X AUTO INSTALLER             ║"
echo "║        By: Dp75x                          ║"
echo "║        GitHub: Daffastorevps              ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "[!] Installing Python3..."
    pkg install python -y
fi

# Install dependencies
echo "[+] Installing dependencies..."
pip install --upgrade pip
pip install aiohttp websockets fake-useragent requests colorama

# Download script
echo "[+] Downloading Eclipse-X..."
curl -O https://raw.githubusercontent.com/Daffastorevps/Eclipse-X/main/eclipse_x.py

# Make executable
chmod +x eclipse_x.py

echo ""
echo "[✓] Installation complete!"
echo "[!] Run: python3 eclipse_x.py"
echo "[!] Or: python3 eclipse_x.py --install for menu"
echo ""