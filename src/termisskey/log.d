module termisskey.log;

enum LogLevel {
  Error,
  Info,
  Debug,
}

class Logger {
  import std.stdio: File;

  private:
    LogLevel level;
    File fout, ferr;

  public:
    this() {
      import std.stdio: stdout, stderr;

      this.level = LogLevel.Info;
      this.fout = stdout;
      this.ferr = stderr;
    }

    void log(string msg) {
      _log(msg, LogLevel.Info, fout);
    }

    void logErr(string msg) {
      _log(msg, LogLevel.Error, ferr);
    }

    void logDbg(string msg) {
      _log(msg, LogLevel.Debug, fout);
    }

  private:
    void _log(string msg, LogLevel level, File f) {
      auto txt = msg;
      if (level <= this.level)
        f.writeln(txt);
    }
}
