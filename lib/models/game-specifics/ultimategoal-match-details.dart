import 'dart:convert';
import 'package:toa_flutter/models/match-details.dart';
import 'package:toa_flutter/models/game-specifics/ultimategoal-alliance-details.dart';

class UltimateGoalMatchDetails extends MatchDetails {

  UltimateGoalMatchDetails({
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

  String matchDetailKey;
  String matchKey;
  int redMinPen;
  int blueMinPen;
  int redMajPen;
  int blueMajPen;
  int randomization;

  UltimateGoalAllianceDetails red;
  UltimateGoalAllianceDetails blue;

  static List<UltimateGoalMatchDetails> allFromResponse(String response) {
    return json.decode(response)
        .map((obj) => UltimateGoalMatchDetails.fromMap(obj))
        .toList()
        .cast<UltimateGoalMatchDetails>();
  }

  static UltimateGoalMatchDetails fromMap(Map map) {
    return UltimateGoalMatchDetails(
        matchDetailKey: map['match_detail_key'],
        matchKey: map['match_key'],
        redMinPen: map['red_min_pen'],
        blueMinPen: map['blue_min_pen'],
        redMajPen: map['red_maj_pen'],
        blueMajPen: map['blue_maj_pen'],
        randomization: map['randomization'],

        red: map.containsKey('red') && map['red'] != null ? UltimateGoalAllianceDetails.fromMap(map['red']) : null,
        blue: map.containsKey('blue') && map['blue'] != null ? UltimateGoalAllianceDetails.fromMap(map['blue']) : null
    );
  }
}