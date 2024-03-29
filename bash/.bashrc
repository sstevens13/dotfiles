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
# 10.   Frontend, React
#
#############################################################################################################################################

#############################################################################################################################################
#   1.  ENVIRONMENT CONFIGURATION
#   -----------------------------------------------------------------------------------------------------------------------------------------

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   Set Paths
#   -----------------------------------------------------------------------------------------------------------------------------------------

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)
export AWS_ELASTICACHE_HOME="/Users/sstevens/dev_tools/AmazonElastiCacheCli-1.9.001"
export PATH="$PATH:$AWS_ELASTICACHE_HOME/bin"
export FIREFOXBINPATH="/Applications/Firefox.app/Contents/MacOS/firefox-bin"
export CHROMEBINPATH="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
export PATH=$PATH:$FIREFOXBINPATH:$CHROMEBINPATH

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

alias j17='export JAVA_HOME=$(/usr/libexec/java_home -v 17)'

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   Set Default Editor
#   -----------------------------------------------------------------------------------------------------------------------------------------

export EDITOR=/usr/bin/vim

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   -----------------------------------------------------------------------------------------------------------------------------------------

export BLOCKSIZE=1k

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   Set Prompt
#   -----------------------------------------------------------------------------------------------------------------------------------------

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] > "
export PS2="> "

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   add spellcheck
#   -----------------------------------------------------------------------------------------------------------------------------------------

shopt -s cdspell

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   Add work settings
#   -----------------------------------------------------------------------------------------------------------------------------------------

source ~/.work.bash


#############################################################################################################################################
#   2.  MAKE TERMINAL BETTER
#   -----------------------------------------------------------------------------------------------------------------------------------------

alias uuid='uuidgen'                          # generate uuid
alias guid='uuidgen'                          # generate uuid
alias formatUuid='~/dotfiles/formatUuid.sh'   # format uuid

alias ipaddress='curl ifconfig.co'            # get my ipaddress

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
alias fix_stty='stty sane'                    # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'     # cic:          Make tab-completion case-insensitive
alias showfiles='defaults write com.apple.finder AppleShowAllFiles'           # show all files in finder [showfiles yes], hide files [showfiles no]
mcd () { mkdir -p "$1" && cd "$1"; }          # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }       # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }      # ql:           Opens any file in MacOS Quicklook Preview
alias sout='tee ~/Desktop/terminalOut.txt'    # sout:         Save Output to file on MacOS Desktop


#   -----------------------------------------------------------------------------------------------------------------------------------------
#   lr:  Full Recursive Directory Listing
#   -----------------------------------------------------------------------------------------------------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   -----------------------------------------------------------------------------------------------------------------------------------------
#   showa: to remind yourself of an alias (given some part of it)
#   -----------------------------------------------------------------------------------------------------------------------------------------
showa () { /usr/bin/grep --color=always -i -a1 $@ ~/.bashrc ~/.work.bash | grep -v '^\s*$' | less -FSRXc ; }


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
searchText () { grep -inr "$@" . ; }        # searchText: search current directly recursively for text, ignore case

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
alias ip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"


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

alias gitls='git branch -a --sort=committerdate'          # git list branches
alias gitrml='git branch -D'                              # git delete branch locally
alias gitrmr='git push srs --delete'                      # git delete branch in remote (my fork)
alias gitunadd='git reset HEAD'                           # git remove file from commit
alias gitpm='git checkout master; git pull origin master; git fetch -p'    # pull master, prune
alias gitcd='git checkout'                                # git checkout branch (Change Directory)
alias gitmkdl='git checkout -b'                           # git make branch locally (MaKe DIRectory)
alias gitfp='git fetch -p origin;'                        # git fetch & prune remote branches in base and personal repositories
alias gitlog='git log --oneline --graph --decorate'       # show commit history with graph, decorate with commit details
alias gituncommitlocal='git reset --soft HEAD~1'          # undo last commit, don't discard commited changes
alias gitPasswd='git config --global credential.helper osxkeychain'        # update password on next git command that needs validation

# use git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#############################################################################################################################################
#   10. Frontend, React
#   -----------------------------------------------------------------------------------------------------------------------------------------
alias yarnStop='yarn flow stop; yarn'
alias yarnFix='lerna clean -y && rm -rf node_modules && yarn'
alias yarnPrCheck='yarn test --all; yarn run strings; yarn lint; yarn typecheck --packages edc-web'



#############################################################################################################################################
#   10. intellij failure fix
#   -----------------------------------------------------------------------------------------------------------------------------------------
alias intellij='/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea &'
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#############################################################################################################################################
#   11. echo-ed stuff
#   -----------------------------------------------------------------------------------------------------------------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
