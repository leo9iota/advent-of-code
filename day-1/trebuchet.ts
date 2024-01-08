const example2DArray = [['1abc2'], ['pqr3stu8vwx'], ['a1b2c3d4e5f'], ['treb7uchet']];

const traverse2DArray = (array: string[][]): void => {
  for (let i = 0; i < array.length; i++) {
    for (let j = 0; j < array[i].length; j++) {
      console.log(array[i][j]);
    }
  }
};

const my2DArray = traverse2DArray(example2DArray);

console.log(my2DArray);
