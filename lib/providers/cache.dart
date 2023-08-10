import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import './api.dart';
import '../models/event.dart';
import '../models/team.dart';

class Cache {

  final String cacheVersion = '0.52';

  final int now = DateTime.now().millisecondsSinceEpoch;
  final int maxAgeShort = Duration(days: 1).inMilliseconds;
  final int maxAgeLong = Duration(days: 4).inMilliseconds;

  Future<bool> shouldReDownload(String key, int maxAge) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getInt('time-$key') ?? 0) + maxAge < now;
  }

  updateTime(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('time-$key', now);
  }

  setString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<String?> getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  Future<List<Event>?> getEvents() async {
    String key = '$cacheVersion-events-list';
    if (await shouldReDownload(key, maxAgeShort)) {
      List<Event> events = await (ApiV3().getEvents());
      setString(key, Event.encode(events));
      updateTime(key);
      return events;
    } else {
      return Event.allFromResponse(await getString(key) ?? '[]');
    }
  }

  Future<List<Team>?> getTeams() async {
    String key = '$cacheVersion-teams-list';
    if (await shouldReDownload(key, maxAgeLong)) {
      List<Team> teams = (await ApiV3().getTeams());
      setString(key, Team.encode(teams));
      updateTime(key);
      return teams;
    } else {
      return Team.allFromResponse(await getString(key) ?? '[]');
    }
  }
}
