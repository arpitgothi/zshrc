# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/Users/$(whoami)/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jsontools aliases zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
plugins=(
  git
  bundler
  dotenv
  osx
  macos
  rake
  rbenv
  ruby
  zsh-autosuggestions
  zsh-syntax-highlighting
  jsontools aliases)




alias c="clear"
alias cal="cloudctl auth login"
alias cl="cloudctl config use"
alias vl="export VAULT_ADDR='https://vault.splunkcloud.systems'; vault login -method=okta username=$(whoami)"
alias id='ssh-add ~/.ssh/id_rsa'
alias nl='nslookup'
alias l="ls -la"
alias q="exit"
alias p="python3 app_pre_checks_latestu.py"

pcs() { cd; cd tools/app-prechecks-script/; python3 ~/tools/app-prechecks-script/app_pre_checks_latestu.py -s $1 -i $2 -p; }
pr() { sudo python3 ~/cloud/tools/vpn_routes.py }
sb() { python3 ~/cloud/tools/splunkbase_info.py -a $1 }
ac() { python3 ~/cloud/tools/appStanza.py -f $1 -s $2 -t $3;}
aa() { python3 ~/cloud/tools/appStanza.py -a $1;}

dif() { cloudctl stacks diff $1 }
cpr() {cloudctl stacks diff $1; echo "Do you want to merge the PR (y/n):"; read FLAG; 
if [[ $FLAG == "y" ]]
then
  prVersion=$(cloudctl stacks get $1  | tail | grep "version" | cut -f2 -d ' '); cloudctl stacks approve $1 --version $(($prVersion + 1)) --reason "gtg"
fi }
prm() {prVersion=$(cloudctl stacks get $1  | tail | grep "version" | cut -f2 -d ' '); cloudctl stacks approve $1 --version $(($prVersion + 1)) --reason "gtg"  }
prc() {prVersion=$(cloudctl stacks get $1  | tail | grep "version" | cut -f2 -d ' '); cloudctl stacks cancel $1 --version $(($prVersion + 1)) --reason "cancel" }
prr() {prVersion=$(cloudctl stacks get $1  | tail | grep "version" | cut -f2 -d ' '); cloudctl stacks reject $1 --version $(($prVersion + 1)) --reason "reject" }
prme() {cloudctl stacks approve $1 --version $2 --reason "gtg" }
prce() {cloudctl stacks cancel $1 --version $2 --reason "cancel" }
cgf() { cloudctl stacks get $1 -o json > $1.json; code $1.json; }
cg() { cloudctl stacks get $1 -o json }
cu() { cloudctl stacks update $1 -f ./$1.yaml --reason "$2"; }

vp() { vault kv get -field=plaintext cloud-sec/std/lve/stacks/$1/admin }
vpf() { vault kv get cloud-sec/std/lve/stacks/$1/admin }
vvp() { vault kv get --version $2 cloud-sec/std/lve/stacks/$1/admin;}
#pass() {FQDN=$(nslookup $1.$2.splunkcloud.com | egrep "(canonical name) = (sh|c0m|idm|shc)" | awk -F " " '{print $5}' | awk '{sub(/.$/,"")}1'); splunk-vault -f $FQDN $2}
sv() {STACK=$(echo $1 | cut -f2 -d .); splunk-vault -f $1 $STACK}
svv() { 
  if [[ "$1" == shc* ]]; then 
    FQDN=$(sft resolve shc1.$2.splunkcloud.com | awk '/Name:/ {print $2}' | tr -d '\n')
    #FQDN=$(sft resolve shc1.$2.splunkcloud.com | grep -m 1 Name: | awk -F "[\.:]" '{print $2}')
  else
    FQDN=$(ns $1.$2 | grep -m 1 canonical | awk -F "[=]" '{print $2}'| cut -c 2- | sed 's/.$//')
    echo $2
    #FQDN=$(ns $1.$2 | grep -m 1 canonical | awk -F "[=]" '{print $2}'| cut -c 2-);
    #FQDN=${FQDN:0:-1}
  fi
  splunk-vault -f $FQDN $2
  }
ns()  { nslookup $1.splunkcloud.com; }

sf()  { sft ssh $1; }
sfs()  { sft ssh --team splunk-stg $1; }
sfd()  { sft ssh --team splunk-dev $1; }
ss()  { sft ssh $1 --command 'sudo su - splunk'; }

jn() { cloudctl stacks get $1 -o json | jq -r '{jobType: .status.lastProvisionedJobType, lastProvisionedPlanSummary: .status.lastProvisionedPlanSummary, status: .status.lastProvisionedStatus, lastProvisionedURL: .status.lastProvisionedURL}' }

