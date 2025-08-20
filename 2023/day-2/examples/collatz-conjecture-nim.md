# Collatz Conjecture in Nim

```nim
# First pick a number. If it is odd, multiply it by three and add one; if it is even, divide it by two.
# Repeat this procedure until you arrive at one.
# E.g. 5 → odd → 3*5 + 1 = 16 → even → 16 / 2 = 8 → even → 4 → 2 → 1 → end!

import strutils

proc collatz(n: int): void =
    var num = n
    echo "\nCollatz sequence:"
    while num != 1:
        echo num
        if num mod 2 == 0:
            num = num div 2
        else:
            num = num * 3 + 1
    echo num # print the final 1

proc getUserInput(): int =
    stdout.write "Enter a positive integer: "
    let input = readLine(stdin)
    try:
        result = parseInt(input)
        if result <= 0:
            quit("Please enter a positive integer.")
    except ValueError:
        quit("Invalid input. Please enter a valid integer.")

when isMainModule:
    let userNum = getUserInput()
    collatz(userNum)
```