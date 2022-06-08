module misskey.user;

import misskey.base;
import misskey.instance;
import misskey.note;
import misskey.page;
import misskey.drive;

enum UserStatus {
  Online = "online",
  Active = "active",
  Offline = "offline",
  Unknown = "unknown",
}

enum FFVisiblity {
  Public = "public",
  Followers = "followers",
  Private = "private",
}

struct Field {
  string name;
  string value;
}

alias User = UserLite;

class UserLite {
  ID id;
  string username;
  string host;
  string name;
  UserStatus onlineStatus;
  string avatarUrl;
  string avatarBlurhash;
  Emoji[] emojis;
  Instance instance;
}

class UserDetailed : UserLite {
  string bannerBlurhash;
  string bannerColor;
  string bannerUrl;
  string birthday;
  DateString createdAt;
  string description;
  FFVisiblity ffVisiblity;
  Field[] fields;
  Number followersCount;
  Number followingCount;
  bool hasPendingFollowRequestFromYou;
  bool hasPendingFollowRequestToYou;
  bool isAdmin;
  bool isBlocked;
  bool isBlocking;
  bool isBot;
  bool isCat;
  bool isFollowed;
  bool isFollowing;
  bool isLocked;
  bool isModerator;
  bool isMuted;
  bool isSilenced;
  bool isSuspended;
  string lang;
  DateString lastFetchedAt;
  string location;
  Number notesCount;
  ID[] pinnedNoteIds;
  Note[] pinnedNotes;
  Page pinnedPage;
  string pinnedPageId;
  bool publicReactions;
  bool securityKeys;
  bool twoFactorEnabled;
  DateString updatedAt;
  string uri;
  string url;
}

class UserGroup {
}

class UserList {
  ID id;
  DateString createdAt;
  string name;
  typeof(User.id)[] userIds;
}

class MeDetailed : UserDetailed {
  typeof(DriveFile.id) avatarId;
  typeof(DriveFile.id) bannerId;
  bool autoAcceptFollowed;
  bool alwaysMarkNsfw;
  bool carefulBot;
  string[] emailNotificationTypes;
  bool hasPendingReceivedFollowRequest;
  bool hasUnreadAnnouncement;
  bool hasUnreadAntenna;
  bool hasUnreadChannel;
  bool hasUnreadMentions;
  bool hasUnreadMessagingMessage;
  bool hasUnreadNotification;
  bool hasUnreadSpecifiedNotes;
  bool hideOnlineStatus;
  bool injectFeaturedNote;
  ___Any integrations;
  bool isDeleted;
  bool isExplorable;
  string[][] mutedWords;
  string[] mutingNotificationTypes;
  bool noCrawle;
  bool receiveAnnouncementEmail;
  bool usePasswordLessLogin;
  // ... : any
}
