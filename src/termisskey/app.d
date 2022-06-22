module termisskey.app;

import std.conv: to;
import argparse: CLI;
import termisskey.config;
import termisskey.log;
import termisskey.screen;

struct Args {
  string config;
  string log;
  LogLevel loglevel;

  // termisskey.config.Config
  string host;
  string token;
}

void main(string[] argv) {
  import std.process: environment;

  Args args = {
    config: environment.get("HOME", ".") ~ "/.termisskeyrc",
    log: environment.get("HOME", ".") ~ "/.termisskey.log",
    loglevel: LogLevel.Info,
  };
  CLI!Args.parseArgs(args, argv[1 .. $]);

  with (args) {
    import std.stdio: File;
    import std.file: FileException;

    try {
      auto fout = File(log, "w+");
      logger = new Logger(loglevel, fout, fout);
    } catch (FileException) {
      logger = new Logger(loglevel);
      logger.logErr("can't open log file : " ~ log);
    }
  }

  AppConfig config = mergeConfig(
      loadAppConfig(args.config),
      AppConfig(
      args.token,
      args.host));
  logger.logDbg("config loaded");
  logger.logDbg(config.to!string);

  screen(config);
  logger.logDbg("bye");
}
