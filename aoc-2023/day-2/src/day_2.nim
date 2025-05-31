import std/[strutils, parseutils]

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
    let (left, right) = line.split(":", maxsplit = 1)
    result.id = left.splitWhitespace()[1].parseInt

    for segment in right.split(';'):
        let trimmed = segment.strip
        if trimmed.len > 0:
            result.rounds.add parseObservedSet(trimmed)
