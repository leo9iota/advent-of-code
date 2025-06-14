import day3
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn example_test() {
  let example_input =
    "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598.."

  day3.solve_part1(example_input)
  |> should.equal(4361)
}

pub fn is_digit_test() {
  day3.is_digit("5")
  |> should.equal(True)

  day3.is_digit("a")
  |> should.equal(False)

  day3.is_digit(".")
  |> should.equal(False)
}

pub fn is_symbol_test() {
  day3.is_symbol("*")
  |> should.equal(True)

  day3.is_symbol("#")
  |> should.equal(True)

  day3.is_symbol(".")
  |> should.equal(False)

  day3.is_symbol("5")
  |> should.equal(False)
}
