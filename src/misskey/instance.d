module misskey.instance;

import misskey.base;

class Instance {
  ID id;
  DateString caughtAt;
  string host;
  Number usersCount;
  Number notesCount;
  Number followingCount;
  Number followerCount;
  Number driveUsage; // integer
  Number driveFiles;
  DateString latestRequestSentAt;
  Number latestStatus;
  DateString latestRequestReceivedAt;
  DateString lastCommunicatedAt;
  bool isNotResponding;
  bool isSuspended;
  string softwareName;
  string softwareVersion;
  bool openRegistrations;
  string name;
  string description;
  string maintainerName;
  string maintainerEmail;
  string iconUrl;
  string faviconUrl;
  string themeColor;
  DateString infoUpdatedAt;
}
