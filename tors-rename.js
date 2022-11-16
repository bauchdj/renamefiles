const fs = require('fs'),
      path = require('path'),
      folderPath = process.argv[2] //__dirname current file directory;
let files = fs.readdirSync(folderPath);

for (let i=0; i<=files.length-1; i++) {
  let filename = files[i],
  name = path.parse(filename).name,
  ext = path.parse(filename).ext,
  moviename = name.split(/.[0-9][0-9][0-9][0-9]./)[0].split('.').join(' ');
  let newfilename = `${moviename}${ext}`;
  fs.rename(`${folderPath}${filename}`, `${folderPath}${newfilename}`, () => {
    console.log(filename, newfilename);
  });
}