#!/bin/bash
#
# Script for install a custom ZSH with OMZSH! and PL10K
#
# version: 0.0.1
# author: N0M4D

echo '<>---< ZSH Custom Installer >---<>'
echo ''
echo '          ---< 0.0.1 >---         '
echo '          ---< N0M4D >---         '
echo ''
  
echo '<!> Update packages ...'
sudo apt update 
sudo apt upgrade
echo ''
  
echo '<!> Install required packages ...'
sudo apt install zsh git curl -y
zsh --version
echo ''
  
echo '<!> Set default shell to ZSH ...'
sudo chsh -s $(which zsh) $(whoami)
echo ''
  
echo '<!> Install OMZSH! and PL10K ...'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
source ~/.zshrc
echo ''

echo '<!> You should logout of user session and back in, or restar your system ...'
  
# Set OMZSH! theme to PL10K -> ZSH_THEME="powerlevel10k/powerlevel10k"
# You should setup recommended fonts 4 pl10k
