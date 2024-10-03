#!/bin/bash
alias simp='python3 -m http.server 80'
alias nse='ls /usr/share/nmap/scripts'
alias sortip='sort -t . -k 3,3n -k 4,4n'
alias filezilla='filezilla &>/dev/null &'
alias wireshark='wireshark &>/dev/null &'
alias b64='base64 -w 0'
alias johnrock='john --wordlist=/usr/share/wordlists/rockyou.txt'
alias n=leafpad
alias smbstart='python3 /usr/share/doc/python3-impacket/examples/smbserver.py -smb2support CompData ./'
alias smbstop='pgrep -f smbserver.py|xargs kill -9'
alias eth0='ip -f inet addr show eth0 | grep -Po "inet \K[\d.]+"| xargs echo -n'
alias eth1='ip -f inet addr show eth1 | grep -Po "inet \K[\d.]+"| xargs echo -n'
alias tun0='ip -f inet addr show tun0 | grep -Po "inet \K[\d.]+"| xargs echo -n'
alias xclip='xclip -selection c'
alias wanip='dig +short o-o.myaddr.l.google.com @ns1.google.com TXT -4|sed "s/\"//g" | xargs echo -n'
# This is for pentesting, don't get excited
alias ssh='ssh -o StrictHostKeyChecking=no'
