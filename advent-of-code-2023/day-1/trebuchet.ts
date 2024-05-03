const example2DArray = [['1abc2'], ['pqr3stu8vwx'], ['a1b2c3d4e5f'], ['treb7uchet']];

const traverse2DArray = (inputArray: string[][]) => {
  const outputArray: string[][] = [];

  for (let i = 0; i < inputArray.length; i++) {
    for (let j = 0; j < inputArray[i].length; j++) {
      console.log(inputArray[i][j]);
      outputArray.push([inputArray[i][j]]);
    }
  }

  return outputArray;
};

const my2DArray = traverse2DArray(example2DArray);

console.log(my2DArray);
