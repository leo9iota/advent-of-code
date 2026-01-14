import * as fs from 'fs';

interface Puzzle {
    solvePart1(): string;
    solvePart2(): string;
}

class Day implements Puzzle {
    private input: string;

    constructor(input: string) {
        this.input = input;
    }

    static create(input: string): Puzzle {
        return new Day(input);
    }

    solvePart1(): string {
        const result = this.solveInternal(false).toString();
        console.log('Part 1 Result:', result);
        return result;
    }

    solvePart2(): string {
        const result = this.solveInternal(true).toString();
        console.log('Part 2 Result:', result);
        return result;
    }

    private solveInternal(allowSpelledOut: boolean): number {
        return this.input
            .split('\n')
            .map((line) => {
                const digits = extractDigits(line, allowSpelledOut);
                console.log(`Line: "${line}", Digits: ${digits}`);
                return extractCalibrationValue(digits);
            })
            .reduce((a, b) => a + b, 0);
    }
}

function extractCalibrationValue(digits: number[]): number {
    if (digits.length === 0) return 0;
    
    const firstDigit = digits[0];
    const lastDigit = digits[digits.length - 1];
    return 10 * firstDigit + lastDigit;
}

function extractDigits(line: string, allowSpelledOut: boolean): number[] {
    const regex = allowSpelledOut
        ? /^(one|two|three|four|five|six|seven|eight|nine|\d)/i
        : /^(\d)/;

    const digits: number[] = [];
    let match: RegExpExecArray | null;

    for (let i = 0; i < line.length; i++) {
        if ((match = regex.exec(line.slice(i)))) {
            const digit = parseDigit(match[0]);
            digits.push(digit);
        }
    }
    return digits;
}

function parseDigit(digitStr: string): number {
    switch (digitStr.toLowerCase()) {
        case 'one':
            return 1;
        case 'two':
            return 2;
        case 'three':
            return 3;
        case 'four':
            return 4;
        case 'five':
            return 5;
        case 'six':
            return 6;
        case 'seven':
            return 7;
        case 'eight':
            return 8;
        case 'nine':
            return 9;
        default:
            return parseInt(digitStr, 10);
    }
}

const fileInput = fs.readFileSync('./advent-of-code-2023/day-1/input.txt', 'utf-8');
const puzzle = Day.create(fileInput);
puzzle.solvePart1();
puzzle.solvePart2();
