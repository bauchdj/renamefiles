sed -i -e '58s/false/true/' /Applications/Surfshark.app/Contents/Info.plist
open /Applications/Surfshark.app
sed -i -e '58s/true/false/' /Applications/Surfshark.app/Contents/Info.plist
exit
