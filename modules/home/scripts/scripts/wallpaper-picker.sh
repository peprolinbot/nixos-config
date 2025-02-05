bpotd_entry="⚙️ Bing's Picture Of The Day"
apotd_entry="⚙️ NASA's Astronomy Picture Of The Day"
wallpapers_folder=$HOME/Pictures/Wallpapers/

wallpaper_name=$(echo -e "$bpotd_entry\n$apotd_entry" | { cat; find "$wallpapers_folder" -type f | sed "s|$wallpapers_folder||"; } | fuzzel --dmenu)
if [ "$wallpaper_name" == "$bpotd_entry" ]; then
    setbg-bpotd
elif [ "$wallpaper_name" == "$apotd_entry" ]; then
    setbg-apotd
elif [[ -f $wallpapers_folder/$wallpaper_name ]]; then
    wall-change "$wallpapers_folder/$wallpaper_name"
else
    exit 1
fi