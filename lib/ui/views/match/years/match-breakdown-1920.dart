import 'package:flutter/material.dart';

import '../../../../internationalization/localizations.dart';
import '../../../../models/match.dart';
import '../../../../models/game-specifics/skystone-match-details.dart';
import '../../../../models/game-specifics/skystone-alliance-details.dart';
import '../../../widgets/match-breakdown-row.dart';

class MatchBreakdown1920 {
  static List<Widget> getRows(Match match, BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    SkyStoneMatchDetails details = match.gameData;
    return <Widget>[
      MatchBreakdownRow(
          name: local.get('breakdowns.autonomous'),
          red: match.redAutoScore,
          blue: match.blueAutoScore,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.repositioning_foundation'),
          red: details.red.repositionPoints,
          blue: details.blue.repositionPoints,
          points: 10),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.delivering_skystones'),
          red: details.red.autoDeliveredSkystones,
          blue: details.blue.autoDeliveredSkystones,
          points: 10),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.stones_under_skybridge'),
          red: details.red.autoDeliveredStones,
          blue: details.blue.autoDeliveredStones,
          points: 2),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.stones_on_foundation'),
          red: details.red.autoPlaced,
          blue: details.blue.autoPlaced,
          points: 4),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.navigate_skybridge'),
          red: (details.red.robot1Nav ? 1 : 0) + (details.red.robot2Nav ? 1 : 0),
          blue: (details.blue.robot1Nav ? 1 : 0) + (details.blue.robot2Nav ? 1 : 0),
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.teleop'),
          red: match.redTeleScore,
          blue: match.blueTeleScore,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.delivering_stones_skybridge'),
          red: details.red.teleDelivered,
          blue: details.blue.teleDelivered,
          points: 1),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.stones_on_foundation'),
          red: details.red.telePlaced,
          blue: details.blue.telePlaced,
          points: 1),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.skyscraper_bonus'),
          red: details.red.towerBonus,
          blue: details.blue.towerBonus,
          points: 2),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.returned_stones'),
          red: details.red.teleReturned,
          blue: details.blue.teleReturned,
          points: -1),
      MatchBreakdownRow(
          name: local.get('breakdowns.end'),
          red: match.redEndScore,
          blue: match.blueEndScore,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.capping_bonus'),
          red: details.red.towerCappingBonus,
          blue: details.blue.towerCappingBonus,
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.level_bonus'),
          red: getCapLevel(details.red),
          blue: getCapLevel(details.blue),
          points: 1),
      MatchBreakdownRow(
          name: local.get('breakdowns.skystone.robots_parked'),
          red: details.red.endRobotsParked,
          blue: details.blue.endRobotsParked,
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.penalty'),
          red: match.bluePenalty,
          blue: match.redPenalty,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.minor_penalty'),
          red: details.blueMinPen,
          blue: details.redMinPen,
          points: 10),
      MatchBreakdownRow(
          name: local.get('breakdowns.major_penalty'),
          red: details.blueMajPen,
          blue: details.redMajPen,
          points: 40),
    ];
  }

  static getCapLevel(SkyStoneAllianceDetails allianceDetails) {
    int level1 = allianceDetails.robot1CapLevel == -1 ? 0 : allianceDetails.robot1CapLevel;
    int level2 = allianceDetails.robot2CapLevel == -1 ? 0 : allianceDetails.robot2CapLevel;
    return level1 + level2;
  }
}
