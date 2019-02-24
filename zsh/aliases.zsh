alias reload!='. ~/.zshrc'
alias cls='clear' # Good 'ol Clear Screen command
alias start='cmd.exe /c start ""'
alias repos='cd ~/repos'

alias bootstrap='~/repos/dotfiles/script/bootstrap && unalias -m "*" && source ~/.zshrc'

do_vswhere() {
    # https://stackoverflow.com/questions/54820639/how-do-i-create-a-zsh-alias-on-wsl-that-runs-vswhere-exe-and-executes-the-path
    wherePath="$(vswhere.exe -property $1 -latest -format value $2)"
    vsPath=$(wslpath -a "$wherePath")
    # Strip the trailing carriage return, if present
    vsPath="${vsPath%$'\r'}"

    "$vsPath" &
}

devenv_path_ex() {
    do_vswhere productPath
}

devenv_path_p_ex() {
    do_vswhere productPath -prerelease
}

alias devenv=devenv_path_ex
alias devenvp=devenv_path_p_ex

alias bw="powershell.exe ./build.ps1"

alias msaln="cd ~/repos/msalnet"
alias msalc="cd ~/repos/msalcpp"
alias dotfiles="cd ~/repos/dotfiles"


# Print each PATH entry on a separate line
alias path="echo -e ${PATH//:/\\n}"

# Some of these are from: https://raw.githubusercontent.com/voku/dotfiles/master/.aliases

# ------------------------------------------------------------------------------
# | Navigation                                                                 |
# ------------------------------------------------------------------------------

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"       # `cd` is probably faster to type though
alias -- -="cd -"

# fallback by typo
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'

# ------------------------------------------------------------------------------
# | Directories Commands (create / remove)                                     |
# ------------------------------------------------------------------------------

# mkdir: always create parent-dirs, if needed
alias mkdir="mkdir -p"
alias md="mkdir"

# dirs
alias d='dirs -v | head -10'

# rmdir
alias rd="rmdir"

# create a dir with date from today
alias mkdd='mkdir $(date +%Y%m%d)'


# ------------------------------------------------------------------------------
# | List Directory Contents (ls)                                               |
# ------------------------------------------------------------------------------

# list all files colorized in long format
alias l="ls -lhF $COLORFLAG"
# list all files with directories
alias ldir="l -R"
# Show hidden files
alias l.="ls -dlhF .* $COLORFLAG"
alias ldot="l."
# use colors
alias ls="ls -F $COLORFLAG"
# display only files & dir in a v-aling view
alias l1="ls -1 $COLORFLAG"
# displays all files and directories in detail
alias la="ls -laFh $COLORFLAG"
# displays all files and directories in detail (without "." and without "..")
alias lA="ls -lAFh $COLORFLAG"
alias lsa="la"
# displays all files and directories in detail with newest-files at bottom
alias lr="ls -laFhtr $COLORFLAG"
# show last 10 recently changed files
alias lt="ls -altr | grep -v '^d' | tail -n 10"
# show files and directories (also in sub-dir) that was touched in the last hour
alias lf="find ./* -ctime -1 | xargs ls -ltr $COLORFLAG"
# displays files and directories in detail
alias ll="ls -lFh --group-directories-first $COLORFLAG"
# shows the most recently modified files at the bottom of
alias llr="ls -lartFh --group-directories-first $COLORFLAG"
# list only directories
alias lsd="ls -lFh $COLORFLAG | grep --color=never '^d'"
# sort by file-size
alias lS="ls -1FSshr $COLORFLAG"
# displays files and directories
alias dir="ls --format=vertical $COLORFLAG"
# displays more information about files and directories
alias vdir="ls --format=long $COLORFLAG"

# tree (with fallback)
if which tree >/dev/null 2>&1; then
  # displays a directory tree
  alias tree="tree -Csu"
  # displays a directory tree - paginated
  alias ltree="tree -Csu | less -R"
else
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
  alias ltree="tree | less -R"
fi

# ------------------------------------------------------------------------------
# | Search and Find                                                            |
# ------------------------------------------------------------------------------

# super-grep ;)
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# search in files (with fallback)
if which ack-grep >/dev/null 2>&1; then
  alias ack=ack-grep

  alias afind="ack-grep -iH"
else
  alias afind="ack -iH"
fi

# ------------------------------------------------------------------------------
# | Package Managers                                                           |
# ------------------------------------------------------------------------------

# get / check for updates
alias apt-update="sudo apt-get update"
alias apt-upgrade="sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean"

# ------------------------------------------------------------------------------
# | Network                                                                    |
# ------------------------------------------------------------------------------

# external ip address
alias myip_dns="dig +short myip.opendns.com @resolver1.opendns.com"
alias myip_http="GET http://ipecho.net/plain && echo"

# show dns info via "dig"
alias dnsInfo="digga"

# speedtest: get a 100MB file via wget
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip"

# Gzip-enabled `curl`
alias gurl="curl --compressed"

# displays the ports that use the applications
alias lsport='sudo lsof -i -T -n'

# shows more about the ports on which the applications use
alias llport='netstat -nape --inet --inet6'

# show only active network listeners
alias netlisteners='sudo lsof -i -P | grep LISTEN'


# ------------------------------------------------------------------------------
# | Date & Time                                                                |
# ------------------------------------------------------------------------------

# date
alias date_iso_8601='date "+%Y%m%dT%H%M%S"'
alias date_clean='date "+%Y-%m-%d"'
alias date_year='date "+%Y"'
alias date_month='date "+%m"'
alias date_week='date "+%V"'
alias date_day='date "+%d"'
alias date_hour='date "+%H"'
alias date_minute='date "+%M"'
alias date_second='date "+%S"'
alias date_time='date "+%H:%M:%S"'

# stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# ------------------------------------------------------------------------------
# | Hard- & Software Infos                                                     |
# ------------------------------------------------------------------------------

# pass options to free
alias meminfo="free -m -l -t"

# get top process eating memory
alias psmem="ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6"
alias psmem5="psmem | tail -5"
alias psmem10="psmem | tail -10"

# get top process eating cpu
alias pscpu="ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 5"
alias pscpu5="pscpu5 | tail -5"
alias pscpu10="pscpu | tail -10"

# shows the corresponding process to ...
alias psx="ps auxwf | grep "

# shows the process structure to clearly
alias pst="pstree -Alpha"

# shows all your processes
alias psmy="ps -ef | grep $USER"

# the load-avg
alias loadavg="cat /proc/loadavg"

# show all partitions
alias partitions="cat /proc/partitions"

# shows the disk usage of a directory legibly
alias du='du -kh'

# show the biggest files in a folder first
alias du_overview='du -h | grep "^[0-9,]*[MG]" | sort -hr | less'

# shows the complete disk usage to legibly
alias df='df -kTh'


# ------------------------------------------------------------------------------
# | Other                                                                      |
# ------------------------------------------------------------------------------

# decimal to hexadecimal value
alias dec2hex='printf "%x\n" $1'

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# urldecode - url http network decode
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

# urlencode - url encode network http
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# intuitive map function
#
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# make Grunt print stack traces by default
command -v grunt > /dev/null && alias grunt="grunt --stack"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
# alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# php - package-manager - composer
# alias composer-install="composer install --optimize-autoloader"

# add ssh-key to ssh-agent when key exist
if [ "$SSH_AUTH_SOCK" != "" ] && [ -f "~/.ssh/id_rsa" ] && [ -x "/usr/bin/ssh-add"  ]; then
  ssh-add -l >/dev/null || alias ssh='(ssh-add -l >/dev/null || ssh-add) && unalias ssh; ssh'
fi