alias sh1='sh 1'
alias sh2='sh 2'
alias sh3='sh 3'
alias sh4='sh 4'
alias sh5='sh 5'
alias idm1='idm 1'
alias idm2='idm 2'
c0m1() { sft ssh $(ns c0m1.$1 | grep -m 1 canonical | awk -F "[\.=]" '{print $5}'); }
idm() {
    local num=$1
    local stack=$2
    sft ssh $(ns idm${num}.${stack} | grep -m 1 canonical | awk -F "[\.=]" '{print $5}')
}
sh() {
    local num=$1
    local stack=$2
    sft ssh $(ns sh${num}.${stack} | grep -m 1 canonical | awk -F "[\.=]" '{print $5}')
}
es() { sft ssh $(ns es-$1 | grep -m 2 canonical | tail -n1 | awk -F "[\.=]" '{print $5}'); }
itsi() { sft ssh $(ns itsi-$1 | grep -m 2 canonical | tail -n1 | awk -F "[\.=]" '{print $5}'); }
shc1() { sft ssh $(sft resolve shc1.$1.splunkcloud.com | grep -m 1 Name: | awk -F "[\.:]" '{print $2}') }

dmc() { sft ssh $(ns c0m1.$1 | grep -m 1 canonical | awk -F "[\.=]" '{print $5}') --command 'sudo -u splunk sh -c "cd /opt/splunk/; cd var/log/splunk/; tail -f $(ls -ltrh | grep dmc_agent.log | tail -1f | awk '{print $9}')"'; }
noah() { sft ssh $(ns c0m1.$1 | grep -m 1 canonical | awk -F "[\.=]" '{print $5}') --command 'sudo -i  sh -c "cd /; tail -f /var/log/syslog | grep noah"'; }



help() { echo "
|#####################################################################|
|##   1] pcs                                                        ##|
|##   2] pr   --> Add Routes by python script                       ##|
|##   3] dif  --> cloudctl stacks diff                              ##|
|##   4] cpr  --> Approve PR after checking differance              ##|
|##   5] prm  --> Approve PR                                        ##|
|##   6] prc  --> Cancel PR                                         ##|
|##   7] prr  --> Reject PR                                         ##|
|##   8] prme --> Approve PR of Specific Version                    ##|
|##   9] prce --> Cancel PR of Specific Version                     ##|
|##  10] cgf  --> Get Spec file of stack as json                    ##|
|##  11] cg   --> Get Spec file of stack on Terminal                ##|
|##  12] cu   --> Update Spec file                                  ##|
|##  13] vp   --> Admin pass                                        ##|
|##  14] vpf  --> Admin pass with details                           ##|
|##  15] vvp  --> Admin pass of specific version                    ##|
|##  16] ns   --> nslookup to any 'splunkcloud.com' stack           ##|
|##  17] sf   --> SSH to splunk LVE instnace                        ##|
|##  18] sfs  --> SSH to splunk STG instance                        ##|
|##  19] sfd  --> SSH to splunk DEV instance                        ##|
|##  20] ss   --> SSH to splunk LVE instance as splunk user         ##|
|##  21] jn   --> Get jenkins build                                 ##|
|##  22] sb   --> splunkbase_info                                   ##|
|##  23] ac   --> appStanza                                         ##|
|##  24] aa   --> appStanza                                         ##|
|##  25] sv   --> Get the cread by providing full FQDN              ##|
|##  26] svv  --> Get the cread by instnace label and stack         ##|
|##  27] c0m1 --> SSH to c0m1 instance of splunk LVE instance       ##|
|##  28] idm  --> SSH to idm1 instance of splunk LVE instance       ##|
|##  29] idm  --> SSH to idm2 instance of splunk LVE instance       ##|
|##  30] shc1 --> SSH to shc1 instance of splunk LVE instance       ##|
|##  31] sh1  --> SSH to sh1 instance of splunk LVE instance        ##|
|##  32] sh2  --> SSH to sh2 instance of splunk LVE instance        ##|
|##  33] sh3  --> SSH to sh3 instance of splunk LVE instance        ##|
|##  34] sh4  --> SSH to sh4 instance of splunk LVE instance        ##|
|##  35] sh5  --> SSH to sh5 instance of splunk LVE instance        ##|
|##  36] es   --> SSH to es instance of splunk LVE instance         ##|
|##  37] itsi --> SSH to itsi instance of splunk LVE instance       ##|
|#####################################################################|"
}



# cc()  { sft ssh $1 --command 'sudo -u splunk  bash -c "cd /opt/splunk/; echo '"'"'Looking for files in /opt/splunk/etc ......'"'"'; if [ $(find /opt/splunk/etc/ -iname "._*") ]; then  find /opt/splunk/etc/ -iname "._*"; else echo '"'"'\n\n._ files not found'"'"'; echo "exiting"; fi; hostname -f ; date"' }
# ssr() { ssh -F ~/.ssh/sft-config internal-$1.cloud.splunk.com; }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

COPYFILE_DISABLE=1
COPY_EXTENDED_ATTRIBUTES_DISABLE=true

sa() {ssh splunker@$1}
export PATH="/usr/local/sbin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
