module misskey.drive;

import misskey.base;

class DriveFile {
  ID id;
  DateString createdAt;
  bool isSensitive;
  string name;
  string thumbnailUrl;
  string url;
  string type;
  Number size;
  string md5;
  string blurhash;
  ___Any properties;
}

class DriveFolder {
}
