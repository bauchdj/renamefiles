const fs = require('fs'), path = require('path');
let dir = process.argv[2].replace(/\/?$/, '/');
let files = fs.readdirSync(dir).filter(item => !(/(^|\/)\.[^\/\.]/g).test(item));

for (let i=0; i<files.length; i++) {
	let file = files[i];
	if (fs.statSync(`${dir}${file}`).isFile()) {
        if (fs.statSync(`${dir}${file}`).isFile()) {
            let name = path.parse(file).name;
            let regex = /(\-[a-z].*)/;
            if (regex.test(file)) { name = file.split(regex)[0] }
            let filePath = `${dir}${file}`;
            let newFilePath = `${dir}${name}/${file}`;
            if (fs.existsSync(`${dir}${name}`)) {
                rename(filePath, newFilePath);
            }
            else { 
                fs.mkdirSync(`${dir}${name}`);
                rename(filePath, newFilePath);
            }
        }
    }
}

function rename(p,newP) {
	fs.rename(p, newP, (err) => {
		if (err) throw err;
		console.log(p, newP);
	});
}