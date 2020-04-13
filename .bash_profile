# Updated bash profile, based on this one here: https://www.raspberrypi.org/forums/viewtopic.php?t=23440

let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "$(tput setaf 2)
   .~~.   .~~.    `date +"%A, %e %B %Y, %r"`
  '. \ ' ' / .'   `uname -srmo`$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :   Uptime.............: $(echo $UPTIME | cut -f1 -d ',')
 ~ (   ) (   ) ~  Memory.............: $(free | grep Mem | awk '{print $3/$2 * 100}' | cut -f1 -d '.')% used
( : '~'.~.'~' : ) Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 ~ .~ (   ) ~. ~  Running Processes..: $(ps -ef | wc -l)
  (  : '~' :  )   IP Addresses.......: Int. $(ifconfig eth0 | grep 'inet ' | awk '{print $2}') & Ext. $(wget -q -O - http://icanhazip.com/ | tail)
   '~ .~~~. ~'    Weather............: $(curl -s wttr.in/Manchester?format="%l:+%c+%t")
       '~'        Disk Use...........: $(df -h | grep '/dev/root' | awk '{print $5}') used
$(tput sgr0)"

source $HOME/.bashrc
