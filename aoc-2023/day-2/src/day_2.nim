import std/[strutils, parseutils, os]

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
    result.color = token[i .. ^1].strip.toLowerAscii()

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
            if cube.count > bagLimits[cube.color]:
                return false
    result = true

when isMainModule:
    if paramCount() == 0:
        quit "usage: day_2 <input_file>"

    var sumIds = 0
    for line in lines(paramStr(1)):
        if line.strip.len == 0: continue
        let game = parseGameLine(line)

        if game.possible:
            sumIds += game.id
            echo "✔ ", game
        else:
            echo "✘ ", game

    echo "Sum of possible game IDs = ", sumIds
