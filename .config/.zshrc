export PATH=$HOME/bin:/usr/local/bin:/home/paulbnhs/.local/bin:$PATH
export GIT_EDITOR=micro
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git python)

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/antigen.zsh

# functions
function zshc { micro ~/.zshrc && exec zsh}
function ll { exa --long --all --header --icons }
function apti { sudo apt-get install $1 -y }
function br { brew install $1 }
function uz { unzip $1 && rm -f $1 }
function mkrun { make && ./$1 }
function scanlocal() {                                                                             
     local ip_full=$(ip -4 addr show wlp2s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
     local ip=${ip_full%.*}
	 ip="${ip}.0/24"
     local date=$(date +%Y%m%d)                                                                     
#     local logdirectory="$HOME/nmap/logs/$date"                                                     
#     local logfile="$logdirectory/${ip}"                                                                                                                                                    
#     if [[ ! -d "$logdirectory" ]]; then
#     	mkdir -p $logdirectory                                                                     
#     fi                                                                                                                                                                                      
     grc --colour=on nmap -sV -v -p- $ip
     echo "Didn't save scan results to $logfile."                       
}
function scanread() {less -R $1}
hydra_ssh() {
if [ $# -ne 2 ]; then                                                                                      
     echo -e "\033[31mUsage: hydra_ssh [ip] [wordlist]\033[0m"                                                
     return 1                                                                                                 
   fi                                                                                                                                                                                                                       
   local ip=$1                                                                                                
   local wordlist=$2                                                                                          
   echo -e "\033[32mStarting Hydra SSH bruteforce on $ip with wordlist $wordlist\033[0m"                      
   hydra -l root -P $wordlist ssh://$ip -t 4                                                                  
   local result=$?                                                                                            
   if [ $result -eq 0 ]; then                                                                                 
     echo -e "\033[32mHydra bruteforce completed successfully.\033[0m"                                        
   else                                                                                                       
     echo -e "\033[31mHydra bruteforce failed with error code: $result\033[0m"                                
   fi                                                                                                         
   return $result                                                                                             
 }

antigen use oh-my-zsh
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(thefuck --alias)"

alias studip="python3 ~/selenium/studip.py"
alias gdrive="cd /run/user/1000/gvfs/google-drive:host=gmail.com,user=bakenhuspaul"
alias e="eza --long --all --header --git"
alias gacp="ga . && gc && gp"

cd ~/semester-3
