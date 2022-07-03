# termisskey

A TUI client of Misskey

## Requirements

- [ncurses](https://invisible-island.net/ncurses/)
- [yama.d](https://github.com/yamader/yama.d)

## Build

```
% docker build -t termisskey .
% docker cp $(docker create termisskey):work/termisskey/build/termisskey .
```
This makes `termisskey` in the current directory.
