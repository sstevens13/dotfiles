#############################################################################################################################################
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Web Development
#  9.   Git
# 10.   ssh
# 11.   edc-web
#
#############################################################################################################################################

#############################################################################################################################################
#   1.  ENVIRONMENT CONFIGURATION
#   -----------------------------------------------------------------------------------------------------------------------------------------

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   Set Paths
#   -----------------------------------------------------------------------------------------------------------------------------------------

    export PATH="/usr/local/bin:$PATH"
    export JAVA_HOME=$(/usr/libexec/java_home)
    export AWS_ELASTICACHE_HOME="/Users/sstevens/dev_tools/AmazonElastiCacheCli-1.9.001"
    export PATH="$PATH:$AWS_ELASTICACHE_HOME/bin"
    export PATH="$PATH:$HOME/.rvm/bin"
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
    export FIREFOXBINPATH="/Applications/Firefox.app/Contents/MacOS/firefox-bin"
    export CHROMEBINPATH="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    export PATH=$PATH:$FIREFOXBINPATH:$CHROMEBINPATH

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   Set Default Editor
#   -----------------------------------------------------------------------------------------------------------------------------------------
    export EDITOR=/usr/bin/vim

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   -----------------------------------------------------------------------------------------------------------------------------------------
    export BLOCKSIZE=1k

#############################################################################################################################################
#   2.  MAKE TERMINAL BETTER
#   -----------------------------------------------------------------------------------------------------------------------------------------

cdpr () { cd ~/axon/projects/"$1"; }          # cdp: start cd ~/axon/projects
alias uuid='uuidgen'                          # generate uuid
alias guid='uuidgen'                          # generate uuid

alias cp='cp -iv'                             # Preferred 'cp' implementation
alias mv='mv -iv'                             # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                       # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                         # Preferred 'ls' implementation
alias ls='ls -G'                              # Preferred 'ls' implementation
alias less='less -FSRXc'                      # Preferred 'less' implementation
alias cd..='cd ../'                           # Go back 1 directory level (for fast typers)
alias ..='cd ../'                             # Go back 1 directory level
alias ...='cd ../../'                         # Go back 2 directory levels
alias .3='cd ../../../'                       # Go back 3 directory levels
alias .4='cd ../../../../'                    # Go back 4 directory levels
alias .5='cd ../../../../../'                 # Go back 5 directory levels
alias .6='cd ../../../../../../'              # Go back 6 directory levels
alias f='open -a Finder ./'                   # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                                # ~:            Go Home
alias c='clear'                               # c:            Clear terminal display
alias which='type -all'                       # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'           # path:         Echo all executable Paths
alias show_options='shopt'                    # Show_options: display bash options settings
alias fix_stty='stty sane'                    # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'     # cic:          Make tab-completion case-insensitive
alias showfiles='defaults write com.apple.finder AppleShowAllFiles'           # show all files in finder [showfiles yes], hide files [showfiles no]
mcd () { mkdir -p "$1" && cd "$1"; }          # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }       # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }      # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'      # DT:           Pipe content to file on MacOS Desktop

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   lr:  Full Recursive Directory Listing
#   -----------------------------------------------------------------------------------------------------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   showa: to remind yourself of an alias (given some part of it)
#   -----------------------------------------------------------------------------------------------------------------------------------------
showa () { /usr/bin/grep --color=always -i -a1 $@ ~/.bashrc | grep -v '^\s*$' | less -FSRXc ; }


#############################################################################################################################################
#   3.  FILE AND FOLDER MANAGEMENT
#   -----------------------------------------------------------------------------------------------------------------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   extract:  Extract most know archives with one command
#   -----------------------------------------------------------------------------------------------------------------------------------------
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

#############################################################################################################################################
#   4.  SEARCHING
#   -----------------------------------------------------------------------------------------------------------------------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------------------------------------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#############################################################################################################################################
#   5.  PROCESS MANAGEMENT
#   -----------------------------------------------------------------------------------------------------------------------------------------


#############################################################################################################################################
#   6.  NETWORKING
#   -----------------------------------------------------------------------------------------------------------------------------------------


#   -----------------------------------------------------------------------------------------------------------------------------------------
#   ii:  display useful host related informaton
#   -----------------------------------------------------------------------------------------------------------------------------------------
    ii() {
        echo
    }


#############################################################################################################################################
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   -----------------------------------------------------------------------------------------------------------------------------------------

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -----------------------------------------------------------------------------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#############################################################################################################################################
#   8.  WEB DEVELOPMENT
#   -----------------------------------------------------------------------------------------------------------------------------------------

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   httpDebug:  Download a web page and show info on what took time
#   -----------------------------------------------------------------------------------------------------------------------------------------

httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

#############################################################################################################################################
#   9. Git
#   -----------------------------------------------------------------------------------------------------------------------------------------
source ~/.git-completion.bash

alias gitls='git branch -a --sort=committerdate'          # git list branches
alias gitrml='git branch -D'                              # git delete branch locally
alias gitrmr='git push srs --delete'                      # git delete branch in remote (my fork)
alias gitunadd='git reset HEAD'                           # git remove file from commit
alias gitsyncum='git checkout master; git fetch origin; git pull origin master; git push --force srs master'       # git sync forked master with origin Master
alias gitcd='git checkout'                                # git checkout branch (Change Directory)
alias gitmkdl='git checkout -b'                           # git make branch locally (MaKe DIRectory)
alias gitmkdo='git push -u srs'                           # git make branch in origin (MaKe DIRectory)
alias gitunadd='git reset HEAD'                           # git remove added listed files or all added files
alias gitfp='git fetch -p origin; git fetch -p srs'       # git fetch & prune remote branches in base and personal repositories
alias gitlog='git log --oneline --graph --decorate'       # show commit history with graph, decorate with commit details
alias gituncommitlocal='git reset --soft HEAD~1'          # undo last commit, don't discard commited changes 

source ~/.axon.bash

