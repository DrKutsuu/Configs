#! /bin/bash

LOCAL_URL="https://www.metoffice.gov.uk/public/weather/forecast/gcjszevgx"

#data-name="Cardiff"
#data-sspaid="350758"
#data-geohash="gcjszevgx"

FORECAST_CONTENT_TAG="//*[@id='fcContent']"

#while true
#do

#while ! iwgetid -r
#do
#echo "Waiting for wireless network.. (Retry in 15 minutes)"
#sleep 15m
#done

TMP_FILE=$(mktemp)
echo "tempfile: $TMP_FILE"

curl -s -o "$TMP_FILE" "$LOCAL_URL"

LINES=$(wc -l $TMP_FILE)

echo "Downloaded $LINES lines of HTML"

xmllint --pattern "$FORECAST_CONTENT_TAG" "$TMP_FILE"

echo "Cleaning tempfile $TMP_FILE"
rm "$TMP_FILE"


# Messy prototype grep/seds
#| egrep -o -i '<span.*|<td.*' --max-count=9 | sed -e "s/<\/[^>]*>/\n/g" -e "s/<[^>]*>//g"

#sleep 1h
#done
