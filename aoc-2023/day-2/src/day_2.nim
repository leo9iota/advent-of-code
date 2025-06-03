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
    let parts = token.strip.split(' ')
    if parts.len != 2:
        raise newException(ValueError, "malformed cube token: " & token)
    result.count = parts[0].parseInt
    result.color = parts[1].toLowerAscii()

proc parseObservedSet*(line: string): ObservedSet =
    for part in line.split(','):
        let token = part.strip
        if token.len > 0:
            result.add parseObservedCube(token)

proc parseGameLine*(line: string): Game =
    let parts = line.split(":", maxsplit = 1)
    if parts.len != 2:
        raise newException(ValueError, "malformed game line: " & line)

    result.id = parts[0].splitWhitespace()[1].parseInt
    let right = parts[1]

    for segment in right.split(';'):
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
    if paramCount() == 0:
        quit "usage: day_2 <input_file>"

    var sumIds = 0
    var sumPowers = 0

    for line in lines(paramStr(1)):
        if line.strip.len == 0: continue
        let game = parseGameLine(line)
        let gamePower = power(game)

        sumPowers += gamePower

        if possible(game):
            sumIds += game.id
            echo "✔ Game ", game.id, " (power: ", gamePower, ")"
        else:
            echo "✘ Game ", game.id, " (power: ", gamePower, ")"

    echo ""
    echo "Part 1 - Sum of possible game IDs: ", sumIds
    echo "Part 2 - Sum of all game powers: ", sumPowers
