##### color style
ctrue="\[\e[1;32m\]"
cfalse="\[\e[1;31m\]"
cnormal="\[\e[1;0m\]"
cbtrue="\e[1;32m"
cbfalse="\e[1;31m"
cbnormal="\e[1;0m"
cblulight="\[\e[1;94m\]"
cblu="\[\e[1;34m\]"
cpurp="\[\e[1;35m\]"
cfonbold="\[\e[1;30m\]"
cfon="\[\e[1;36m\]"
cfon2="\[\e[1;90m\]"

##### set path
PATH=$PATH:/sbin:/usr/sbin:$HOME/.cabal/bin:/usr/bin:/bin:/sbin:$HOME/programs/activetcl/bin:/usr/local/heroku/bin
. $HOME/.git-prompt.sh

##### set vars
res=\$?
sstart=$(printf "\342\226\266")
strue=$(printf "\342\227\274")
sfalse=$(printf "\342\227\274")

##### set PS1
PS1="${cblu}\u${cnormal}${cblulight}@${cnormal}${cpurp}\h${cnormal}${cblulight}:${cnormal}${cfonbold}[${cnormal}${cfon}\w${cnormal}${cfonbold}]${ctrue}\$(__git_ps1)${cnormal} ${cfon2}\! \# ${cnormal}${cfon2}\t${cnormal}
\$(if [[ \$? -eq 0 ]]; then echo -e '\[\e[1;32m\]${strue}\[\e[0m\]'; else echo -e '\[\e[1;31m\]${sfalse}\[\e[0m\]'; fi) ${cblulight}${sstart}${cnormal} "

##########
alias devt="devtodo --database ~/Dropbox/todo"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin
