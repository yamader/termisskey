module termisskey.log;

static Logger logger;
static this() {
  logger = new Logger(LogLevel.Info);
}

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
    this(LogLevel level) {
      import std.stdio: stdout, stderr;

      this(level, stderr, stdout);
    }

    this(LogLevel level, File fout, File ferr) {
      this.level = level;
      this.fout = fout;
      this.ferr = ferr;
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
