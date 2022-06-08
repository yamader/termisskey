module termisskey.app;

import deimos.ncurses;
import termisskey.screen.home;

void main() {
  initscr;
  scope (exit)
    endwin;

  homeScreen;
}
