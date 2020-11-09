class TOAUser extends Object {

  String uid;
  String email;
  bool isEmailVerified;
  String displayName;
  String photoURL;
  String phoneNumber;
  bool isDisabled;
  String team;
  num level;
  List favoriteTeams;
  List favoriteEvents;


  TOAUser({
    this.uid,
    this.email,
    this.isEmailVerified,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
    this.isDisabled,
    this.team,
    this.level,
    this.favoriteTeams,
    this.favoriteEvents
  });

  TOAUser.fromJson(json) {
    uid = json['uid'];
    email = json['email'];
    isEmailVerified = json['emailVerified'];
    displayName = json['displayName'];
    photoURL = json['photoURL'];
    phoneNumber = json['phoneNumber'];
    isDisabled = json['disabled'];
    team = json['team'];
    level = json['level'];
    favoriteTeams = json['favorite_teams'];
    favoriteEvents = json['favorite_events'];
  }
}