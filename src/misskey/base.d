module misskey.base;

alias ID = string;
alias DateString = string;
alias Number = ulong;

alias ___Any = void*;

struct Emoji {
  string name;
  string url;
}
