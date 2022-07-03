module termisskey.app;

import argparse: CLI;
import termisskey.config;
import termisskey.log;
import termisskey.screen;

struct Args {
  string config;
  string log;
  LogLevel loglevel;

  // AppConfig
  string config_host;
  string config_token;
}

void main(string[] argv) {
  import std.process: environment;

  enum appDir = "/termisskey";
  auto home = environment.get("HOME", ".");
  auto conf = environment.get("XDG_CONFIG_HOME", home ~ "/.config") ~ appDir;
  auto data = environment.get("XDG_DATA_HOME", home ~ "/.local/share") ~ appDir;
  Args init = {
    config: conf ~ "/config",
    log: data ~ "/log",
    loglevel: LogLevel.Info,
  };
  CLI!Args.parseArgs!app(argv[1 .. $], init);
}

void app(Args args) {
  import std.conv: to;
  import std.file: exists, mkdirRecurse, readText, FileException;
  import std.path: dirName;
  import std.stdio: File;

  // logger
  {
    try {
      if (!args.log.dirName.exists)
        args.log.dirName.mkdirRecurse;
      auto flog = File(args.log, "a");
      logger = new Logger(args.loglevel, flog, flog);
    } catch (FileException) {
      logger.logErr("can't write log file : " ~ args.log);
    }
    logger.logDbg("logger initialized");
  }

  // config
  AppConfig config;
  {
    with (config) {
      host = args.config_host;
      token = args.config_token;
    }
    if (!args.config.dirName.exists)
      args.config.dirName.mkdirRecurse;
    else if (args.config.exists)
      try {
        config = mergeConfig(args.config.readText.parseConfig, config);
      } catch (FileException) {
        logger.logErr("can't read config file : " ~ args.config);
      }
    logger.logDbg("config loaded");
    logger.logDbg(config.to!string);
  }

  // main
  screen(config);
  logger.logDbg("bye");
}
