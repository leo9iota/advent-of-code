# HolyC Compiler Build Guide

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