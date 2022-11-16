const fs = require('fs'),
      path = require('path');
let dir = process.argv[2] //${__dirname} current file directory
		dir = dir.replace(/\/?$/, '/');
let folders = fs.readdirSync(dir);

for (let i=0; i<folders.length; i++) {
	let folder = `${dir}${folders[i].replace(/\/?$/, '/')}`;
	//if (fs.statSync(folder).isDirectory) renameTors(fs.readdirSync(folder));
	renameTors(fs.readdirSync(folder),folder);
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
