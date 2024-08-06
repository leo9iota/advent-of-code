import { promises as fs } from 'node:fs';

async function detectLineEndings(filePath: string) {
    try {
        const data = await fs.readFile(filePath);
        const content = data.toString('utf-8');

        if (content.includes('\r\n')) {
            console.log('The file uses CRLF (Windows) line endings.');
            console.log(data.toString());
        } else if (content.includes('\n')) {
            console.log('The file uses LF (Unix) line endings.');
            console.log(data.toString());
        } else {
            console.log('The file does no   t contain any standard line endings.');
            console.log(data.toString());
        }
    } catch (err) {
        console.error('Error reading file:', err);
    }
}

detectLineEndings('./advent-of-code-2023/day-1/input.txt');