module misskey.note;

import misskey.base;
import misskey.user;
import misskey.drive;

enum NoteVisiblity {
  Public = "public",
  Home = "home",
  Followers = "followers",
  Specified = "specified",
}

struct Poll {
  DateString expiresAt;
  bool multiple;
  Choice[] choices;

  struct Choice {
    bool isVoted;
    string text;
    Number votes;
  }
}

class Note {
  ID id;
  DateString createdAt;
  string text;
  string cw;
  User user;
  typeof(User.id) userId;
  Note reply;
  typeof(Note.id) replyId;
  Note renote;
  typeof(Note.id) renoteId;
  DriveFile[] files;
  typeof(DriveFile.id)[] fileIds;
  NoteVisiblity visiblity;
  typeof(User.id)[] visibleUserIds;
  bool localOnly;
  string myReaction;
  ___Any reactions;
  Number renoteCount;
  Number repliesCount;
  Poll poll;
  Emoji[] emojis;
  string uri;
  string url;
  bool isHidden;
}
