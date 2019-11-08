import 'dart:convert';
import 'package:toa_flutter/models/match-details.dart';

class RoverRuckusMatchDetails extends MatchDetails {

  RoverRuckusMatchDetails({
    this.matchDetailKey,
    this.matchKey,
    this.redMinPen,
    this.blueMinPen,
    this.redMajPen,
    this.blueMajPen,
    this.redAutoLand,
    this.redAutoSamp,
    this.redAutoClaim,
    this.redAutoPark,
    this.redDriverGold,
    this.redDriverSilver,
    this.redDriverDepot,
    this.redEndLatch,
    this.redEndIn,
    this.redEndComp,

    this.blueAutoLand,
    this.blueAutoSamp,
    this.blueAutoClaim,
    this.blueAutoPark,
    this.blueDriverGold,
    this.blueDriverSilver,
    this.blueDriverDepot,
    this.blueEndLatch,
    this.blueEndIn,
    this.blueEndComp,
  });
  
  String matchDetailKey;
  String matchKey;
  int redMinPen;
  int blueMinPen;
  int redMajPen;
  int blueMajPen;
  
  int redAutoLand;
  int redAutoSamp;
  int redAutoClaim;
  int redAutoPark;
  int redDriverGold;
  int redDriverSilver;
  int redDriverDepot;
  int redEndLatch;
  int redEndIn;
  int redEndComp;
  
  int blueAutoLand;
  int blueAutoSamp;
  int blueAutoClaim;
  int blueAutoPark;
  int blueDriverGold;
  int blueDriverSilver;
  int blueDriverDepot;
  int blueEndLatch;
  int blueEndIn;
  int blueEndComp;

  static List<RoverRuckusMatchDetails> allFromResponse(String response) {
    return json.decode(response)
        .map((obj) => RoverRuckusMatchDetails.fromMap(obj))
        .toList()
        .cast<RoverRuckusMatchDetails>();
  }

  static RoverRuckusMatchDetails fromMap(Map map) {
    return RoverRuckusMatchDetails(
      matchDetailKey: map['match_detail_key'],
      matchKey: map['match_key'],
      redMinPen: map['red_min_pen'],
      blueMinPen: map['blue_min_pen'],
      redMajPen: map['red_maj_pen'],
      blueMajPen: map['blue_maj_pen'],

      redAutoLand: map['red_auto_land'],
      redAutoSamp: map['red_auto_samp'],
      redAutoClaim: map['red_auto_claim'],
      redAutoPark: map['red_auto_park'],
      redDriverGold: map['red_tele_gold'],
      redDriverSilver: map['red_tele_silver'],
      redDriverDepot: map['red_tele_depot'],
      redEndLatch: map['red_end_latch'],
      redEndIn: map['red_end_in'],
      redEndComp: map['red_end_comp'],
      
      blueAutoLand: map['blue_auto_land'],
      blueAutoSamp: map['blue_auto_samp'],
      blueAutoClaim: map['blue_auto_claim'],
      blueAutoPark: map['blue_auto_park'],
      blueDriverGold: map['blue_tele_gold'],
      blueDriverSilver: map['blue_tele_silver'],
      blueDriverDepot: map['blue_tele_depot'],
      blueEndLatch: map['blue_end_latch'],
      blueEndIn: map['blue_end_in'],
      blueEndComp: map['blue_end_comp'],
    );
  }
}