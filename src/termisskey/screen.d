module termisskey.screen;

import deimos.ncurses;
import termisskey.log;
import termisskey.config;

void screen(AppConfig conf) {
  initscr;
  scope (exit)
    endwin;
  start_color;
  cbreak;
  noecho;
  curs_set(0);
  logger.logDbg("window initialized");

  getch;
}
