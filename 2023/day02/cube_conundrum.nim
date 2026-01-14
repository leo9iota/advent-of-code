import std/[strutils, parseutils, os, tables]

type
    ObservedCube* = object
        count*: int
        color*: string
    ObservedSet* = seq[ObservedCube]
    Game* = object
        id*: int
        rounds*: seq[ObservedSet]

proc parseObservedCube*(token: string): ObservedCube =
    var i = 0
    result.count = parseInt(token, i)
    # After parseInt, i is the index of the first char NOT part of the number,
    # or i == token.len if the whole string was a number.
    if i >= token.len:
        # This means the token was effectively just a number (or empty after the number).
        # There's nothing left for the color part.
        raise newException(ValueError, "Malformed cube token: missing color part after number. Token: '" &
                token & "'")
    # If we are here, i < token.len, so there are characters after the number.
    # These characters are assumed to be the color (possibly with leading/trailing spaces).
    result.color = token[i .. ^1].strip.toLowerAscii()

proc parseObservedSet*(line: string): ObservedSet =
    for part in line.split(','):
        let token = part.strip
        if token.len > 0:
            result.add parseObservedCube(token)

proc parseGameLine*(line: string): Game =
    let parts = line.split(":", maxsplit = 1) # Split after parsing `:` symbol
    if parts.len != 2:
        raise newException(ValueError, "malformed game line: " & line)
    result.id = parts[0].splitWhitespace()[1].parseInt
    let right = parts[1]
    for segment in right.split(';'): # Split after parsing `;` symbol
        let trimmed = segment.strip
        if trimmed.len > 0:
            result.rounds.add parseObservedSet(trimmed)

const bagLimits = {"red": 12, "green": 13, "blue": 14}.toTable

proc possible(g: Game): bool =
    for round in g.rounds:
        for cube in round:
            if not bagLimits.hasKey(cube.color):
                echo "Warning: unknown color '", cube.color, "'"
                return false
            if cube.count > bagLimits[cube.color]:
                return false
    result = true

proc minimumCubes(g: Game): Table[string, int] =
    result = {"red": 0, "green": 0, "blue": 0}.toTable
    for round in g.rounds:
        for cube in round:
            if cube.count > result[cube.color]:
                result[cube.color] = cube.count

proc power(g: Game): int =
    let minCubes = minimumCubes(g)
    result = minCubes["red"] * minCubes["green"] * minCubes["blue"]

when isMainModule:
    # echo "paramCount = ", paramCount()
    # for i in 1..paramCount():
    #     echo "param ", i, ": ", paramStr(i)
    let inputPath =
        if paramCount() == 1: paramStr(1)
        elif paramCount() == 2 and paramStr(1) == "--": paramStr(2)
        else: quit("Usage: day_2 <input_file>")

    var sumIds = 0
    for line in lines(paramStr(1)):
        if line.strip.len == 0: continue
        let game = parseGameLine(line)

        if game.possible:
            sumIds += game.id
            echo "[+] Game ", game.id, " (power: ", gamePower, ")"
        else:
            echo "[-] ", game

    echo "Sum of possible game IDs = ", sumIds
