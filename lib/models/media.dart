import 'dart:convert';

class Media {
  Media({
    this.mediaKey,
    this.eventKey,
    this.teamKey,
    this.mediaType,
    this.isPrimary,
    this.mediaTitle,
    this.mediaLink,
  });

  final String? mediaKey;
  final String? eventKey;
  final String? teamKey;
  final int? mediaType;
  final bool? isPrimary;
  final String? mediaTitle;
  final String? mediaLink;
  
  static List<Media> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => Media.fromMap(obj))
        .toList()
        .cast<Media>();
  }

  static Media fromMap(Map map) {
    return Media(
      mediaKey: map['media_key'],
      eventKey: map['event_key'],
      teamKey: map['team_key'],
      mediaType: map['media_type'],
      isPrimary: map['is_primary'],
      mediaTitle: map['title'],
      mediaLink: map['link']
    );
  }
}

class TeamMediaType {
/*
    Team:
    0 - GitHub Repo/Profile
    1 - CAD Design
    2 - Engineering Notebook
    3 - Robot Reveal
    4 - Robot Image
    5 - Team Logo
*/

  static const int GITHUB = 0;
  static const int CAD = 1;
  static const int NOTEBOOK = 2;
  static const int ROBOT_REVEAL = 3;
  static const int ROBOT_IMAGE = 4;
  static const int TEAM_LOGO = 5;
}