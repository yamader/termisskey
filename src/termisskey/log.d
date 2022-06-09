module termisskey.log;

enum LogLevel {
  Error,
  Warn,
  Info,
  Debug,
}

struct Logger {
  import std.stdio: File, stdout, stderr;

  private:
    LogLevel level;

  public:
    void log(string msg, LogLevel level = LogLevel.Info, File f = stdout) {
      auto txt = msg;
      if (level <= this.level) {
        f.writeln(txt);
      }
    }

    void logErr(string msg) {
      log(msg, LogLevel.Error, stderr);
    }

    void logDbg(string msg) {
      log(msg, LogLevel.Debug);
    }
}
