module termisskey.config;

import termisskey.log;
import yama.d: has, set;

struct Config {
  string host;
  string token;
  // フィールド以外置きたくない
}

Config loadConfig(Logger logger) {
  with (logger) {
    import std.process: environment;
    import std.stdio: File;
    import std.file: FileException;

    auto path = environment.get("HOME", ".") ~ "/.termisskeyrc";
    File f;
    scope (exit)
      f.close;
    try {
      f = File(path, "r");
    } catch (Exception) {
      logDbg(`config file not found`);
      return Config();
    }

    import std.string: chomp;
    import std.array: join;
    import std.format: format;
    import std.typecons: tuple;

    auto ref KV(T)(T haystack, T needle) {
      import std.algorithm.searching: findSplit;
      import std.string: strip;

      auto a = haystack.findSplit(needle);
      return tuple!("key", "val")(a[0].strip, a[2].strip);
    }

    Config conf;

    char[] buf;
    while (f.readln(buf)) {
      auto line = KV(buf.chomp.idup, "=");
      if (!conf.has(line.key)) {
        logErr(`invalid config: member "%s" not found`.format(line.key));
        continue;
      }
      try {
        if (!line.val.length) {
          conf.set(line.key, "true");
          logDbg(`load config "%s": flag = "true"`.format(line.key));
        } else {
          conf.set(line.key, line.val);
          logDbg(`load config "%s" = "%s"`.format(line.key, line.val));
        }
      } catch (Exception) {
        logErr(`invalid config: "%s" = "%s"`.format(line.key, line.val));
      }
    }

    return conf;
  }
}

Config mergeConfig(Config a, Config b) {
  Config conf;
  return conf;
}
