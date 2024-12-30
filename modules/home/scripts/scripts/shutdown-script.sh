respond="$(echo -e "󰐥 Shutdown\n󰜉 Restart\n󰜺 Cancel" | fuzzel --dmenu --lines=3 --width=15 --prompt='Choose action: ')"

if [ "$respond" = '󰐥 Shutdown' ] 
then
    echo "shutdown"
	shutdown now    
elif [ "$respond" = '󰜉 Restart' ] 
then
    echo "restart"
    reboot
else
    notify-send "Shutdown cancelled"
fi
