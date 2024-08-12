# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# Configure colours and Terminal layout
LS_COLORS="ow=01;90:di=01;100"
export LS_COLORS

# For speedtest.net bash
export INSTALL_KEY=

# Function to allow display of git branch when in a repo
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Change hostname to CAPS
caps () {
  hostname -s | tr '[:lower:]' '[:upper:]'
}

# Chris's new shell 15/12/2018
PS1="\$(caps) \[\e[0;32m\]\w\[\e[0;37m\]\[\e[36m\]\$(parse_git_branch)\[\e[0m\] $ \[\e[0m\]"

# Get system uptime in days, hours, minutes, and seconds
let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=$(printf "%d days, %02dh %02dm %02ds" "$days" "$hours" "$mins" "$secs")

# CPU information
CPU_INFO=$(</proc/cpuinfo)

# Get the load averages
read one five fifteen rest < /proc/loadavg

# Display the MOTD with enhanced formatting
echo "$(tput setaf 2)
   .~~.   .~~.       $(date +"%A, %e %B %Y, %r")
  '. \ ' ' / .'      $(uname -srmo)
   .~ .~~~..~.       $(tr '\0' '\n' </sys/firmware/devicetree/base/model) $(tput setaf 1)
  : .~.'~'.~. :      Uptime.............: $(echo $UPTIME)
 ~ (   ) (   ) ~     Memory.............: $(free | grep Mem | awk '{print $3/$2 * 100}' | cut -f1 -d '.')% used
( : '~'.~.'~' : )    Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 ~ .~ (   ) ~. ~     Running Processes..: $(ps -ef | wc -l)
  (  : '~' :  )      IP Addresses.......: Int. $(hostname -I | awk '{print $1}') & Ext. $(curl -s http://icanhazip.com)
   '~ .~~~. ~'       Weather............: $(curl -s wttr.in/Singapore?format="%l:+%c+%t")
       '~'           Disk Use...........: $(df -h | grep '/dev/root' | awk '{print $5}') used
$(tput sgr0)"
