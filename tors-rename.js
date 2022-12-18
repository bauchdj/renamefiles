const fs = require('fs'), path = require('path');
let dir = process.argv[2].replace(/\/?$/, '/');
let folders = fs.readdirSync(dir).filter(item => !(/(^|\/)\.[^\/\.]/g).test(item));

function renameFiles(folderPath) {
	let files = fs.readdirSync(folderPath).filter(item => !(/(^|\/)\.[^\/\.]/g).test(item));
	for (let i=0; i<files.length; i++) {
		let filename = files[i];
		let name = path.parse(filename).name;
		let ext = path.parse(filename).ext;
		let regex = /yts.*(\-[a-z].*)/i;
		if (regex.test(filename)) { ext = filename.split(/(\-[a-z].*)/)[1] }
		let moviename = name.split(/.[0-9][0-9][0-9][0-9]./)[0].split('.').join(' ');
		let newFileName = `${moviename}${ext}`;
		rename(`${folderPath}${filename}`, `${folderPath}${newFileName}`);
		//console.log(newFileName);
	}
}

for (let i=0; i<folders.length; i++) {
	let folder = folders[i];
	if (fs.statSync(`${dir}${folder}`).isDirectory()) {
		let folderPath = `${dir}${folder.replace(/\/?$/, '/')}`;
		renameFiles(folderPath);
		let newFolderName = folder.split(/ \([0-9][0-9][0-9][0-9]\)/)[0];
		rename(folderPath, `${dir}${newFolderName}`);
		//console.log(newFolderName);
	}
}

function rename(p,newP) {
	fs.rename(p, newP, (err) => {
		if (err) throw err;
		console.log(p, newP);
	});
}
