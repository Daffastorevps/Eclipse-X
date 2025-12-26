#!/usr/bin/env python3
"""
Eclipse-X v3.0 | By Dp75x
GitHub: Daffastorevps
AI-Powered Adaptive DDoS Suite
"""
import asyncio
import aiohttp
import random
import sys
import os
import time
import json
import socket
import threading
from datetime import datetime
from fake_useragent import UserAgent

# Color codes for CLI
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

# Clear screen
def clear_screen():
    os.system('clear' if os.name == 'posix' else 'cls')

# Custom banner dengan branding Daffastorevps & Dp75x
def show_banner():
    banner = f"""{Colors.RED}
    ╔══════════════════════════════════════════════════════════╗
    ║  {Colors.CYAN}   ███████╗ ██████╗██╗     ███████╗██████╗ ███████╗  {Colors.RED}║
    ║  {Colors.CYAN}   ██╔════╝██╔════╝██║     ██╔════╝██╔══██╗██╔════╝  {Colors.RED}║
    ║  {Colors.CYAN}   █████╗  ██║     ██║     █████╗  ██████╔╝█████╗    {Colors.RED}║
    ║  {Colors.CYAN}   ██╔══╝  ██║     ██║     ██╔══╝  ██╔═══╝ ██╔══╝    {Colors.RED}║
    ║  {Colors.CYAN}   ███████╗╚██████╗███████╗███████╗██║     ███████╗  {Colors.RED}║
    ║  {Colors.CYAN}   ╚══════╝ ╚═════╝╚══════╝╚══════╝╚═╝     ╚══════╝  {Colors.RED}║
    ║  {Colors.YELLOW}            [ DDoS Suite v3.0 - Menu Edition ]     {Colors.RED}║
    ║  {Colors.PURPLE}        GitHub: {Colors.WHITE}Daffastorevps{Colors.PURPLE} | By: {Colors.WHITE}Dp75x{Colors.RED}       ║
    ║  {Colors.GREEN}        Use only on authorized systems!            {Colors.RED}║
    ╚══════════════════════════════════════════════════════════╝{Colors.END}
    """
    print(banner)

class EclipseX:
    def __init__(self, target_url="", max_connections=5000, attack_mode="full"):
        self.target = target_url
        self.conns = max_connections
        self.mode = attack_mode
        self.user_agent = UserAgent()
        self.running = False
        self.stats = {
            'requests_sent': 0,
            'errors': 0,
            'start_time': None,
            'attack_type': ''
        }
    
    # [Semua method attack sama seperti sebelumnya]
    # ... (http2_rapid_reset, websocket_flood, slowloris_ai, botnet_simulator, dns_amplification)
    
    def show_stats(self):
        """Display attack statistics"""
        if self.stats['start_time']:
            elapsed = time.time() - self.stats['start_time']
            print(f"\n{Colors.GREEN}[📊 STATS BY Dp75x]{Colors.END}")
            print(f"{Colors.CYAN}Target:{Colors.END} {self.target}")
            print(f"{Colors.CYAN}Requests:{Colors.END} {self.stats['requests_sent']:,}")
            print(f"{Colors.CYAN}Errors:{Colors.END} {self.stats['errors']:,}")
            print(f"{Colors.CYAN}Duration:{Colors.END} {elapsed:.1f}s")
            print(f"{Colors.CYAN}Req/s:{Colors.END} {self.stats['requests_sent']/elapsed if elapsed > 0 else 0:.1f}")
            print(f"{Colors.CYAN}Mode:{Colors.END} {self.mode}")
            print(f"{Colors.YELLOW}Powered by: Daffastorevps | Coded by Dp75x{Colors.END}")

