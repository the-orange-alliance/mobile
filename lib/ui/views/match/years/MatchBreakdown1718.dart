import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/game-specifics/RelicRecoveryMatchDetails.dart';
import 'package:toa_flutter/ui/widgets/MatchBreakdownRow.dart';

class MatchBreakdown1718 {

  static List<Widget> getRows(Match match) {
    RelicRecoveryMatchDetails details = match.gameData;
    return <Widget>[
      MatchBreakdownRow(name: 'Autonomous', red: match.redAutoScore, blue: match.blueAutoScore, title: true),
      MatchBreakdownRow(name: 'Single Jewel Remaining', red: details.redAutoJewels, blue: details.blueAutoJewels, points: 30),
      MatchBreakdownRow(name: 'Glyphs', red: details.redAutoGlyphs, blue: details.blueAutoGlyphs, points: 15),
      MatchBreakdownRow(name: 'Cryptobox Keys', red: details.redAutoKeys, blue: details.blueAutoKeys, points: 30),
      MatchBreakdownRow(name: 'Parking', red: details.redAutoParks, blue: details.blueAutoParks, points: 10),

      MatchBreakdownRow(name: 'TeleOp', red: match.redTeleScore, blue: match.blueTeleScore, title: true),
      MatchBreakdownRow(name: 'Glyphs', red: details.redTeleGlyphs, blue: details.blueTeleGlyphs, points: 2),
      MatchBreakdownRow(name: 'Rows in Cryptoboxes', red: details.redTeleRows, blue: details.blueTeleRows, points: 10),
      MatchBreakdownRow(name: 'Columns in Cryptoboxes', red: details.redTeleColumns, blue: details.blueTeleColumns, points: 20),
      MatchBreakdownRow(name: 'Ciphers', red: details.redTeleCypher, blue: details.redTeleCypher, points: 30),

      MatchBreakdownRow(name: 'End Game', red: match.redEndScore, blue: match.blueEndScore, title: true),
      MatchBreakdownRow(name: 'Relics in Zone 1', red: details.redEndRelic1, blue: details.blueEndRelic1, points: 10),
      MatchBreakdownRow(name: 'Relics in Zone 2', red: details.redEndRelic2, blue: details.blueEndRelic2, points: 20),
      MatchBreakdownRow(name: 'Relics in Zone 3', red: details.redEndRelic3, blue: details.blueEndRelic2, points: 40),
      MatchBreakdownRow(name: 'Relics Upright', red: details.redEndRelicStanding, blue: details.blueEndRelicStanding, points: 15),
      MatchBreakdownRow(name: 'Robots Balanced', red: details.redEndRobotBalances, blue: details.blueEndRobotBalances, points: 20),

      MatchBreakdownRow(name: 'Penalty', red: match.bluePenalty, blue: match.redEndScore, title: true),
      MatchBreakdownRow(name: 'Minor Penalty', red: details.blueMinPen, blue: details.redMinPen, points: 10),
      MatchBreakdownRow(name: 'Major Penalty', red: details.blueMajPen, blue: details.redMajPen, points: 40),
    ];
  }
}