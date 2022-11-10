const fs = require('fs'),
      path = require('path'),
      folderPath = process.argv[2] //__dirname for file's current directory;
let files = fs.readdirSync(folderPath);

for (let i=1; i<=files.length; i++) {
  let filename = files[i-1],
  name = path.parse(filename).name,
  ext = path.parse(filename).ext,
  numfromname = parseInt(name.split('_').pop());
  if (numfromname > i) {
    let picnumber = (i).toString().padStart(4, '0');
    let newname = `DSC_${picnumber}${ext}`;
    fs.rename(`${folderPath}${filename}`, `${folderPath}${newname}`, () => {
      console.log(filename, newname);
    });
  }
}
