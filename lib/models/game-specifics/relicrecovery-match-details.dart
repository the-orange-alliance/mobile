import 'dart:convert';
import 'package:toa_flutter/models/match-details.dart';

class RelicRecoveryMatchDetails extends MatchDetails {

  RelicRecoveryMatchDetails({
    this.matchDetailKey,
    this.matchKey,
    this.redMinPen,
    this.blueMinPen,
    this.redMajPen,
    this.blueMajPen,
    this.redAutoJewels,
    this.redAutoGlyphs,
    this.redAutoKeys,
    this.redAutoParks,
    this.redTeleGlyphs,
    this.redTeleRows,
    this.redTeleColumns,
    this.redTeleCypher,
    this.redEndRelic1,
    this.redEndRelic2,
    this.redEndRelic3,
    this.redEndRelicStanding,
    this.redEndRobotBalances,
    this.blueAutoJewels,
    this.blueAutoGlyphs,
    this.blueAutoKeys,
    this.blueAutoParks,
    this.blueTeleGlyphs,
    this.blueTeleRows,
    this.blueTeleColumns,
    this.blueTeleCypher,
    this.blueEndRelic1,
    this.blueEndRelic2,
    this.blueEndRelic3,
    this.blueEndRelicStanding,
    this.blueEndRobotBalances,
  });
  
  String matchDetailKey;
  String matchKey;
  int redMinPen;
  int blueMinPen;
  int redMajPen;
  int blueMajPen;
  int redAutoJewels;
  int redAutoGlyphs;
  int redAutoKeys;
  int redAutoParks;
  int redTeleGlyphs;
  int redTeleRows;
  int redTeleColumns;
  int redTeleCypher;
  int redEndRelic1;
  int redEndRelic2;
  int redEndRelic3;
  int redEndRelicStanding;
  int redEndRobotBalances;
  int blueAutoJewels;
  int blueAutoGlyphs;
  int blueAutoKeys;
  int blueAutoParks;
  int blueTeleGlyphs;
  int blueTeleRows;
  int blueTeleColumns;
  int blueTeleCypher;
  int blueEndRelic1;
  int blueEndRelic2;
  int blueEndRelic3;
  int blueEndRelicStanding;
  int blueEndRobotBalances;

  static List<RelicRecoveryMatchDetails> allFromResponse(String response) {
    return json.decode(response)
        .map((obj) => RelicRecoveryMatchDetails.fromMap(obj))
        .toList()
        .cast<RelicRecoveryMatchDetails>();
  }

  static RelicRecoveryMatchDetails fromMap(Map map) {
    return RelicRecoveryMatchDetails(
      matchDetailKey: map['match_detail_key'],
      matchKey: map['match_key'],
      redMinPen: map['red_min_pen'],
      blueMinPen: map['blue_min_pen'],
      redMajPen: map['red_maj_pen'],
      blueMajPen: map['blue_maj_pen'],

      redAutoJewels: map['red_auto_jewels'],
      redAutoGlyphs: map['red_auto_glyphs'],
      redAutoKeys: map['red_auto_keys'],
      redAutoParks: map['red_auto_parks'],
      redTeleGlyphs: map['red_tele_glyphs'],
      redTeleRows: map['red_tele_rows'],
      redTeleColumns: map['red_tele_cols'],
      redTeleCypher: map['red_tele_cyphers'],
      redEndRelic1: map['red_end_relic_1'],
      redEndRelic2: map['red_end_relic_2'],
      redEndRelic3: map['red_end_relic_3'],
      redEndRelicStanding: map['red_end_relic_standing'],
      redEndRobotBalances: map['red_end_robot_balances'],

      blueAutoJewels: map['blue_auto_jewels'],
      blueAutoGlyphs: map['blue_auto_glyphs'],
      blueAutoKeys: map['blue_auto_keys'],
      blueAutoParks: map['blue_auto_parks'],
      blueTeleGlyphs: map['blue_tele_glyphs'],
      blueTeleRows: map['blue_tele_rows'],
      blueTeleColumns: map['blue_tele_cols'],
      blueTeleCypher: map['blue_tele_cyphers'],
      blueEndRelic1: map['blue_end_relic_1'],
      blueEndRelic2: map['blue_end_relic_2'],
      blueEndRelic3: map['blue_end_relic_3'],
      blueEndRelicStanding: map['blue_end_relic_standing'],
      blueEndRobotBalances: map['blue_end_robot_balances'],
    );
  }
}