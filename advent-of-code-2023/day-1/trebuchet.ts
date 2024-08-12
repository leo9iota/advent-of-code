import { promises as fs } from 'node:fs';

// const exampleInput = ['1abc2', 'pqr3stu8vwx', 'a1b2c3d4e5f', 'treb7uchet'];

async function computeCalibrationValues(filePath: string) {
    try {
        const data: string = await fs.readFile(filePath, 'utf-8'); // Read from file using UTF-8 format
        const lines: string[] = data.split('\n'); // Split lines into separate strings
        const regexPattern = /\b(one|two|three|four|five|six|seven|eight|nine)\b/;
        let sumCalibrationValues: number = 0; // Initialize sum variable

        // Loop over the separate strings
        for (const line of lines) {
            let firstDigit: number | null = null; // Initialize first digit variable
            let lastDigit: number | null = null; // Initialize last digit variable

            for (let i = 0; i < line.length; i++) {
                // Loop over the string by its length
                const number: number = parseInt(line[i]); // Parses the single character to an integer

                if (!isNaN(number)) {
                    // Check if the parsed integer is a number
                    if (firstDigit === null) {
                        // Check if the first digit variable is still unassigned
                        firstDigit = number; // Assign first digit to the number in the string
                    }
                    lastDigit = number; // Assign last digit to the number in the string
                }
            }

            if (firstDigit !== null && lastDigit !== null) {
                // Check if first and last digit have been assigned
                const twoDigitNumber = firstDigit * 10 + lastDigit; // Add them together (Note: the first digit is multiplied by 10 to form a two-digit number)
                sumCalibrationValues += twoDigitNumber; // Add to the total sum
            } else if (firstDigit !== null) {
                // Check if theres only one digit
                const twoDigitNumber = firstDigit * 10 + firstDigit; // Add them together (Note: the first digit is multiplied by 10 to form a two-digit number)
                sumCalibrationValues += twoDigitNumber; // Add to the total sum
            }
        }

        console.log(`Sum of calibration values: ${sumCalibrationValues}`);
    } catch (error) {
        console.error(error);
    }
}

computeCalibrationValues('./advent-of-code-2023/day-1/input.txt');
