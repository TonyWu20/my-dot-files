set --export LC_CTYPE en_US.UTF-8
set --export LC_ALL en_US.UTF-8
set --export LANG en_US.UTF-8
set --export OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

alias vim "/opt/homebrew/bin/nvim"
alias ls "colorls --gs --sort-dirs"
alias lc "colorls --tree=2 -t"
alias icat "kitty +kitten icat"

set --export FZF_DEFAULT_OPTS '--ansi --preview "if test -f {}; bat --style=numbers --color=always {};else if test -d {}; colorls --tree=2 -t {} |less ;else;echo {} 2> /dev/null | head -200 | fold;end" --height 80% --reverse --border --preview-window bottom:67%'
set --export FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore --color=always'
set --export LAMMPS_POTENTIALS '/usr/local/share/lammps/potentials'
fish_vi_key_bindings
alias vimtex 'NVIM_LISTEN_ADDRESS=/tmp/nvim vim'
#alias vlc '/Applications/VLC.app/Contents/MacOS/VLC'
set -g -x fish_user_paths /opt/homebrew/bin /opt/homebrew/opt/ruby/bin /opt/homebrew/lib/ruby/gems/2.7.0/bin /Users/tonywu/.cargo/bin /Users/tonywu/.rustup/toolchains/nightly-aarch64-apple-darwin/bin /opt/homebrew/lib/python3.9/site-packages /usr/sbin /bin /sbin /Library/TeX/texbin /usr/local/bin /usr/local/gfortran/bin /usr/bin 

function chrome --wraps chrome --description "Open Chrome Browser"
	'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' $argv
end

function fp
	fzf --ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'
end

starship init fish | source

#function YT
	#$HOME/.yabai_toggle.sh
#end

function lammps
	mpirun -np 4 lmp -in $argv
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

function lmp_batch
	set -l number 0
	set -l total (/bin/ls -d $argv |wc -l)
	for d in (/bin/ls -d $argv)
		cd $d && set -l number (math $number + 1) && bash ~/spinner.bash $number $total $d && mpirun -np 4 lmp -in in.* -sf omp -pk omp 1 > ../log.txt && cd ..
	end
	rm log.txt
	printf "Jobs done"
end

function update_fig
	set -l pdir "/Users/tonywu/Library/Mobile Documents/com~apple~CloudDocs/Programming/TM_lammps/high_index/model_files"
	rm $pdir/persp_fig/* && rm $pdir/top_fig/*
	rsync -avzP **/$argv[1]/**/*top_sf.png top_fig/ && rsync -avzP **/$argv[1]/**/*perp_lgn_sf.png persp_fig/
	rename s/$argv[2]/Pt/ *_fig/*
end

function reco2 $argv[1] $argv[2]
	rename s/_$argv[1]_opt/_$argv[1]_$argv[2]_opt/ $argv[2]/*  ;rename s/_$argv[1]\\./_$argv[1]_$argv[2]./ $argv[2]/**/* ; rename s/_$argv[1]_DOS/_$argv[1]_$argv[2]_DOS/ $argv[2]/**/* 
end 

function rn_ads
	for d in (/bin/ls -d $argv)
		cd $d;
		for item in (/bin/ls -d *)
			reco2 $d $item
		end
		cd ..
	end
end
