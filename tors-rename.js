const fs = require('fs'),
      path = require('path'),
      folderPath = process.argv[2] //__dirname for file's current directory;
let files = fs.readdirSync(folderPath);

for (let i=0; i<=files.length-1; i++) {
  let filename = files[i],
  name = path.parse(filename).name,
  ext = path.parse(filename).ext,
  moviename = name.split(/.[0-9][0-9][0-9][0-9]./)[0];
  moviename = moviename.split('.').join(' ');
  let newname = `${moviename}${ext}`;
  console.log(newname);
  /*
  fs.rename(`${folderPath}${filename}`, `${folderPath}${newname}`, () => {
    console.log(filename, newname);
  });
  */
}