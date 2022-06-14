module termisskey.config;

import termisskey.log;

struct Config {
  string token;
}

bool has(Config self, string name) {
  foreach (s; [__traits(allMembers, typeof(self))]) switch (s) {
  case "has":
  case "setStr":
    continue;
  default:
    if (s == name)
      return true;
  }
  return false;
}

void setStr(Config self, string name, string val) {
  switch (name) {
  case "token":
    self.token = val;
    break;
  default:
    throw new Exception("AAGGHHHHHH");
  }
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
          conf.setStr(line.key, "true");
          logDbg(`load config "%s": flag = "true"`.format(line.key));
        } else {
          conf.setStr(line.key, line.val);
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
