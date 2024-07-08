#!/usr/bin/env bash

## Based on https://github.com/sgsax/apod-desktop/blob/master/apod


# base URL for the APOD website
BASE_URL=https://apod.nasa.gov/apod/

# API endpoint which returns the Picture Of The Day data
PAGE_URL="$BASE_URL/astropix.html"

IMG_FILE=/tmp/apotd.jpg


echo Getting APOD page...
page_data=`curl -s $PAGE_URL`

if [ $? -ne 0 ]; then
    echo "Unable to retrieve page";
    exit 1;
fi

# extract the image url from the astropix page
echo Getting image url...
imgurl=`echo "$page_data" | grep -i "img src" | sed -e 's/.*<img src="\(.*\)".*/\1/i'`
echo Image url is $imgurl

# get that image file
echo Getting image at ${BASE_URL}${imgurl}
curl ${BASE_URL}${imgurl} -o $IMG_FILE
if [ $? -ne 0 ]; then
    echo "Unable to retrieve image"
    exit 2
fi

#set wallpaper using swaybg
wall-change "$IMG_FILE"