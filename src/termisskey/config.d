module termisskey.config;

import termisskey.log;
import yama.d: has, set;

struct AppConfig {
  string host;
  string token;
  // フィールド以外置きたくない
}

AppConfig parseConfig(string raw) {
  import std.typecons: tuple;
  import std.array: split;

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
  foreach (line; raw.split("\n")) {
    auto kv = KV(line, "=");
    if (kv.key == "")
      continue;
    if (!conf.has(kv.key)) {
      logger.logErr(`invalid config: field "` ~ kv.key ~ `" unknown`);
      continue;
    }
    try {
      if (!kv.val.length) {
        conf.set(kv.key, "true");
        logger.logDbg(`load config "` ~ kv.key ~ `": flag = "true"`);
      } else {
        conf.set(kv.key, kv.val);
        logger.logDbg(`load config "` ~ kv.key ~ `" = "` ~ kv.val ~ `"`);
      }
    } catch (Exception) {
      logger.logErr(`invalid config: "` ~ kv.key ~ `" = "` ~ kv.val ~ `"`);
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
