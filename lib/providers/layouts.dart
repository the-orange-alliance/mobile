import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:toa_flutter/providers/static-data.dart';

class MatchBreakdownLayouts {
  static List<MatchBreakdownLayoutElement> _currentSeason;
  static List<MatchBreakdownLayoutElement> _loadedSeason;
  static String _loadedSeasonYear;

  static Future _load(String seasonKey, {bool cache = true}) async {
    String data = await rootBundle
    // TODO CATCH THIS ERROR
        .loadString('assets/seasons/${seasonKey}.json', cache: cache);

    return json
        .decode(data)
        .map((m) => MatchBreakdownLayoutElement.fromMap(m))
        .toList()
        .cast<MatchBreakdownLayoutElement>();
  }

  static Future<void> cacheSeasonLayout(String seasonKey) async {
    if (_currentSeason == null) {
      _currentSeason = await _load(StaticData.seasonKey,
          cache: false); // in theory this will only run once...
    }

    if (_loadedSeasonYear != seasonKey && seasonKey != StaticData.seasonKey) {
      _loadedSeason = await _load(seasonKey);
      _loadedSeasonYear = seasonKey;
    }
  }

  static List<MatchBreakdownLayoutElement> getSeason(String seasonKey) {
    if (_loadedSeasonYear == seasonKey) {
      return _loadedSeason;
    } else if (seasonKey == StaticData.seasonKey) {
      return _currentSeason;
    }
  }
}

class MatchBreakdownLayoutElement {
  String name;
  String type;
  String value;
  int points;

  MatchBreakdownLayoutElement(this.name, this.type, this.value, this.points);

  static MatchBreakdownLayoutElement fromMap(dynamic m) {
    return MatchBreakdownLayoutElement(
        m['name'], m['type'], m['value'], m['points'] ?? null);
  }
}
