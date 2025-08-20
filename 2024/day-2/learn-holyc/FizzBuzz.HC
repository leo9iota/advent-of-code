U0 Main()
{
  I64 i;
  
  for (i=1; i<=100; i++) {
    if (i % 3 == 0 && i % 5 == 0)
      Print("FizzBuzz\n");
    else if (i % 3 == 0)
      Print("Fizz\n");
    else if (i % 5 == 0)
      Print("Buzz\n");
    else
      Print("%d\n", i);
  }
}

Main();