# First pick a number. If it is odd, multiply it by three and add one; if it is even, divide it by two.
# Repeat this procedure until you arrive at one.
# E.g. 5 → odd → 3*5 + 1 = 16 → even → 16 / 2 = 8 → even → 4 → 2 → 1 → end!

proc getUserInput(): string =
    stdout.write "Enter an integer: "
    let userInput: string = readLine(stdin)
    echo "User chose: ", userInput, " as input."

proc collatzConjecture(userInput: string): int =
    if userInput % 2 != 0:
        userInput * 3 + 1
        echo userInput
    else:
        userInput / 2
        echo userInput

when isMainModule:
    let userInput = getUserInput()
    let collatzConjecture = collatzConjecture(userInput)
