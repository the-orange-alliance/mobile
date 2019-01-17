import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/game-specifics/RelicRecoveryMatchDetails.dart';
import 'package:toa_flutter/ui/widgets/MatchBreakdownRow.dart';
import 'package:toa_flutter/internationalization/Localizations.dart';

class MatchBreakdown1718 {

  static List<Widget> getRows(Match match, BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    RelicRecoveryMatchDetails details = match.gameData;
    return <Widget>[
      MatchBreakdownRow(name: local.get('breakdowns.autonomous'), red: match.redAutoScore, blue: match.blueAutoScore, title: true),
      MatchBreakdownRow(name: local.get('breakdowns.1718.auto_jewels'), red: details.redAutoJewels, blue: details.blueAutoJewels, points: 30),
      MatchBreakdownRow(name: local.get('breakdowns.1718.glyphs'), red: details.redAutoGlyphs, blue: details.blueAutoGlyphs, points: 15),
      MatchBreakdownRow(name: local.get('breakdowns.1718.cryptobox_keys'), red: details.redAutoKeys, blue: details.blueAutoKeys, points: 30),
      MatchBreakdownRow(name: local.get('breakdowns.1718.parking'), red: details.redAutoParks, blue: details.blueAutoParks, points: 10),

      MatchBreakdownRow(name: local.get('breakdowns.teleop'), red: match.redTeleScore, blue: match.blueTeleScore, title: true),
      MatchBreakdownRow(name: local.get('breakdowns.1718.glyphs'), red: details.redTeleGlyphs, blue: details.blueTeleGlyphs, points: 2),
      MatchBreakdownRow(name: local.get('breakdowns.1718.rows'), red: details.redTeleRows, blue: details.blueTeleRows, points: 10),
      MatchBreakdownRow(name: local.get('breakdowns.1718.columns'), red: details.redTeleColumns, blue: details.blueTeleColumns, points: 20),
      MatchBreakdownRow(name: local.get('breakdowns.1718.ciphers'), red: details.redTeleCypher, blue: details.redTeleCypher, points: 30),

      MatchBreakdownRow(name: local.get('breakdowns.end'), red: match.redEndScore, blue: match.blueEndScore, title: true),
      MatchBreakdownRow(name: local.get('breakdowns.1718.relics_zone_1'), red: details.redEndRelic1, blue: details.blueEndRelic1, points: 10),
      MatchBreakdownRow(name: local.get('breakdowns.1718.relics_zone_2'), red: details.redEndRelic2, blue: details.blueEndRelic2, points: 20),
      MatchBreakdownRow(name: local.get('breakdowns.1718.relics_zone_3'), red: details.redEndRelic3, blue: details.blueEndRelic2, points: 40),
      MatchBreakdownRow(name: local.get('breakdowns.1718.relics_upright'), red: details.redEndRelicStanding, blue: details.blueEndRelicStanding, points: 15),
      MatchBreakdownRow(name: local.get('breakdowns.1718.robots_balanced'), red: details.redEndRobotBalances, blue: details.blueEndRobotBalances, points: 20),

      MatchBreakdownRow(name: local.get('breakdowns.penalty'), red: match.bluePenalty, blue: match.redEndScore, title: true),
      MatchBreakdownRow(name: local.get('breakdowns.minor_penalty'), red: details.blueMinPen, blue: details.redMinPen, points: 10),
      MatchBreakdownRow(name: local.get('breakdowns.major_penalty'), red: details.blueMajPen, blue: details.redMajPen, points: 40),
    ];
  }
}