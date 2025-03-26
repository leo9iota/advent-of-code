// REMINDER: Don't use switch statements, they're broken xd

I64 i = 10;
if (i < 9) {
  "something\n";
} else if (i == 20) {
  "something else\n";
} else {
  "%d\n",i;
}

I64 i = 0;
while (i++ < 10) {
  "%d\n",i;
}

I64 i = 10;
do {
  "%d\n",i;
} while (--i >= 0);

for (I64 i = 0; i < 10; ++i) {
  "%d\n",i;
}

U0 Main()
{
  I64 arr[] = {1,2,3,4};

  /* prints 1 2 3 4*/
  for (auto it : arr) {
    "%d\n",it;
  }
}

I64 x = 0;
while (TRUE) {
  x++;
  if (x < 4) {
    continue;
  }
  "x=%d\n",x;
  
  if (x == 10) {
    break;
  }
}

U0 Function(I64 i)
{
  if (i < 10) {
    goto out;
  } else {
    "x is not less than 10\n";
  }

out:
  return;
}