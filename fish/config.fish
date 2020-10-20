set --export LC_CTYPE en_US.UTF-8
set --export LC_ALL en_US.UTF-8
set --export FZF_DEFAULT_OPTS '--height 80% --reverse --border'
set --export PATH /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin /home/linuxbrew/.linuxbrew/lib/ruby/gems/2.7.0/bin /home/linuxbrew/.linuxbrew/opt/fzf/bin /usr/bin/bin /home/linuxbrew/.linuxbrew/bin /usr/bin /bin /usr/sbin /sbin
set --export FZF_DEFAULT_COMMAND 'rg --files'
set --export LAMMPS_POTENTIALS '/usr/bin/share/lammps/potentials'
fish_vi_key_bindings
alias vim "/home/linuxbrew/.linuxbrew/bin/nvim"
alias ls "colorls --gs --sort-dirs"
alias lc "colorls --tree=2 -t"
alias pbcopy "xclip -selection clipboard"
alias pbpaste "xclip -selection clipboard -o"
#
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
starship init fish | source
