## calc.nim – minimal CLI calculator
## usage:
##   nim r calc.nim 12 + 7
##   nim r calc.nim 5 * 3
##   nim r calc.nim 10 / 0      # division-by-zero guard
import os
import strutils, strformat # basic string helpers

proc usage() =
    echo """
    NimCalc – a tiny command-line calculator
    Usage:
        nimcalc <num1> <op> <num2>

        <op>
            +   addition
            -   subtraction
            *   multiplication
            /   division
    """
    quit 1

when isMainModule:
    ## Expect exactly three arguments after the program name.
    if paramCount() != 3:
        usage()

    # Convert the two operands to float; let Nim raise an error on bad input.
    let
        a = parseFloat(paramStr(1))
        op = paramStr(2)
        b = parseFloat(paramStr(3))

    # Perform the chosen operation.
    let result =
        case op
        of "+": a + b
        of "-": a - b
        of "*": a * b
        of "/":
            if b == 0:
                echo "Error: division by zero"
                quit 1
            else:
                a / b
        else:
            echo "Unknown operator: " & op
            usage()

    echo fmt"{a} {op} {b} = {result}"
