# ----------
# 0 : PATH 
# ----------
PATH="$PATH:/usr/local/bin/"
export PATH="/usr/local/git/bin:/sw/bin/:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
PHP_VERSION=$(ls /Applications/MAMP/bin/php/ | sort -n | tail -1)
export PATH=/Applications/MAMP/bin/php/${PHP_VERSION}/bin:$PATH
# ----------
# S60 Lab
# ----------
NOW=$(date +.%d_%h_%Y-%H%M%S)
#
LOCALHOST=$(echo '127.0.0.1:')
APACHE_PORT=$(cat /Applications/MAMP/conf/apache/httpd.conf | grep ^Listen | tr -d [A-Z][a-z][:space:] | cat)
LOCALHOST_APACHE_ADDRESS=$(echo $LOCALHOST$APACHE_PORT)
SULACODIR=$(echo '/Volumes/Data/')
STUDIO60SULACODIR=$(echo '/Volumes/Data/STUDIO60')
STUDIO60DIR=$(echo '~/STUDIO60/')
alias sulaco='cd $SULACODIR ; ls ; open . '
alias studio60_data='cd $STUDIO60SULACODIR ; ls ; open . '
alias studio60='cd ~/STUDIO60/  ; ls ; open . '
alias GatsbyStart='gatsby develop -H 0.0.0.0 -p 8000'
alias Editor='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
#
# WP_ADMIN_URL=$(echo /wplab/wp-admin/)
# WP_LAB_URL=$(echo /wplab/wp-content/sites/)
WP_LAB_DIR=$(echo /Applications/MAMP/htdocs/wplab/)
#
alias now="(echo $NOW)"
alias mamp_init="/Applications/MAMP/MAMP.app/Contents/MacOS/MAMP"

alias 60_wp='cd ~/STUDIO60/wordpress ; ls -lash ;'
alias 60_hugo='cd ~/STUDIO60/hugo ; ls -lash ;'
alias 60_wp_new='~/STUDIO60/wordpress/install-script.sh start;'

# alias wpcli='php /Applications/MAMP/bin/php/${PHP_VERSION}/bin/wp-cli.phar'
alias wplab_finder=' cd ${WP_LAB_DIR} &&  open .'
alias wplab_webview="Firefox  -P "DEVLAB" -url '${LOCALHOST_APACHE_ADDRESS}${WP_LAB_URL}'"
alias wplab_init=' mamp_init && wplab_webview '
alias wplab='cd ${WP_LAB_DIR} ; ls * '
#
#
#   1 : Resources
#
d=`date +%m-%d-%Y`
function waiting {
	sleep 1
}
#
spinner()
{
	local pid=$!
	local delay=0.4
	local spinstr='|/-\'
	while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
		local temp=${spinstr#?}
		printf " [%c]  " "$spinstr"
		local spinstr=$temp${spinstr%"$temp"}
		sleep $delay
		printf "\b\b\b\b\b\b"
	done
	printf "    \b\b\b\b"
}
#
# Prompt
#
export PS1="________________________________________________________________________________\n
| \w @ \h (\u) \n| => "
export PS2="| => "


# VSCODE
# alias Editor="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
# ATOM
alias Atom="/Applications/Atom.app/Contents/MacOS/Atom"
# WEB
alias Firefox="/Applications/FirefoxDeveloperEdition.app/Contents/MacOS/firefox "
alias Chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "
alias Safari="/Applications/Safari.app/Contents/MacOS/Safari "
alias Opera="/Applications/Opera.app/Contents/MacOS/Opera"
#
alias Live10="/Applications/Ableton\ Live\ 10\ Suite.app/Contents/MacOS/Live"
#vlc
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC -I rc '
alias play="vlc volume 100"
alias VOX='/Applications/VOX.app/Contents/MacOS/VOX'
alias radioFculture='vlc http://fculture.duzob.fr/32'
alias radioFinter='vlc http://finter.duzob.fr/32'
alias radioFinfo='vlc http://finfo.duzob.fr/32'
alias radioUKBass='vlc http://94.76.216.200:8210'
alias radioSocialLightRadio='vlc http://uk5.internet-radio.com:8318/live.m3u'
alias radioSynthwaveRetrowaveRadioCh2='vlc http://139.162.14.151:8006/'
alias radioDanceChannelPlus='vlc http://151.80.44.127:8589/listen.pls?sid=1 '
alias radioYesProgressive='vlc http://95.154.254.151:22192/listen.pls?sid=1'
alias radioRFI='vlc  http://www.rfi.fr/emission/radio-foot-internationale/podcast'
alias radioRMC='vlc  http://rmc.bfmtv.com/rmcinfo-mp3'
alias radioRTL='vlc  http://streaming.radio.rtl.fr/rtl-1-24-24.aac'
alias radioRTS1='vlc http://stream.srg-ssr.ch/m/la-1ere/aacp_32'
alias radioCouleur3='vlc http://stream.srg-ssr.ch/m/couleur3/aacp_32'
alias radioDNB='vlc http://dnbstation.com:8000/'
alias radioCB='vlc http://contrabanda.org/audio/contrabanda.m3u'
#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------
alias delete='rm -Rf'
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias f='open -a Finder ./'                 # f: Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias ttop="top -R -F -s 10 -o rsize"
#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
#   -------------------------------
#   3. FILE AND FOLDER MANAGEMENT
#   -------------------------------

#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/vim
    export BLOCKSIZE=1k
zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   ---------------------------
#   4. SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6. NETWORKING
#   ---------------------------

#alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }


#   ---------------------------------------
#   7. SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   ---------------------------------------
#   8. WEB DEVELOPMENT
#   ---------------------------------------

alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs

httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }


#   ---------------------------------------
#   9. REMINDERS & NOTES
#   ---------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

