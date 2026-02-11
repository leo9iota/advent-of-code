from typing import Final


def parse_input(path: str) -> tuple[list[str], list[int]]:
    directions: list[str] = []  # init list for storing directions
    steps: list[int] = []  # init list for storing steps

    with open(file=path, mode="r") as file:  # safely open file
        for line in file:
            clean_line: str = line.strip()  # strip whitespace and invisible '\n'
            if not clean_line:
                continue  # skip empty lines
            directions.append(clean_line[:1])  # extract the first char
            steps.append(int(clean_line[1:]))  # extract everything after the first char

    return directions, steps


def solve_part_1() -> None:
    # range of the circular-shaped dial, it can go from 0 to 99, which is 100 steps
    DIAL_RANGE: Final = 100
    START_POS: Final = 50  # Advent of Code 2025 Day 1 starts the dial at 50

    # call input parser and catch return in a tuple
    directions, steps = parse_input(path="./secret-entrance-input.txt")

    # init and declare current dial pos (0-99) and the counter for landing on zero
    current_pos: int = START_POS
    zero_landings: int = 0

    # iterate through instructions using zip
    for d, s in zip(directions, steps, strict=True):
        # calculate move based on direction
        if d == "R":
            current_pos += s
        else:
            current_pos -= s

        # use modulo to wrap the dial around the 0-99 range
        current_pos %= DIAL_RANGE

        # increment counter if the dial stopped exactly on zero
        if current_pos == 0:
            zero_landings += 1

    print(f"Final dial position: {current_pos}")
    print(f"Total times landed on zero: {zero_landings}")


if __name__ == "__main__":
    solve_part_1()
