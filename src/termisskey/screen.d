module termisskey.screen;

import deimos.ncurses;
import termisskey.log;
import termisskey.config;

void screen(Config conf, Logger logger) {
  with (logger) {
    initscr;
    scope (exit)
      endwin;
    start_color;
    cbreak;
    noecho;
    curs_set(0);
    logDbg("window initialized");

    getch;
  }
}
