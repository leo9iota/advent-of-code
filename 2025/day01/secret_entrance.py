def parse_input(path: str) -> tuple[list[str], list[int]]:
    directions: list[str] = []  # init list for storing directions
    steps: list[int] = []  # init list for storing steps

    with open(file=path, mode="r") as file:  # safely open file
        for line in file:
            clean_line: str = line.strip()  # strip whitespace and invisible '\n'
            directions.append(clean_line[:1])  # extract the first char
            steps.append(int(clean_line[1:]))  # extract everything after the first char

    return directions, steps


def solve() -> None:
    direction, step = parse_input(path="./example-input.txt")

    current_pos = 0

    for d, s in zip(direction, step, strict=False):
        if d == "R":
            current_pos += s
        elif d == "L":
            current_pos -= s

        current_pos %= 100

    print(f"Final Dial Position: {current_pos}")


solve()
