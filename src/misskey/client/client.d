module misskey.client.client;

import misskey.user;

class Client {
  private:
    string token;
  public:
    this(string token) {
      this.token = token;
    }
}
