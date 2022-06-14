module misskey.client.api;

import std.algorithm.iteration: map;
import std.array: array;
import std.json: JSONValue, parseJSON;
import std.net.curl: post;
import misskey.user;
import misskey.client.client;

struct AppCreate {
  string name;
  string description;
  string[] permission;
}

struct AppMeta {
  string host;
  string id;
  string name;
  string[] permission;
  string secret;

  string str() {
    return "";
  }

  AppMeta parse(string s) {
    return AppMeta();
  }
}

struct AuthSession {
  string token;
  string url;
}

AppMeta createApp(string host, AppCreate create) {
  JSONValue req;
  req["name"] = create.name;
  req["description"] = create.description;
  req["permission"] = create.permission.JSONValue;

  auto res = (host ~ "/api/app/create")
    .post(req.toString).parseJSON;
  return AppMeta(
      host,
      res["id"].str,
      res["name"].str,
      res["permission"].array.map!"a.str".array,
      res["secret"].str);
}

AuthSession startUserAuth(AppMeta app) {
  JSONValue req = ["appSecret": app.secret];
  auto res = (app.host ~ "/api/auth/session/generate")
    .post(req.toString).parseJSON;
  auto session = AuthSession(
      res["token"].str,
      res["url"].str);
  version (Posix) {
    import std.process: execute;

    ["xdg-open", session.url].execute;
  }
  return session;
}

Client submitUserAuth(AppMeta app, AuthSession session) {
  JSONValue req = ["appSecret": app.secret, "token": session.token];
  auto res = (app.host ~ "/api/auth/session/userkey")
    .post(req.toString).parseJSON;
  return new Client(
      // token: res["accessToken"].str); // DIP1030実装はよ
      res["accessToken"].str);
}
