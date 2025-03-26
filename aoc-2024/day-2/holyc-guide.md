# HolyC Instructions

## Build Compiler

1. Clone the repository from GitHub

```sh
https://github.com/Jamesbarford/holyc-lang.git
```

2. Change directory into project then build it


```sh
cd holyc-lang && make && sudo make install && make unit-test
```

3. Compile the project

```sh
make -C ./build
```

4. Install it onto your system

```sh
sudo make -C ./build install
```

## Compiler & Run

1. Compile the `.HC` file

```sh
hcc -o holyTemple holyTemple.HC
```

2. Run the `a.out` file

```sh
chmod +x holyTemple.out && ./holyTemple.out 
```

## Naming Convention

- **File Names**: Use camelCase.
- **Function Names**: Use PascalCase.
- **Variables**: Use snake_case.