# Simple CLI Calculator in Nim


```nim
import strutils, strformat, terminal

proc askFloat(prompt: string): float =
    while true:
        stdout.styledWrite(fgGreen, prompt)
        let line = readLine(stdin)
        try: return line.parseFloat
        except ValueError:
            stdout.styledWriteLine(fgRed, "  ✖  Not a number, try again.")

proc askOp(): char =
    const ops = ['+', '-', '*', '/']
    while true:
        stdout.styledWrite(fgYellow, "Choose operator (+ - * /): ")
        let op = readLine(stdin).strip
        if op.len == 1 and op[0] in ops: return op[0]
        stdout.styledWriteLine(fgRed, "  ✖  Invalid operator, pick one of the following operators: + - * /")

when isMainModule:
    eraseScreen()
    styledEcho(fgCyan, "NimLabs Innovations Ltd. 0.1.0 – Interactive CLI calculator written in Nim\n")

    while true:
        let a = askFloat("First number: ")
        let op = askOp()
        let b = askFloat("Second number: ")

        if op == '/' and b == 0:
            styledEcho(fgRed, "  ✖  Division by zero is not allowed!\n")
            continue

        let result = case op
            of '+': a + b
            of '-': a - b
            of '*': a * b
            else: a / b
        styledEcho(fgBlue, fmt"{a} {op} {b} = {result}")

        stdout.styledWrite(fgMagenta, "Another calculation? (y/n): ")
        if readLine(stdin).strip.toLowerAscii != "y":
            styledEcho(fgCyan, "Bye!\n")
            break
```