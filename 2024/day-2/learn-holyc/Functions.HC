U0 Function1(U8 *name="Terry") // We can use default arguments in functions
{
  "%s\n",name;
}

Function1; 
Function1("Davis");

U0 Function2(U8 *name="Terry", I64 age=69)
{
  "%s %d\n",name,age;
}

Function2;
Function2(,42);
Function2("Davis", 42);
