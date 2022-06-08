module misskey.page;

import misskey.base;
import misskey.user;
import misskey.drive;

class Page {
  ID id;
  DateString createdAt;
  DateString updatedAt;
  typeof(User.id) userId;
  User user;
  ___Any content;
  ___Any variables;
  string title;
  string name;
  string summary;
  bool hideTitleWhenPinned;
  bool alignCenter;
  string font;
  string script;
  typeof(DriveFile.id) eyeCatchingImageId;
  DriveFile eyeCatchingImage;
  ___Any attachedFields;
  Number likedCount;
  bool isLiked;
}
