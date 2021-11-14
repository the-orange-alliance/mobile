import 'dart:convert';
import 'package:toa_flutter/models/game-specifics/freight-frenzy-alliance-details.dart';
import 'package:toa_flutter/models/match-details.dart';
import 'package:toa_flutter/models/game-specifics/ultimategoal-alliance-details.dart';

class FreightFrenzyMatchDetails extends MatchDetails {
  FreightFrenzyMatchDetails({
    this.matchDetailKey,
    this.matchKey,
    this.redMinPen,
    this.blueMinPen,
    this.redMajPen,
    this.blueMajPen,
    this.red,
    this.blue,
  });

  String matchDetailKey;
  String matchKey;
  int redMinPen;
  int blueMinPen;
  int redMajPen;
  int blueMajPen;

  FreightFrenzyAllianceDetails red;
  FreightFrenzyAllianceDetails blue;

  static List<FreightFrenzyMatchDetails> allFromResponse(String response) {
    return json
        .decode(response)
        .map((obj) => FreightFrenzyMatchDetails.fromMap(obj))
        .toList()
        .cast<FreightFrenzyMatchDetails>();
  }

  static FreightFrenzyMatchDetails fromMap(Map map) {
    return FreightFrenzyMatchDetails(
      matchDetailKey: map['match_detail_key'],
      matchKey: map['match_key'],
      redMinPen: map['red_min_pen'],
      blueMinPen: map['blue_min_pen'],
      redMajPen: map['red_maj_pen'],
      blueMajPen: map['blue_maj_pen'],
      red: map.containsKey('red') && map['red'] != null
          ? FreightFrenzyAllianceDetails.fromMap(map['red'])
          : null,
      blue: map.containsKey('blue') && map['blue'] != null
          ? FreightFrenzyAllianceDetails.fromMap(map['blue'])
          : null,
    );
  }
}
