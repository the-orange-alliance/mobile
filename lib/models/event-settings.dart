import 'dart:convert';

class EventSettings {

  String admin;
  bool isFavorite;
  bool matchScored;
  bool scheduleUpdated;
  bool awardsPosted;
  bool alliancesPosted;

  EventSettings({
    this.admin,
    this.isFavorite,
    this.matchScored,
    this.scheduleUpdated,
    this.awardsPosted,
    this.alliancesPosted,
  });

  static EventSettings fromResponse(String response) {
    return EventSettings.fromMap(jsonDecode(response));
  }

  factory EventSettings.fromMap(Map<String, dynamic> map) {
    return EventSettings(
      admin: map['admin'],
      isFavorite: map['favorite'],
      matchScored: map['subscriptions']['match_scored'],
      scheduleUpdated: map['subscriptions']['schedule_updated'],
      awardsPosted: map['subscriptions']['awards_posted'],
      alliancesPosted: map['subscriptions']['alliances_posted'],
    );
  }

  Map<String, dynamic> toJson() => {
    'favorite': isFavorite,
    'admin': admin,
    'subscriptions': {
      'match_scored': matchScored,
      'schedule_updated': scheduleUpdated,
      'awards_posted': awardsPosted,
      'alliances_posted': alliancesPosted
    }
  };
}