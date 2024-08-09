import { promises as fs } from 'node:fs';

async function computeCalibrationValues(filePath: string) {
    try {
        const data = await fs.readFile(filePath, 'utf-8');
        const lines = data.split('\n')
        let sumCalibrationValues = 0;

        for (const line of lines) {
            
        }
    } catch (error) {
        console.error(error);
    }
}

computeCalibrationValues('./advent-of-code-2023/day-1/input.txt');
