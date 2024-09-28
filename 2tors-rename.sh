#!/usr/bin/env node
const fs = require('fs').promises;
const path = require('path');
const { program } = require('commander');

function toTitleCase(str) {
	return str.replace(/\w\S*/g, (txt) => txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase());
}

function cleanFileName(fileName) {
	// Remove file extension
	let name = path.parse(fileName).name;
	
	// Wrap years in parentheses if they're not already
	name = name.replace(/\b(\d{4})\b(?!\))/g, '($1)');
	
	// Replace spaces with hyphens
	name = name.replace(/\s+/g, '-');
	
	// Remove any non-alphanumeric characters (except hyphens, apostrophes, and parentheses)
	name = name.replace(/[^a-zA-Z0-9()'-]/g, '');
	
	// Ensure only one hyphen between words
	name = name.replace(/-+/g, '-');
	
	// Remove leading/trailing hyphens
	name = name.replace(/^-|-$/g, '');
	
	// Convert to title case
	name = toTitleCase(name);
	
	return name;
}

async function getUniqueFileName(dir, baseName, ext) {
	let newName = baseName + ext;
	let counter = 1;
	while (await fs.access(path.join(dir, newName)).then(() => true).catch(() => false)) {
		newName = `${baseName}-dup${counter}${ext}`;
		counter++;
	}
	return newName;
}

async function renameMovieFiles(dir, dryRun) {
	try {
		const items = await fs.readdir(dir);
		
		for (const item of items) {
			const fullPath = path.join(dir, item);
			const stats = await fs.stat(fullPath);
			
			if (stats.isDirectory()) {
				await renameMovieFiles(fullPath, dryRun); // Recurse into subdirectories
			} else if (stats.isFile() && ['.mp4', '.srt'].includes(path.extname(item).toLowerCase())) {
				const newBaseName = cleanFileName(item);
				const ext = path.extname(item);
				const newName = await getUniqueFileName(dir, newBaseName, ext);
				const newPath = path.join(dir, newName);
				
				if (fullPath !== newPath) {
					if (dryRun) {
						console.log(`Would rename: ${item} -> ${newName}`);
					} else {
						await fs.rename(fullPath, newPath);
						console.log(`Renamed: ${item} -> ${newName}`);
					}
				}
			}
		}
	} catch (error) {
		console.error(`Error processing directory ${dir}:`, error);
	}
}

program
	.option('-d, --directory <path>', 'Directory to process')
	.option('-n, --dry-run', 'Perform a dry run without making changes')
	.parse(process.argv);

const options = program.opts();

if (!options.directory) {
	console.error('Please specify a directory using the -d or --directory option.');
	process.exit(1);
}

renameMovieFiles(options.directory, options.dryRun)
	.then(() => console.log('Processing completed.'))
	.catch(error => console.error('An error occurred:', error));
