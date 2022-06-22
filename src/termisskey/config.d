module termisskey.config;

import termisskey.log;
import yama.d: has, set;

struct AppConfig {
  string host;
  string token;
  // フィールド以外置きたくない
}

AppConfig loadAppConfig(string path) {
  import std.stdio: File;
  import std.file: FileException;

  File f;
  scope (exit)
    f.close;
  try {
    f = File(path, "r");
  } catch (Exception) {
    logger.logDbg("config file not found");
    return AppConfig();
  }

  import std.string: chomp;
  import std.array: join;
  import std.format: format;
  import std.typecons: tuple;

  auto ref KV(T)(T haystack, T needle) {
    auto strip(C)(C[] a) {
      import std.string: strip;

      auto s = a.strip;
      if ((s[0] == '"' && s[$ - 1] == '"') ||
          (s[0] == '\'' && s[$ - 1] == '\''))
        return s[1 .. $ - 1];
      return s;
    }

    import std.algorithm.searching: findSplit;

    auto a = haystack.findSplit(needle);
    auto key = strip(a[0]);
    auto val = strip(a[2]);
    return tuple!("key", "val")(key, val);
  }

  AppConfig conf;

  char[] buf;
  while (f.readln(buf)) {
    auto line = KV(buf.chomp.idup, "=");
    if (!conf.has(line.key)) {
      logger.logErr(`invalid config: field "` ~ line.key ~ `" unknown`);
      continue;
    }
    try {
      if (!line.val.length) {
        conf.set(line.key, "true");
        logger.logDbg(`load config "` ~ line.key ~ `": flag = "true"`);
      } else {
        conf.set(line.key, line.val);
        logger.logDbg(`load config "` ~ line.key ~ `" = "` ~ line.val ~ `"`);
      }
    } catch (Exception) {
      logger.logErr(`invalid config: "` ~ line.key ~ `" = "` ~ line.val ~ `"`);
    }
  }

  return conf;
}

AppConfig mergeConfig(AppConfig res, AppConfig mod) {
  static foreach (s; [__traits(derivedMembers, AppConfig)]) {
    {
      auto def = mixin("AppConfig." ~ s ~ ".init");
      auto val = mixin("mod." ~ s);
      if (def != val)
        mixin("res." ~ s) = val;
    }
  }
  return res;
}
