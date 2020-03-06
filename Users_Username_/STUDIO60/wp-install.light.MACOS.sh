########################## 
#
# Studio60 - Agence Web 
# https://studio60.ch
#
########################## 
#
# STUDIO60 Custom Wordpress Installation Script
# this was written for yosemite with MAMP, and wp-cli

# THe script downloads a blank underscores theme
# and install wpgulp inside of it . Then it creates
# a file called STUDIO60_README.txt where the main informations about
# this project are dropped, like urls and dirs. 
#
# Author : Fabien Dupont
# https://github.com/fabien-dupont
# © 2020 - Studio60 - https://studio60.ch
########################## 

NOW=$(date +_%d_%h_%Y_%H%M%S)
LOCALHOST=$(echo '127.0.0.1')
APACHE_PORT=$(cat /Applications/MAMP/conf/apache/httpd.conf | grep ^Listen | tr -d [A-Z][a-z][:space:] | cat)
LOCALHOST_APACHE_ADDRESS=$(echo $LOCALHOST:$APACHE_PORT)
WPLAB_DIR=$(echo '/Applications/MAMP/htdocs/wplab')

PROJECT_NAME=''
PROJECT_DIR=$(echo $WPLAB_DIR/$PROJECT_NAME)
SITE_URL=$(echo $LOCALHOST_APACHE_ADDRESS/wplab/$PROJECT_NAME/)
SITE_THEME_DIR=$(echo $PROJECT_DIR/wp-content/themes/sixty)
SITE_THEME_URL=$(echo $SITE_URL:3000)

# Database information
DB_USER=$(echo 'root')
DB_PASS=$(echo 'root')
DB_HOST=$LOCALHOST
DB_NAME=$(echo 'wpdb')

# General-purpose Yes/No prompt function
ask() {
	while true; do
  if [ "${2:-}" = "Y" ]; then
  	prompt="Y/n"
  	default=Y
  elif [ "${2:-}" = "N" ]; then
  	prompt="y/N"
  	default=N
  else
  	prompt="y/n"
  	default=
  fi
  # Ask the question
  echo
  read -p "$1 [$prompt] > " REPLY
  # Default?
  if [ -z "$REPLY" ]; then
  	REPLY=$default
  fi
  # Check if the reply is valid
  case "$REPLY" in
  	Y*|y*) return 0 ;;
  	N*|n*) return 1 ;;
  esac
	done
};

wp_download() {
  clear ;
  echo ''
  echo 'Download latest Wordpress release 😀 ';
  echo ''
	wp core download --path=$PROJECT_DIR --locale=en_GB
};

wp_setup() {
  clear ;
  echo ''
  echo 'Configuration de la base de données';
  echo ''
  wp core config --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbprefix=$PROJECT_NAME # we need to make it work without this : --skip-check
};

wp_install() {
  clear ;
  echo ''
  echo 'Wordpress installation...'
  echo ''
  wp core install --path=$PROJECT_DIR --url=$SITE_URL --title="$PROJECT_NAME" --admin_user=admin --admin_password=admin --admin_email=$USER@$LOCALHOST 
};

wp_install_fr() {
  clear ;
  echo ''
  echo 'Install french version'
  echo ''
  wp core language install fr_FR --activate --path=$PROJECT_DIR
};

sixty_theme_download() {
  clear ;
  echo ''
  echo 'Download and installation of underscores theme named sixty, with sass'
  echo ''
  echo 'Now pay attention, in our wordpress workflow, the name of our themes is ALWAYS sixty'
  echo ''
  sleep 1 ;

  curl --silent  --data "underscoresme_generate=1&underscoresme_name=sixty&underscoresme_slug=sixty&underscoresme_author=Studio60&underscoresme_author_uri=https%3A%2F%2Fstudio60.ch&underscoresme_description=A+Website+Created+by+STUDIO60&underscoresme_sass=1"  https://underscores.me >> sixty.zip ;
  unzip -q sixty.zip                                && 
  mv    sixty wp-content/themes/                    &&
  rm -Rf sixty.zip ;
};

sixty_theme_screenshot() {
  clear;
  echo ''
  echo 'Now we download the screenshot.png in github'
  echo ''
  rm -Rf wp-content/themes/sixty/screenshot.png &&
  curl --silent https://raw.githubusercontent.com/theStudio60/wplab/master/screenshot.png -O wp-content/themes/sixty/screenshot.png
};

