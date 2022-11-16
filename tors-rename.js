const fs = require('fs'),
      path = require('path');
let dir = process.argv[2] //${__dirname} current file directory
		dir = dir.replace(/\/?$/, '/');
let folders = fs.readdirSync(dir);

for (let i=0; i<folders.length; i++) {
	let folder = folders[i],
		folderPath = `${dir}${folder.replace(/\/?$/, '/')}`,
		newfoldername = folder.split(/ \([0-9][0-9][0-9][0-9]\)/)[0];
	renameTors(fs.readdirSync(folderPath),folderPath);
	fs.rename(`${dir}${folders[i]}`, `${dir}${newfoldername}`, (err) => {
		if (err) throw err;
 		console.log(folder, newfoldername);
	});
}

function renameTors(files,folderPath) {
	for (let i=0; i<files.length; i++) {
	  let filename = files[i],
	  name = path.parse(filename).name,
	  ext = path.parse(filename).ext,
	  moviename = name.split(/.[0-9][0-9][0-9][0-9]./)[0].split('.').join(' '),
	  newfilename = `${moviename}${ext}`;
	  fs.rename(`${folderPath}${filename}`, `${folderPath}${newfilename}`, (err) => {
		if (err) throw err;
 	  	console.log(filename, newfilename);
	  });
	}
}
