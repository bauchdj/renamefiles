const fs = require('fs'), path = require('path');
const { spawn } = require('child_process');
let dir = process.argv[2].replace(/\/?$/, '/');
let files = fs.readdirSync(dir).filter(item => !(/(^|\/)\.[^\/\.]/g).test(item));

for (let i=0; i<files.length; i++) {
        let file = files[i];
	let regex = /201\d*.\d*/;
	if (file.match(regex)) {
		var filedate = (file.match(regex)[0].replace(/[^0-9]/g,''));
		var year = filedate.substring(0,4);
		var month = filedate.substring(4,6);
		var day = filedate.substring(6,8);
		var hour = filedate.substring(8,10);
		var min = filedate.substring(10,12);
		var sec = filedate.substring(12,14);
		var date = `${month}/${day}/${year} ${hour}:${min}:${sec}`;
		var setfile = spawn('SetFile', ['-d', date, '-m', date, file]);
		console.log(`${file} | ${date}`);
	}
}
