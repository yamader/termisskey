module termisskey.config;

import termisskey.log;

struct Config {
  string token;
}

Config loadConfig(Logger logger) {
  with (logger) {
    import std.process: environment;
    import std.stdio: File;
    import std.file: FileException;

    auto path = environment.get("HOME", ".")
      ~ "/.termisskeyrc";
    File f;
    try
      f = File(path, "r");
    catch (FileException) {
      logDbg(`config file not found`);
      return Config();
    }
    scope (exit)
      f.close;

    import std.string: chomp;
    import std.array: split, join;
    import std.format: format;

    Config conf;

    char[] buf;
    while (f.readln(buf)) {
      auto line = buf.chomp;
      try {
        auto a = line.split("=");
        auto name = a[0];
        auto field = &__traits(getMember, conf, name);
        if (a.length == 1) {
          *field = true;
          logDbg(`load config "%s": flag = true`.format(name));
        } else {
          auto val = a[1 .. $].join("=");
          *field = val.to!(typeof(*field));
          logDbg(`load config "%s": %s = %s`.format(name, typeof(*field).stringof, val));
        }
      } catch (Exception) {
        // todo: フィールド不明と型違いと変換失敗を区別する
        logErr(`invalid config: "%s"`.format(line));
      }
    }

    return conf;
  }
}

Config mergeConfig(Config a, Config b) {
  Config conf;
  return conf;
}
