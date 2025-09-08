# base URL for Bing
BASE_URL=https://bing.com

# API endpoint which returns the Picture Of The Day data
ENDPOINT="$BASE_URL/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US"

IMG_FILE=/tmp/bpotd.jpg


echo Querying the API...
if ! api_data=$(curl "$ENDPOINT"); then
    echo "Unable to contact the API";
    exit 1;
fi

# extract the image url from the astropix page
echo Getting image url...
imgurl=$(echo "$api_data" | jq -r .images[0].url)
echo "Image url is $imgurl"

# get that image file
echo "Getting image at ${BASE_URL}${imgurl}"
if ! curl "${BASE_URL}${imgurl}" -o $IMG_FILE; then
    echo "Unable to retrieve image"
    exit 2
fi

#set wallpaper using swaybg
wall-change "$IMG_FILE"