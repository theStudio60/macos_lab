########################## 
# Studio60 - Agence Web 
# https://studio60.ch
########################## 
# This is an installer for wp-cli
# So you MUST have PHP installed (MAMP).
#
# usage :
# chmod +x wp-cli_install.MACOS.sh ; ./wp-cli_install.MACOS.sh
#
# Author : Fabien Dupont
# https://github.com/fabien-dupont
# © 2020 - Studio60 - https://studio60.ch
########################## 
clear;
echo 'Downloading wp-cli...' ;
curl  -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ;
php wp-cli.phar --info ;
chmod +x wp-cli.phar ;
mv wp-cli.phar /usr/local/bin/wp ; 
echo 'Testing...' ;
wp --info ;