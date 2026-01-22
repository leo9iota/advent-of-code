def parse_input(path: str) -> tuple[list[str], list[int]]:
    directions: list[str] = []  # init list for storing direction
    steps: list[int] = []  # init list for storing step

    with open(file=path, mode="r") as file:  # safely open file
        for line in file:
            clean_line: str = line.strip()  # strip whitespace and invisible '\n'
            directions += clean_line[:1]  # extract the first char
            steps.append(int(clean_line[1:]))  # extract everything after the first char

    return directions, steps


def solve() -> None:
    d, s = parse_input(path="./secret-entrance-input.txt")

    print(d, s)


solve()