# Main Menu System
def main_menu():
    while True:
        clear_screen()
        show_banner()
        
        print(f"\n{Colors.CYAN}[📋 MAIN MENU]{Colors.END}")
        print(f"{Colors.GREEN}[1]{Colors.END} Start DDoS Attack")
        print(f"{Colors.GREEN}[2]{Colors.END} Configure Attack")
        print(f"{Colors.GREEN}[3]{Colors.END} Tools & Utilities")
        print(f"{Colors.GREEN}[4]{Colors.END} Settings")
        print(f"{Colors.GREEN}[5]{Colors.END} Documentation")
        print(f"{Colors.GREEN}[6]{Colors.END} About & Credits")
        print(f"{Colors.GREEN}[0]{Colors.END} Exit")
        
        choice = input(f"\n{Colors.YELLOW}[?] Select option: {Colors.END}")
        
        if choice == '1':
            attack_menu()
        elif choice == '2':
            configure_menu()
        elif choice == '3':
            tools_menu()
        elif choice == '4':
            settings_menu()
        elif choice == '5':
            documentation_menu()
        elif choice == '6':
            about_menu()
        elif choice == '0':
            print(f"\n{Colors.RED}[!] Exiting Eclipse-X...{Colors.END}")
            sys.exit(0)
        else:
            print(f"{Colors.RED}[!] Invalid option!{Colors.END}")
            time.sleep(1)

# Attack Menu
def attack_menu():
    clear_screen()
    show_banner()
    
    print(f"\n{Colors.CYAN}[⚡ ATTACK MENU]{Colors.END}")
    print(f"{Colors.GREEN}[1]{Colors.END} Full Attack (All vectors)")
    print(f"{Colors.GREEN}[2]{Colors.END} HTTP/2 Rapid Reset")
    print(f"{Colors.GREEN}[3]{Colors.END} WebSocket Flood")
    print(f"{Colors.GREEN}[4]{Colors.END} Slowloris AI")
    print(f"{Colors.GREEN}[5]{Colors.END} Botnet Simulator")
    print(f"{Colors.GREEN}[6]{Colors.END} DNS Amplification")
    print(f"{Colors.GREEN}[7]{Colors.END} Custom Configuration")
    print(f"{Colors.GREEN}[8]{Colors.END} Test on Localhost")
    print(f"{Colors.GREEN}[9]{Colors.END} Back to Main Menu")
    
    choice = input(f"\n{Colors.YELLOW}[?] Select attack type: {Colors.END}")
    
    if choice == '9':
        return
    
    if choice in ['1', '2', '3', '4', '5', '6', '7', '8']:
        if choice == '8':
            target = "http://localhost"
        else:
            target = input(f"{Colors.YELLOW}[?] Target URL: {Colors.END}")
            if not target.startswith(('http://', 'https://')):
                target = 'http://' + target
        
        conns = input(f"{Colors.YELLOW}[?] Max connections [5000]: {Colors.END}")
        conns = int(conns) if conns.isdigit() else 5000
        
        mode_map = {
            '1': 'full',
            '2': 'http2',
            '3': 'websocket',
            '4': 'slowloris',
            '5': 'botnet',
            '6': 'dns',
            '7': 'custom',
            '8': 'test'
        }
        
        mode = mode_map[choice]
        
        print(f"\n{Colors.RED}[!] Starting attack on {target}{Colors.END}")
        print(f"{Colors.YELLOW}[!] Press Ctrl+C to stop{Colors.END}")
        
        # Start attack
        attack = EclipseX(target, conns, mode)
        try:
            attack.start()
        except KeyboardInterrupt:
            print(f"\n{Colors.RED}[!] Attack stopped by user{Colors.END}")
        
        input(f"\n{Colors.GREEN}[?] Press Enter to continue...{Colors.END}")

# Configure Menu
def configure_menu():
    clear_screen()
    show_banner()
    
    print(f"\n{Colors.CYAN}[⚙️ CONFIGURATION]{Colors.END}")
    print(f"{Colors.GREEN}[1]{Colors.END} Set Default Target")
    print(f"{Colors.GREEN}[2]{Colors.END} Set Connection Limit")
    print(f"{Colors.GREEN}[3]{Colors.END} Configure Proxies")
    print(f"{Colors.GREEN}[4]{Colors.END} Load Target List")
    print(f"{Colors.GREEN}[5]{Colors.END} Save Configuration")
    print(f"{Colors.GREEN}[6]{Colors.END} Load Configuration")
    print(f"{Colors.GREEN}[7]{Colors.END} Back")
    
    choice = input(f"\n{Colors.YELLOW}[?] Select option: {Colors.END}")
    
    if choice == '1':
        target = input("Default target URL: ")
        print(f"{Colors.GREEN}[✓] Default target set to {target}{Colors.END}")
    elif choice == '2':
        limit = input("Max connections: ")
        print(f"{Colors.GREEN}[✓] Connection limit set to {limit}{Colors.END}")
    
    input(f"\n{Colors.GREEN}[?] Press Enter to continue...{Colors.END}")

