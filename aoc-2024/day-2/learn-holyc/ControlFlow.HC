// REMINDER: Don't use switch statements, they're broken xd (pls fix James Barford)

// if statement
I64 i_if = 10;
if (i_if < 9) {
  "something\n";
} else if (i_if == 20) {
  "something else\n";
} else {
  "%d\n",i_if;
}

// while loop
I64 i_while = 0;
while (i_while++ < 10) {
  "%d\n",i_while;
}

// switch statements
// I64 i_switch;
// switch (i_switch) {
//   case: "zero\n"; break;         // Implicit case statements start at 0
//   case: "one\n"; break;          // ... and increment by 1 each time.
//   case: "two\n"; break;
//   case 3: "three\n"; break;      // Explicit cases work as you would expect.
//   case 4...8: "others\n"; break; // Cases 4 through 8 will print "others\n".
// }

// do-while loop
I64 i_do_while = 10;
do {
  "%d\n",i_do_while;
} while (--i_do_while >= 0);

// for loop
for (I64 i = 0; i < 10; ++i) {
  "%d\n",i;
}

// for-in loop (basically a range loop)
U0 Main()
{
  I64 arr[] = {1,2,3,4};

  /* prints 1 2 3 4*/
  for (auto it : arr) {
    "%d\n",it;
  }
}

// break and continue statements
I64 x_break = 0;
while (TRUE) {
  x_break++;
  if (x_break < 4) {
    continue;
  }
  "x=%d\n",x_break;
  
  if (x_break == 10) {
    break;
  }
}

// goto statement
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

// fizz buzz
for (I64 i_bussin = 1; i_bussin < 69; i_bussin++) {
  if (i_bussin % 3 == 0 && i_bussin % 5 == 0) {
    "FizzBuzz\n";
  } else if (i_bussin % 3 == 0) {
    "Fizz\n";
  } else if (i_bussin % 5 == 0) {
    "Buzz\n";
  } else {
    i_bussin;
  }
}