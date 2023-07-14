import 'dart:convert';
import 'package:toa_flutter/models/match-details.dart';
import 'package:toa_flutter/models/game-specifics/skystone-alliance-details.dart';

class SkyStoneMatchDetails extends MatchDetails {

  SkyStoneMatchDetails({
    this.matchDetailKey,
    this.matchKey,
    this.redMinPen,
    this.blueMinPen,
    this.redMajPen,
    this.blueMajPen,
    this.randomization,

    this.red,
    this.blue
  });

  String? matchDetailKey;
  String? matchKey;
  int? redMinPen;
  int? blueMinPen;
  int? redMajPen;
  int? blueMajPen;
  int? randomization;

  dynamic red;
  dynamic blue;

  static List<SkyStoneMatchDetails>? allFromResponse(String response) {
    return json.decode(response)
        .map((obj) => SkyStoneMatchDetails.fromMap(obj))
        .toList()
        .cast<SkyStoneMatchDetails>();
  }

  static SkyStoneMatchDetails fromMap(Map map) {
    return SkyStoneMatchDetails(
      matchDetailKey: map['match_detail_key'],
      matchKey: map['match_key'],
      redMinPen: map['red_min_pen'],
      blueMinPen: map['blue_min_pen'],
      redMajPen: map['red_maj_pen'],
      blueMajPen: map['blue_maj_pen'],
      randomization: map['randomization'],

      red: map.containsKey('red') && map['red'] != null ? SkyStoneAllianceDetails.fromMap(map['red']) : null,
      blue: map.containsKey('blue') && map['blue'] != null ? SkyStoneAllianceDetails.fromMap(map['blue']) : null
    );
  }
}