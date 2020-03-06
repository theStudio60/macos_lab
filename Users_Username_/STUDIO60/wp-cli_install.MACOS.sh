########################## 
#
# Studio60 - Agence Web 
# https://studio60.ch
#
########################## 
#
# This is an installer for wp-cli
# So you MUST have PHP installed (MAMP).
#
# Author : Fabien Dupont
# https://github.com/fabien-dupont
# © 2020 - Studio60 - https://studio60.ch
########################## 

cd ~/STUDIO60/wordpress ;

curl --silent -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ;
clear ; 
php wp-cli.phar --info ;
chmod +x wp-cli.phar ;

mv wp-cli.phar /usr/local/bin/wp ; 

echo 'Testing...'
echo ''
echo ''
wp --info ;