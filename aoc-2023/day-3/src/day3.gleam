import gleam/io
import gleam/string
import gleam/list
import gleam/int
import gleam/result
import simplifile

pub fn main() -> Nil {
  case simplifile.read("gear-ratios-input.txt") {
    Ok(content) -> {
      let sum = solve_part1(content)
      io.println("Sum of all part numbers: " <> int.to_string(sum))
    }
    Error(_) -> io.println("Error reading input file")
  }
}

pub fn solve_part1(input: String) -> Int {
  let lines = string.split(input, "\n")
  let grid = list.map(lines, string.to_graphemes)

  // Find all numbers and their positions
  let numbers = find_all_numbers(grid)

  // Filter numbers that are adjacent to symbols
  let part_numbers = list.filter(numbers, fn(num_info) {
    is_adjacent_to_symbol(grid, num_info)
  })

  // Sum all part numbers
  list.fold(part_numbers, 0, fn(acc, num_info) { acc + num_info.value })
}

pub type NumberInfo {
  NumberInfo(value: Int, row: Int, start_col: Int, end_col: Int)
}

pub fn find_all_numbers(grid: List(List(String))) -> List(NumberInfo) {
  list.index_fold(grid, [], fn(acc, row, row_idx) {
    let row_numbers = find_numbers_in_row(row, row_idx)
    list.append(acc, row_numbers)
  })
}

pub fn find_numbers_in_row(row: List(String), row_idx: Int) -> List(NumberInfo) {
  find_numbers_helper(row, row_idx, 0, [], "", -1)
}

fn find_numbers_helper(
  row: List(String),
  row_idx: Int,
  col_idx: Int,
  acc: List(NumberInfo),
  current_num: String,
  start_col: Int,
) -> List(NumberInfo) {
  case row {
    [] -> {
      // End of row, add current number if exists
      case current_num {
        "" -> acc
        _ -> {
          case int.parse(current_num) {
            Ok(value) -> [NumberInfo(value, row_idx, start_col, col_idx - 1), ..acc]
            Error(_) -> acc
          }
        }
      }
    }
    [char, ..rest] -> {
      case is_digit(char) {
        True -> {
          let new_start = case current_num {
            "" -> col_idx
            _ -> start_col
          }
          find_numbers_helper(
            rest,
            row_idx,
            col_idx + 1,
            acc,
            current_num <> char,
            new_start,
          )
        }
        False -> {
          let new_acc = case current_num {
            "" -> acc
            _ -> {
              case int.parse(current_num) {
                Ok(value) -> [NumberInfo(value, row_idx, start_col, col_idx - 1), ..acc]
                Error(_) -> acc
              }
            }
          }
          find_numbers_helper(rest, row_idx, col_idx + 1, new_acc, "", -1)
        }
      }
    }
  }
}

pub fn is_digit(char: String) -> Bool {
  case char {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> True
    _ -> False
  }
}

pub fn is_adjacent_to_symbol(grid: List(List(String)), num_info: NumberInfo) -> Bool {
  let NumberInfo(_, row, start_col, end_col) = num_info

  // Check all positions around the number
  let positions_to_check = get_adjacent_positions(row, start_col, end_col)

  list.any(positions_to_check, fn(pos) {
    let #(r, c) = pos
    case get_char_at(grid, r, c) {
      Ok(char) -> is_symbol(char)
      Error(_) -> False
    }
  })
}

fn get_adjacent_positions(row: Int, start_col: Int, end_col: Int) -> List(#(Int, Int)) {
  let mut positions = []

  // Add positions above and below the number
  let col_range = list.range(start_col - 1, end_col + 1)
  let above_positions = list.map(col_range, fn(c) { #(row - 1, c) })
  let below_positions = list.map(col_range, fn(c) { #(row + 1, c) })

  // Add positions to the left and right
  let side_positions = [#(row, start_col - 1), #(row, end_col + 1)]

  list.flatten([above_positions, below_positions, side_positions])
}

pub fn get_char_at(grid: List(List(String)), row: Int, col: Int) -> Result(String, Nil) {
  case row < 0 || col < 0 {
    True -> Error(Nil)
    False -> {
      case list.at(grid, row) {
        Ok(grid_row) -> list.at(grid_row, col)
        Error(_) -> Error(Nil)
      }
    }
  }
}

pub fn is_symbol(char: String) -> Bool {
  case char {
    "." -> False
    _ -> !is_digit(char)
  }
}
