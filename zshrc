# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/TonyWu/.oh-my-zsh"
export DYLD_LIBRARY_PATH='/Users/TonyWu/Downloads/lammps/src:/usr/lib:/usr/local/lib/:/usr/local/lib/openmpi/'
export LD_LIBRARY_PATH='/usr/lib:/usr/local/lib/:/usr/local/lib/openmpi/'
export LAMMPS_POTENTIALS='/usr/local/share/lammps/potentials'
export PATH="$PATH:/Users/TonyWu/Downloads/moltemplate/moltemplate:/Users/TonyWu/Downloads/moltemplate/moltemplate/scripts:/Users/TonyWu/Library/Mobile Documents/com~apple~CloudDocs/Programming/Python/DOS:/Users/TonyWu/go/bin:/Applications/Blender.app/Contents/MacOS:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:/usr/local/Cellar/bin/"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME=powerlevel10k/powerlevel10k
eval "$(starship init zsh)"
#ZSH_THEME="common"
PROMPT='$(nice_exit_code) %n@%m > '

alias ls='colorls --gs --sort-dirs '
alias lc='colorls --tree=2 -t'
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status load background_jobs time)
#POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
#DEFAULT_USER="\U1F5A5"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode nice-exit-code)

source $ZSH/oh-my-zsh.sh
export EDITOR="nvim"
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias vim="/usr/local/bin/nvim"


[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export TERM="xterm-256color"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fp() {fzf --ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'
}

#fd {
 #local dir
 #dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d \
      #-print 2> /dev/null | fzf +m) &&
 #cd "$dir"
#}
#Command history
fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
# Find in files
 fif() {
	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
	rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
f() {
	sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
	test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}
cf() {
	local file
	file="$(locate -Ai -0 $@ | grep -Z -vE '~$' | fzf --read0 -0 -1)"
	 if [[ -n $file ]]
	 then
	    if [[ -d $file ]]
	    then
	       cd -- $file
	    else
	       cd -- ${file:h}
	    fi
	 fi
}
cdf() {
	local file
	local dir
	file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && /bin/ls -pG | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p -FG "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}
pdfcompress ()
{
   gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen  -dEmbedAllFonts=true -dSubsetFonts=true -r40 -dColorImageDownsampleType=/Bicubic -dColorImageResolution=40 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=40 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=40 -sOutputFile=$1.compressed.pdf $1;
}
#
remotedesktop ()
{
	brew services stop yabai && open "$HOME/Applications/Chrome Apps.localized/Chrome Remote Desktop.app" && brew services start yabai && sleep 5 && yabai -m window --space next && yabai -m space --focus next
}
YT()
{
	$HOME/.yabai_toggle.sh
}
export LDFLAGS=-L/usr/local/opt/libffi/lib
export CPPFLAGS=-I/usr/local/opt/libffi/include
export LDFLAGS="-L/usr/local/opt/readline/lib"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export CPPFLAGS="-I/usr/local/opt/readline/include"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias vimtex='NVIM_LISTEN_ADDRESS=/tmp/nvim vim'
