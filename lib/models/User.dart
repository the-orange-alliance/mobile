import 'package:firebase_database/firebase_database.dart';

class User {
  User({
    this.name,
    this.level = 1,
    this.apiKey,
    this.favTeams,
    this.favEvents
  });

  final String name;
  final int level;
  final String apiKey;
  final Map favTeams;
  final Map favEvents;

  static User fromDataSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> map = snapshot.value;

    return User(
      name: getValue('fullName', map),
      level: getValue('level', map),
      apiKey: getValue('APIKey', map),
      favTeams: getValue('favTeams', map),
      favEvents: getValue('favEvents', map)
    );
  }


  static dynamic getValue(String key, Map map) {
    if (map != null && map[key] != null) {
      return map[key];
    }
    return null;
  }


  List<String> getTeams() {
    List<String> toReturn = List();
    if (favTeams != null) {
      List teams = favTeams.keys.toList();
      for (int i = 0; i < teams.length; i++) {
        String key = teams[i].toString();
        String value = favTeams[key].toString();
        if (value == 'true') {
          toReturn.add(key);
        }
      }
    }
    return toReturn;
  }

  List<String> getEvents() {
    List<String> toReturn = List();
    if (favEvents != null) {
      List events = favEvents.keys.toList();
      for (int i = 0; i < events.length; i++) {
        String key = events[i].toString();
        String value = favEvents[key].toString();
        if (value == 'true') {
          toReturn.add(key);
        }
      }
    }
    return toReturn;
  }
}