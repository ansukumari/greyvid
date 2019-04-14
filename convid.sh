#!/bin/sh

# Create it
ffmpeg -i video.mp4 img/thumb%04d.png -hide_banner

# Convert it
list=`find ./img -name "thumb*.png" -exec basename {} \;`
for file in $list
do
	# echo "$file"
	convert "img/$file" -colorspace Gray -separate -average "test.png"
	mv "test.png" "img/$file"
done

# Combine it
ffmpeg -i img/thumb%04d.png made.mp4

# Delete it
rm ./img/*