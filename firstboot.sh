#!/bin/bash
## This script is intended to be run one time to setup a new Kali Linux installation

# Update package lists
echo "Updating package lists..."
sudo apt update

# Upgrade existing packages
echo "Upgrading existing packages..."
sudo apt upgrade -y


# Install software
echo "Installing software packages..."
sudo apt install python3-pip
python3 -m pip install --upgrade pip
sudo apt install sshuttle
sudo apt install sshpass
sudo apt install xclip

# clone SecLists
if [[ ! -d /usr/share/wordlists/SecLists ]] ; then
    cd /usr/share/wordlists && sudo git clone https://github.com/danielmiessler/SecLists.git
fi

# create scripts directory and clone important security tools into it
if [[ ! -d $HOME/scripts ]] ; then
  mkdir $HOME/scripts
  cd $HOME/scripts
  git clone https://github.com/skelsec/pypykatz.git
  git clone https://github.com/urbanadventurer/username-anarchy.git
  git clone https://github.com/samratashok/nishang.git
  git clone https://github.com/klsecservices/rpivot.git
  git clone https://github.com/iagox86/dnscat2.git
  git clone https://github.com/lukebaggett/dnscat2-powershell.git
  git clone https://github.com/jpillora/chisel.git
  git clone https://github.com/utoni/ptunnel-ng.git
  git clone https://github.com/CiscoCXSecurity/udp-proto-scanner.git
  git clone https://github.com/nahamsec/lazyrecon.git
  git clone https://github.com/insidetrust/statistically-likely-usernames.git
  git clone https://github.com/Kevin-Robertson/Invoke-TheHash.git
  git clone https://github.com/dafthack/DomainPasswordSpray.git
  wget https://github.com/nccgroup/SocksOverRDP/releases/download/v1.0/SocksOverRDP-x64.zip
  wget https://www.proxifier.com/download/ProxifierPE.zip

fi

# get cherrytree template for pentesting
if [[ ! -f $HOME/CTF_template.ctb ]] ; then
    cd $HOME
    wget https://411hall.github.io/assets/files/CTF_template.ctb
fi

# get john the ripper rules for transforming first name and last name into a list of probable usernames
#john --wordlist=first_last_names.txt --rules=Login-Generator-i --stdout > usernames.txt
#It might be also suitable to append domain to our word list:
#john --wordlist=first_last_names.txt --rules=Login-Generator --mask=?w@victim.com --stdout > usernames.txt

if [[ -f /etc/john/john.conf ]] ; then
    if [[ ! -f /etc/john/john.conf.bak ]] ; then
        cd /etc/john
        sudo cp john.conf john.conf.bak
        curl -s https://gist.githubusercontent.com/dzmitry-savitski/65c249051e54a8a4f17a534d311ab3d4/raw/5514e8b23e52cac8534cc3fdfbeb61cbb351411c/user-name-rules.txt | sudo tee -a /etc/john/john.conf
    fi
fi

# if rockyou.txt.gz is present and not already unzipped then unzip it
if [[ -f /usr/share/wordlists/rockyou.txt.gz ]] ; then
    if [[ ! -f /usr/share/wordlists/rockyou.txt ]] ; then
        cd /usr/share/wordlists && sudo gunzip /usr/share/wordlists/rockyou.txt.gz
    fi
fi