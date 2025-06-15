import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  let test_lines = [
    ".......497...........................858...923...128..................227..801........487.....664...........................................",
    "436........765..............140.......+....................859.............*.........+.................960........668.......................",
    "...*982...........=..........=....203......266.263...375*....=...402....691..-....................*..........575....................13......",
  ]

  parse_grid(test_lines)
}

fn parse_grid(lines: List(String)) {
  io.println(
    "Grid dimensions: " <> string.inspect(list.length(lines)) <> " rows",
  )

  list.index_map(lines, fn(line, row_index) {
    io.println(
      "Row "
      <> string.inspect(row_index)
      <> ": "
      <> string.slice(line, 0, 50)
      <> "...",
    )

    let chars = string.to_graphemes(line)
    process_row(chars, row_index)
  })
}

fn process_row(chars: List(String), _: Int) {
  let numbers =
    list.filter(chars, fn(char) {
      case char {
        "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> True
        _ -> False
      }
    })

  let symbols =
    list.filter(chars, fn(char) {
      case char {
        "." -> False
        "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> False
        _ -> True
      }
    })

  io.println(
    "  Numbers: "
    <> string.inspect(list.length(numbers))
    <> ", Symbols: "
    <> string.inspect(list.length(symbols)),
  )
}