sixty_theme_config() {

  clear ;
  echo ''
  echo 'Configuration of the theme'
  echo ''
  echo 'The css files, js et img will be moved in assets'
  echo ''

  mkdir wp-content/themes/sixty/trash               &&
  mkdir wp-content/themes/sixty/assets              &&
  mkdir wp-content/themes/sixty/assets/css          &&
  mkdir wp-content/themes/sixty/assets/js           &&
  mkdir wp-content/themes/sixty/assets/js/vendor    &&
  mkdir wp-content/themes/sixty/assets/js/custom    &&
  mkdir wp-content/themes/sixty/assets/img          &&
  mkdir wp-content/themes/sixty/assets/img/raw      &&

  mv wp-content/themes/sixty/sass/*  wp-content/themes/sixty/assets/css/        && 
  mv wp-content/themes/sixty/js/*    wp-content/themes/sixty/assets/js/custom/  && 
  mv wp-content/themes/sixty/sass    wp-content/themes/sixty/trash/             &&
  mv wp-content/themes/sixty/js      wp-content/themes/sixty/trash/             &&

  clear ;
  echo ''
  echo 'Activation of the theme sixty'
  echo ''
  wp theme activate sixty --path=$PROJECT_DIR &&
  
  
};

wp_config() {
  
  echo ''
  echo 'Delete default wordpress themes'
  echo ''
  wp theme delete twentyfifteen twentysixteen twentyseventeen twentyeighteen twentynineteen twentytwenty --path=$PROJECT_DIR
	
  echo ''
  echo 'Delete Akismet plugin'
  echo ''
  wp plugin delete hello akismet --path=$PROJECT_DIR &&

  echo ''
  echo 'Delete initial posts'
  echo ''
  wp post delete 1 2 3 --force --path=$PROJECT_DIR &&
  
  echo ''
	echo 'Ask robots to not index this site'
  echo ''
	wp option update blog_public false --path=$PROJECT_DIR

  echo ''
	echo 'Default media link type to file configuration'
  echo ''
	wp option update image_default_link_type file --path=$PROJECT_DIR

  echo ''
	echo 'Disable year/month folders for uploads'
  echo ''
	wp option update uploads_use_yearmonth_folders false --path=$PROJECT_DIR

  echo ''
  echo 'set GMT offset to 1' 
  echo ''
  wp option update gmt_offset 1 --path=$PROJECT_DIR

	echo ''
	echo 'Disable smilies'
  echo ''
	wp option update use_smilies false --path=$PROJECT_DIR

  echo ''
	echo 'Disable pings'
  echo ''
	wp option update default_ping_status false --path=$PROJECT_DIR
	wp option update default_pingback_flag false --path=$PROJECT_DIR
  
  echo ''
	echo 'Empty ping sites' 
  echo ''
  wp option update ping_sites '' --path=$PROJECT_DIR
  
  echo ''
	echo 'Disable comments'
  echo ''
	wp option update default_comment_status false --path=$PROJECT_DIR
  
  echo ''
	echo 'Empty Blog slogan'
  echo ''
  wp option update blogdescription '' --path=$PROJECT_DIR

  echo ''
	echo 'Set medium image size to 768px max'
  echo ''
	wp option update medium_size_w 768 --path=$PROJECT_DIR
	wp option update medium_size_h 768 --path=$PROJECT_DIR

  echo ''
  echo 'Delete sidebar widget'
  echo ''
  wp widget delete search-1 recent-posts-1 recent-comments-1 archives-1 categories-1 meta-1 
  wp widget delete search-2 recent-posts-2 recent-comments-2 archives-2 categories-2 meta-2

  echo ''
  echo 'Configure folders rights'
  echo ''
	chmod 777 -R $PROJECT_DIR/wp-content/uploads

  echo ''
  echo 'Create Base Pages'
  echo ''
  wp post create --post_type=page --post_title='Home'   --post_status=publish           &&
  wp post create --post_type=page --post_title='About' --post_status=publish            &&
  wp post create --post_type=page --post_title='Blog'   --post_status=publish           &&
  wp post create --post_type=page --post_title='Contact'  --post_status=publish         &&
  wp post create --post_type=page --post_title='Legal notices'  --post_status=publish   &&
  wp post create --post_type=page --post_title='Privacy policy'  --post_status=publish   &&

  echo ''
  echo 'assign front to home'
  echo ''
  wp option update show_on_front 4                                                      &&

  echo ''
  echo 'assign posts to blog'
  echo ''
  wp option update page_for_posts 6                                                     &&
  
  echo ''
  echo 'Create the menu - This may fail...'
  echo ''
  wp menu create "main-menu"                                                            &&
  wp menu item add-post main-menu 4                                                     &&
  wp menu item add-post main-menu 5                                                     &&
  wp menu item add-post main-menu 6                                                     &&
  wp menu item add-post main-menu 7                                                     &&
  wp menu location assign main-menu primary
  
  clear                                                                                 
  echo ''                                                                               
  echo "Generate 5 Random Posts..."                                                     
  echo ''                                                                               
  curl --silent  http://loripsum.net/api/5 | wp post generate --post_content --count=5  &&
  
  clear 
  echo ''                                                                               
  echo 'rewrite permalinks structure'                                                                               
  echo ''                                                                               
  wp rewrite structure "/%postname%/" --hard  &&
  wp rewrite flush --hard                     &&

  clear 
  echo ''                                                 
  echo 'categories and tag base update'
  echo ''  
  wp option update category_base theme        &&
  wp option update tag_base subject           &&

  clear
  echo ''
  echo 'Hard Clean...'
  echo ''
  rm -Rf .DS_Store                          &&
  rm -Rf __MACOSX                           &&
  rm -Rf wp-content/themes/twentyfifteen    &&
  rm -Rf wp-content/themes/twentysixteen    &&
  rm -Rf wp-content/themes/twentyseventeen  &&
  rm -Rf wp-content/themes/twentynineteen   &&
  rm -Rf wp-content/themes/twentytwenty     &&
  rm -Rf wp-content/plugins/akismet         &&
  rm -Rf wp-config-sample.php
};

create_readme() {
  touch STUDIO60_README.txt &&
  echo ''                                                                > STUDIO60_README.txt 	 &&
  echo '/*'                                                             >> STUDIO60_README.txt 	 &&
  echo '# ----------------------------------------------------------'   >> STUDIO60_README.txt 	 &&
  echo '# '                                                             >> STUDIO60_README.txt 	 &&
  echo '# Studio60 - Sixty THEME'                                       >> STUDIO60_README.txt 	 &&
  echo "# Project name :'$PROJECT_NAME'"                                >> STUDIO60_README.txt 	 &&
  echo '# ----------------------------------------------------------'   >> STUDIO60_README.txt 	 &&
  echo '# '                                                             >> STUDIO60_README.txt 	 &&
  echo "# Project directory :'$PROJECT_DIR'"                            >> STUDIO60_README.txt 	 &&
  echo "# Project url:'$SITE_URL'"                                      >> STUDIO60_README.txt 	 &&
  echo "# Theme directory :'$SITE_THEME_DIR'"                           >> STUDIO60_README.txt 	 &&
  echo "# Theme url :'$SITE_THEME_URL'"                                 >> STUDIO60_README.txt 	 &&
  echo '# '                                                             >> STUDIO60_README.txt 	 &&
  echo '# ----------------------------------------------------------'   >> STUDIO60_README.txt 	 &&
  echo '*/'                                                             >> STUDIO60_README.txt   &&
  clear &&
  cat STUDIO60_README.txt 

};

