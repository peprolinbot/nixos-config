#### Options

option_1="󰹑 Capture"
option_2="󰁫 Timer capture"

option_capture_1="󰍺 All Screen"
option_capture_2="󰍹 Capture Active Screen"
option_capture_3="󱣴 Capture Area/Window/Application"

option_time_1="5s"
option_time_2="10s"
option_time_3="20s"
option_time_4="30s"
option_time_5="60s"

####


#### Initial menu to decide wether a timer is wanted

want_timer_cmd() {
  echo -e "$option_1\n$option_2" | fuzzel --dmenu -p 'Screenshot: '
}

####


#### Choose Timer seconds

timer_cmd() {
  echo -e "$option_time_1\n$option_time_2\n$option_time_3\n$option_time_4\n$option_time_5" | fuzzel --dmenu -p 'Choose timer: '
}

timer_menu() {
  selected_timer="$(timer_cmd)"
  if [[ "$selected_timer" == "$option_time_1" ]]; then
    countdown=5
  elif [[ "$selected_timer" == "$option_time_2" ]]; then
    countdown=10
  elif [[ "$selected_timer" == "$option_time_3" ]]; then
    countdown=20
  elif [[ "$selected_timer" == "$option_time_4" ]]; then
    countdown=30
  elif [[ "$selected_timer" == "$option_time_5" ]]; then
    countdown=60
  fi
}

####


#### Chose Screenshot Type

type_screenshot_cmd() {
  echo -e "$option_capture_1\n$option_capture_2\n$option_capture_3" | fuzzel --dmenu -p 'Type of screenshot: '
}

type_screenshot_menu() {
  selected_type_screenshot="$(type_screenshot_cmd)"
  if [[ "$selected_type_screenshot" == "$option_capture_1" ]]; then
    option_type_screenshot=screen
  elif [[ "$selected_type_screenshot" == "$option_capture_2" ]]; then
    option_type_screenshot=output
  elif [[ "$selected_type_screenshot" == "$option_capture_3" ]]; then
    option_type_screenshot=area
  fi
}

####


### Run the timer

timer() {
  # Countdown notifications must start at 10 seconds so they aren't annoying
  if [[ $countdown -gt 10 ]]; then
    notify-send -t 1000 "Taking Screenshot in ${countdown} seconds"
    sleep $((countdown - 10))
    countdown=10
  fi
  while [[ $countdown -ne 0 ]]; do
    notify-send -t 900 "Taking Screenshot in ${countdown}"
    countdown=$((countdown - 1))
    sleep 1
  done
}

####


#### Main logic

chosen="$(want_timer_cmd)"
if [ -z "$chosen" ]; then
  exit
fi

type_screenshot_menu
if [ -z "$selected_type_screenshot" ]; then
  exit
fi

if [[ $option_2 == *$chosen* ]]; then
  timer_menu
  if [ -z "$selected_timer" ]; then
    exit
  fi
  timer
else
  sleep 0.7 # So fuzzel has time to fade-out
fi
GRIMBLAST_EDITOR="swappy -f " grimblast --notify edit "$option_type_screenshot"

####
