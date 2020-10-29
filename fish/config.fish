set --export LC_CTYPE en_US.UTF-8
set --export LC_ALL en_US.UTF-8
set --export LANG en_US.UTF-8
set --export OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

alias vim "/usr/local/bin/nvim"
alias ls "colorls --gs --sort-dirs"
alias lc "colorls --tree=2 -t"

set --export FZF_DEFAULT_OPTS --height 80% --reverse --border
set --export FZF_DEFAULT_COMMAND 'rg --files'
set --export LAMMPS_POTENTIALS '/usr/local/share/lammps/potentials'
fish_vi_key_bindings
alias vimtex 'NVIM_LISTEN_ADDRESS=/tmp/nvim vim'
alias vlc '/Applications/VLC.app/Contents/MacOS/VLC'

function brave --wraps brave --description "Open Brave Browser"
	/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser $argv
end

function fp
	fzf --ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'
end
starship init fish | source

function YT
	$HOME/.yabai_toggle.sh
end

function remotedesktop
	brew services stop yabai && open "$HOME/Applications/Chrome Apps.localized/Chrome Remote Desktop.app" && brew services start yabai && sleep 3 && yabai -m window --space next && yabai -m space --focus next
end

function ris2bib
	set name (echo $argv|rg --pcre2 '\S+(?=.ris)' -o |sed 's#\\n##g')
	ris2xml $name.ris | xml2bib > $name\_temp.bib -b
	cat $name\_temp.bib |sed -e "/month.*/d" -e "/day.*/d" |sed -E "s/(@Article{[a-zA-Z]+)([0-9])/\1:\2/" > $name.bib
	rm $name\_temp.bib
	set -e name
end