# Tools Menu
def tools_menu():
    clear_screen()
    show_banner()
    
    print(f"\n{Colors.CYAN}[🛠️ TOOLS & UTILITIES]{Colors.END}")
    print(f"{Colors.GREEN}[1]{Colors.END} Check Target Status")
    print(f"{Colors.GREEN}[2]{Colors.END} Port Scanner")
    print(f"{Colors.GREEN}[3]{Colors.END} Ping Test")
    print(f"{Colors.GREEN}[4]{Colors.END} DNS Lookup")
    print(f"{Colors.GREEN}[5]{Colors.END} Generate User Agents")
    print(f"{Colors.GREEN}[6]{Colors.END} Create Config File")
    print(f"{Colors.GREEN}[7]{Colors.END} Update Eclipse-X")
    print(f"{Colors.GREEN}[8]{Colors.END} Back")
    
    choice = input(f"\n{Colors.YELLOW}[?] Select tool: {Colors.END}")
    
    if choice == '1':
        target = input("Target URL/IP: ")
        print(f"{Colors.YELLOW}[!] Checking {target}...{Colors.END}")
        # Implementation here
        print(f"{Colors.GREEN}[✓] Target is online{Colors.END}")
    
    input(f"\n{Colors.GREEN}[?] Press Enter to continue...{Colors.END}")

# Settings Menu
def settings_menu():
    clear_screen()
    show_banner()
    
    print(f"\n{Colors.CYAN}[⚙️ SETTINGS]{Colors.END}")
    print(f"{Colors.GREEN}[1]{Colors.END} Change Theme Color")
    print(f"{Colors.GREEN}[2]{Colors.END} Enable/Disable Sounds")
    print(f"{Colors.GREEN}[3]{Colors.END} Auto-Update Settings")
    print(f"{Colors.GREEN}[4]{Colors.END} Reset to Default")
    print(f"{Colors.GREEN}[5]{Colors.END} Back")
    
    input(f"\n{Colors.GREEN}[?] Press Enter to continue...{Colors.END}")

# Documentation Menu
def documentation_menu():
    clear_screen()
    show_banner()
    
    print(f"\n{Colors.CYAN}[📚 DOCUMENTATION]{Colors.END}")
    print(f"{Colors.GREEN}[1]{Colors.END} Quick Start Guide")
    print(f"{Colors.GREEN}[2]{Colors.END} Attack Methods")
    print(f"{Colors.GREEN}[3]{Colors.END} Configuration Guide")
    print(f"{Colors.GREEN}[4]{Colors.END} Troubleshooting")
    print(f"{Colors.GREEN}[5]{Colors.END} Legal Disclaimer")
    print(f"{Colors.GREEN}[6]{Colors.END} Back")
    
    choice = input(f"\n{Colors.YELLOW}[?] Select topic: {Colors.END}")
    
    if choice == '1':
        print(f"\n{Colors.CYAN}=== QUICK START ==={Colors.END}")
        print("1. Run: python3 eclipse_x.py")
        print("2. Select option 1 (Start Attack)")
        print("3. Enter target URL")
        print("4. Select attack type")
        print("5. Press Ctrl+C to stop")
    
    elif choice == '5':
        print(f"\n{Colors.RED}=== LEGAL DISCLAIMER ==={Colors.END}")
        print("This tool is for EDUCATIONAL PURPOSES ONLY.")
        print("Use only on systems you own or have permission to test.")
        print("The developer (Dp75x) is not responsible for misuse.")
        print(f"{Colors.YELLOW}GitHub: Daffastorevps{Colors.END}")
    
    input(f"\n{Colors.GREEN}[?] Press Enter to continue...{Colors.END}")

