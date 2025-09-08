if [ "$1" == "on" ]; then
    state_opt=1
elif [ "$1" == "off" ]; then
    state_opt=4
else
    echo "First argument must be either 'on' or 'off'"
    exit 1
fi



monitor_count=$(bash -c "ddcutil detect | grep Display | wc -l")

seq "$monitor_count" | xargs -n 1 ddcutil setvcp d6 $state_opt -d