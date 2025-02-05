PIDS=$(pgrep -f "swaybg")

swaybg -m fill -i "$1" &

if [ -n "$PIDS" ]; then
  echo "$PIDS" | xargs kill
fi

magick "$1" ~/.config/hypr/wallpaper.png
