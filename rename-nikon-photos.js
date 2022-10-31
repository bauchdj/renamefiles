const fs = require('fs'),
      path = require('path'),
      folderPath = '/Users/djbii/Desktop/103D3400/' //__dirname for file's current directory;
let files = fs.readdirSync(folderPath);

for (let i=0; i<=files.length-1; i++) {
  let filename = files[i],
  name = path.parse(filename).name,
  ext = path.parse(filename).ext,
  numfromname = parseInt(name.split('_').pop());
  if (numfromname > i) {
    let picnumber = (i+1).toString().padStart(4, '0');
    let newname = `DSC_${picnumber}${ext}`;
    console.log(`${filename} is now ${newname}`)
  }
}
