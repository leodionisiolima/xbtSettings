# Redefinir variáveis se não estivermos em um shell interativo
if [ -z "$PS1" ]; then
    unset PROMPT_COMMAND
fi

# ⚙️ Starship + Zoxide + Prompt seguro e idempotente

export STARSHIP_CONFIG=~/.config/starship.toml

# injeta Zoxide, sem sobrescrever PROMPT_COMMAND
_zoxide_init_raw="$(zoxide init bash)"
_zoxide_clean="$(echo "$_zoxide_init_raw" | grep -v '^PROMPT_COMMAND=')"
eval "$_zoxide_clean"

# guarda o valor anterior do PROMPT_COMMAND (antes do Starship)
_original_pc="$PROMPT_COMMAND"

# injeta Starship se ainda não estiver hookado
if [[ "$PROMPT_COMMAND" != *starship_precmd_user_func* ]]; then
    eval "$(starship init bash)"
    echo "✅ Starship init executado" >> /tmp/starship_log.txt
fi

# restaura os hooks anteriores se forem perdidos
[[ "$PROMPT_COMMAND" != *history\ -a* ]] && PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a"

# remove duplicatas finais (estético, opcional)
PROMPT_COMMAND=$(echo "$PROMPT_COMMAND" | awk -v RS=';' '!a[$1]++' ORS=';' | sed 's/;$//')


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

force_color_prompt=yes

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

export TERM='xterm-256color'

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#Isso é pra poder digitar quit no terminal e ele fechar
quit() {
    exit
}


#Isso aqui tem a ver com o nodeJS, e o gerenciador de pacotes dele, foi o Leonardo que instalou

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm" ] && \. "$NVM_DIR/nvm"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#COISAS QUE O LEONARDO FEZ

#Aliases de Git
alias gb='git branch'

alias gs='git status'

alias gl='git log'

alias ga='git add'

alias gps='git push'

alias gpl='git pull'

alias gc='~/bin/gitWrapper/gc'

alias gx='git add . && git commit -m "sincronizando diretório via gx" && git push origin main'

alias gpsx='ga . && gc "debug" && gps origin debug'

#Aliases gerais
alias iotop='sudo iotop'

alias nano='micro'

#alias apt='/home/leo/bin/aptWrapper/aptWrapper'

sbrc() {
    local prev_dir="$PWD"
    cd || return
    source ~/.bashrc
    cd "$prev_dir" > /dev/null || return
    echo -e "\e[1;32mbashrc sourced, yay! :D\e[0m"
}

bashrc() {
    local prev_dir="$PWD"
    cd || return
    micro .bashrc
    source ~/.bashrc
    cp ~/.bashrc ~/bin/.bashrc
    cd "$prev_dir" > /dev/null || return
    echo -e "\e[1;32mbashrc sourced, and BIN.BASHRC UPDATED, yay! :D\e[0m"
}

alias dimmer='~/bin/dimmer/dimmer'

alias lvim='/home/leo/.local/bin/lvim'

alias lv='/home/leo/.local/bin/lvim'

alias battery='~/bin/battery/battery'

alias sgpt='~/bin/sgpt/sgpt'

alias sgptg='/home/leo/bin/sgptg/sgptg'

alias numerador='~/bin/h2t/numeradorLinhas/numeradorLinhas'

alias bin='cd ~/bin'

alias h2t='/home/leo/bin/h2t/h2t'

alias hello='$HOME/bin/hello/hello'

alias hi='hello'

alias sheet='/usr/lib/libreoffice/program/soffice.bin --calc'

alias balena='/home/leo/Downloads/balenaEtcher-linux-x64/balena-etcher'

alias upup='~/bin/upup/upup'

alias genymotion='~/Programs/genymotion/genymotion'

treeAW() {
    local prev_dir="$PWD"
    cd ~/Projects/adwave || return
    tree -d -I 'node_modules|dist'
    cd "$prev_dir" > /dev/null || return
}

alias bat='batcat'

alias exa='exa --icons'

alias ls='exa --icons'

alias example='tldr'

mkcd() {
    mkdir -p "$1" && cd "$1"
}

alias whitenoise='~/bin/whitenoise/whitenoise'

alias daemonify='~/bin/daemonify/daemonify'

alias daemon='daemonify'

alias POWEROFF='poweroff'

alias REBOOT='reboot'

obsidian() {
    nohup flatpak run md.obsidian.Obsidian >/dev/null 2>&1 &
    disown
}

alias teste='~/bin/newTestEnv/newTestEnv'

task() {
    python3 ~/Projects/dynamicTasks/src/main.py "$@" | exec less -R
}


alias comando='micro ~/.comando'

alias cmbkres='$HOME/bin/cmbkRes/cmbkRes'

alias concatenate='$HOME/bin/xubuntuConfig/meta/concatenate'

alias conac='concatenate'

alias metronome='flatpak run com.adrienplazas.Metronome && \'

alias btop='sudo btop'

alias block='$HOME/bin/block/block'

alias unblock='$HOME/bin/block/unblock'

alias sl='ls'

alias wezterm="LD_LIBRARY_PATH=$HOME/Programs/libssl1.1/usr/lib/x86_64-linux-gnu/ $HOME/Programs/wezterm/wezterm"

alias snapshot="$HOME/bin/snapshoting/snapshoting"

alias esbx='$HOME/bin/xubuntuConfig/modules/sandboxing/.run'

alias esbx2='sudo unshare --uts --mount --ipc --pid --fork chroot ~/sandbox/sandbox000 /bin/bash'

alias cesbx='cd $HOME/bin/xubuntuConfig/modules/sandboxing && $HOME/concatenateEsbx && cd -'

alias fixcomposeforever='$HOME/bin/fixComposeForever/fixComposeForever2'

alias fixc='fixcomposeforever && exit'

alias lmstudio='nohup ~/Programs/LMStudio/LM-Studio-0.3.15-11-x64.AppImage > /dev/null 2>&1 & disown'

alias tg='/opt/google/chrome/google-chrome --profile-directory=Default --app-id=cadlkienfkclaiaibeoongdcgmdikeeg && exit'

alias logseq='setsid ~/Programs/Logseq/Logseq-linux-x64-0.10.11.AppImage > /dev/null 2>&1 &'

alias sortContent='du -h --max-depth=1 | sort -hr'

alias tree='tree -F'

################# NÃO MOVER NEM MEXER O QUE VEM ABAIXO ####################

export LANG=C.UTF-8

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