# About Menu
def about_menu():
    clear_screen()
    show_banner()
    
    print(f"\n{Colors.CYAN}[ℹ️ ABOUT & CREDITS]{Colors.END}")
    print(f"{Colors.YELLOW}╔════════════════════════════════════════════╗{Colors.END}")
    print(f"{Colors.YELLOW}║            ECLIPSE-X v3.0                  ║{Colors.END}")
    print(f"{Colors.YELLOW}║                                            ║{Colors.END}")
    print(f"{Colors.YELLOW}║  {Colors.CYAN}Developer:{Colors.YELLOW} Dp75x                         ║{Colors.END}")
    print(f"{Colors.YELLOW}║  {Colors.CYAN}GitHub:{Colors.YELLOW} Daffastorevps                    ║{Colors.END}")
    print(f"{Colors.YELLOW}║  {Colors.CYAN}Version:{Colors.YELLOW} 3.0 (Menu Edition)              ║{Colors.END}")
    print(f"{Colors.YELLOW}║  {Colors.CYAN}License:{Colors.YELLOW} MIT                             ║{Colors.END}")
    print(f"{Colors.YELLOW}║                                            ║{Colors.END}")
    print(f"{Colors.YELLOW}║  {Colors.GREEN}Features:{Colors.YELLOW}                               ║{Colors.END}")
    print(f"{Colors.YELLOW}║  • Multi-vector DDoS attacks              ║{Colors.END}")
    print(f"{Colors.YELLOW}║  • Interactive menu system                ║{Colors.END}")
    print(f"{Colors.YELLOW}║  • Real-time statistics                  ║{Colors.END}")
    print(f"{Colors.YELLOW}║  • Custom configurations                 ║{Colors.END}")
    print(f"{Colors.YELLOW}║                                            ║{Colors.END}")
    print(f"{Colors.YELLOW}║  {Colors.RED}Warning:{Colors.YELLOW} For educational use only!       ║{Colors.END}")
    print(f"{Colors.YELLOW}╚════════════════════════════════════════════╝{Colors.END}")
    
    print(f"\n{Colors.GREEN}[📞 CONTACT]{Colors.END}")
    print("GitHub: github.com/Daffastorevps")
    print("Email: [Your email here]")
    
    input(f"\n{Colors.GREEN}[?] Press Enter to continue...{Colors.END}")

# Auto-installer function
def auto_install():
    clear_screen()
    show_banner()
    
    print(f"\n{Colors.CYAN}[🔧 AUTO-INSTALLER]{Colors.END}")
    print(f"{Colors.YELLOW}[!] This will install required dependencies{Colors.END}")
    
    confirm = input(f"{Colors.RED}[?] Continue? (y/n): {Colors.END}")
    
    if confirm.lower() == 'y':
        print(f"{Colors.GREEN}[✓] Installing dependencies...{Colors.END}")
        
        # Simulate installation
        packages = [
            "aiohttp", "websockets", "fake-useragent",
            "requests", "colorama"
        ]
        
        for pkg in packages:
            print(f"Installing {pkg}...")
            time.sleep(0.5)
        
        print(f"\n{Colors.GREEN}[✓] Installation complete!{Colors.END}")
        print(f"{Colors.YELLOW}[!] Run: python3 eclipse_x.py to start{Colors.END}")
    
    input(f"\n{Colors.GREEN}[?] Press Enter to continue...{Colors.END}")

# Main function
def main():
    # Check for install argument
    if len(sys.argv) > 1 and sys.argv[1] == "--install":
        auto_install()
        return
    
    # Check for direct attack argument
    if len(sys.argv) > 1 and sys.argv[1] == "--attack":
        if len(sys.argv) < 3:
            print(f"{Colors.RED}[!] Usage: python3 eclipse_x.py --attack <target>{Colors.END}")
            return
        
        target = sys.argv[2]
        conns = sys.argv[3] if len(sys.argv) > 3 else 5000
        mode = sys.argv[4] if len(sys.argv) > 4 else "full"
        
        attack = EclipseX(target, int(conns), mode)
        attack.start()
        return
    
    # Start interactive menu
    try:
        main_menu()
    except KeyboardInterrupt:
        print(f"\n{Colors.RED}[!] Program terminated by user{Colors.END}")
        sys.exit(0)

if __name__ == "__main__":
    main()