gulp_install() {
  clear                                                                                 
  echo ''                                                                               
  echo 'wpgulp installation...'                                                     
  echo ''
  cd $SITE_THEME_DIR &&
  npx wpgulp && 

  echo "projectURL: '$SITE_URL'," 		>		wpgulp_proxy.txt   &&
  LINE_TO_SWITCH=$(sed -n '1p' wpgulp_proxy.txt)	;
  grep -v "projectURL" wpgulp.config.js		>		wpgulp.tmp &&
  awk -v n=13 -v  s="$LINE_TO_SWITCH" 'NR == n {print s} {print}' wpgulp.tmp > wpgulp.config.js		 &&
  rm -Rf wpgulp.tmp	&&
  rm -Rf wpgulp_proxy.txt
    
  cd $PROJECT_DIR
}

install_project() {
  cd $PROJECT_DIR &&

  wp_download &&

  wp_setup &&

  wp_install &&

  wp_install_fr &&

  sixty_theme_download && 

  sixty_theme_screenshot && 

  sixty_theme_config && 

  wp_config  &&

  create_readme &&

  gulp_install &&

  npm init -y &&
  git init ;
 
  clear ; 
  echo 
  echo "Operation terminated"
  echo 
  echo "New wordpress website $PROJECT_NAME created";
  echo 'Start the dev server like this :'
  echo "cd '$SITE_THEME_DIR' && npm start" 
  echo "Happy hacking ❤️ " 
  echo ''
}
build_project() {
	sleep 1;
	clear
	mkdir $PROJECT_NAME;
	echo -n;
	echo "Création du site $PROJECT_NAME...";
	echo -n;
	sleep 1;  
};

choose_project_name() {
	if [ "$PROJECT_NAME" = "" ]; then
  PROJECT_NAME=$(echo wp_project$NOW) 
  build_project &&
  install_project 
	else
  build_project &&
  install_project 
	fi
};

do_start() {
	clear
	cd $WPLAB_DIR;
	if ask "Create a new Wordpress site ?" Y; then
  read -p "what is the name of your project ? spaces and special characters not allowed..." PROJECT_NAME
  choose_project_name 
	else
  echo 'bye'
	fi
};

case "$1" in
	start)
  do_start
	;;
	*)
  echo "Usage: $0 {start}" >&2
  exit 3
	;;
esac

exit 0
