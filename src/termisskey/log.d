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
  import std.conv: to;
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

    void log(string msg, size_t line = __LINE__, string mod = __MODULE__, string func = __FUNCTION__) {
      logFmt(msg, LogLevel.Info, fout, ctxFmt(line, mod, func));
    }

    void logErr(string msg, size_t line = __LINE__, string mod = __MODULE__, string func = __FUNCTION__) {
      logFmt(msg, LogLevel.Error, ferr, ctxFmt(line, mod, func));
    }

    void logDbg(string msg, size_t line = __LINE__, string mod = __MODULE__, string func = __FUNCTION__) {
      logFmt(msg, LogLevel.Debug, fout, ctxFmt(line, mod, func));
    }

  private:
    static string ctxFmt(size_t line, string mod, string func) {
      return mod ~ ":" ~ line.to!string ~ " " ~ func;
    }

    void logFmt(string msg, LogLevel level, File f, string ctx) {
      import std.datetime.systime: Clock;

      auto ts = Clock.currTime.to!string;
      auto txt = "[" ~ ts ~ "]\t" ~ level.to!string ~ "\t(" ~ ctx ~ ")\t" ~ msg;
      logRaw(txt, level, f);
    }

    void logRaw(string txt, LogLevel level, File f) {
      if (level <= this.level)
        f.writeln(txt);
    }
}
