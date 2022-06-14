module termisskey.app;

import termisskey.config;
import termisskey.log;
import termisskey.screen;

void main(string[] args) {
  auto logger = new Logger;
  with (logger) {
    auto config = mergeConfig(
        loadConfig(logger),
        args.parse);
    logDbg("config generated");
    // print config
    screen(config, logger);
    logDbg("bye");
  }
}

Config parse(string[] args) {
  return Config();
}
