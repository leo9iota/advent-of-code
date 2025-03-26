class SomethingWithAnAge
{
  I64 age;
};

class Person : SomethingWithAnAge
{
  U8 name[1<<5];
};

U0 ExampleFunction(U0)
{
  Person *p = MAlloc(sizeof(Person));
  
  MemCpy(p->name,"Bob",3);
  p->age = 0;
  
  while (p->age < 42) {
  p->age++;
  }
  "name: %s, age: %d\n",p->name,p->age;
  Free(p);
}

ExampleFunction;