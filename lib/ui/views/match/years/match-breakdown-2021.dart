import 'package:flutter/material.dart';

import '../../../../internationalization/localizations.dart';
import '../../../../models/match.dart';
import '../../../widgets/match-breakdown-row.dart';
import 'package:toa_flutter/models/game-specifics/ultimategoal-match-details.dart';

class MatchBreakdown2021 {
  static List<Widget> getRows(Match match, BuildContext context, bool isRemote) {
    TOALocalizations local = TOALocalizations.of(context);
    UltimateGoalMatchDetails details = match.gameData;
    return <Widget>[
      MatchBreakdownRow(
          name: local.get('breakdowns.autonomous'),
          red: match.redAutoScore,
          blue: match.blueAutoScore,
          half: isRemote,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_high'),
          red: details.red.autoTowerHigh,
          blue: details.blue.autoTowerHigh,
          half: isRemote,
          points: 12),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_middle'),
          red: details.red.autoTowerMid,
          blue: details.blue.autoTowerMid,
          half: isRemote,
          points: 6),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_low'),
          red: details.red.autoTowerLow,
          blue: details.blue.autoTowerLow,
          half: isRemote,
          points: 3),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.power_shots'),
          red: details.red.autoPowerShotPoints ~/ 15,
          blue: details.blue.autoPowerShotPoints != null ? details.blue.autoPowerShotPoints ~/ 15 : 0,
          half: isRemote,
          points: 15),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_1_delivered'),
          red: details.red.wobbleDelivered1,
          blue: details.blue.wobbleDelivered1,
          half: isRemote,
          points: 15),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_2_delivered'),
          red: details.red.wobbleDelivered2,
          blue: details.blue.wobbleDelivered2,
          half: isRemote,
          points: 15),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.robot_1_navigated'),
          red: details.red.navigated1,
          blue: details.blue.navigated1,
          half: isRemote,
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.robot_2_navigated'),
          red: details.red.navigated2,
          blue: details.blue.navigated2,
          half: isRemote,
          points: 5),

      MatchBreakdownRow(
          name: local.get('breakdowns.teleop'),
          red: match.redTeleScore,
          blue: match.blueTeleScore,
          half: isRemote,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_high'),
          red: details.red.dcTowerHigh,
          blue: details.blue.dcTowerHigh,
          half: isRemote,
          points: 6),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_middle'),
          red: details.red.dcTowerMid,
          blue: details.blue.dcTowerMid,
          half: isRemote,
          points: 4),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_low'),
          red: details.red.dcTowerLow,
          blue: details.blue.dcTowerLow,
          half: isRemote,
          points: 2),

      MatchBreakdownRow(
          name: local.get('breakdowns.end'),
          red: match.redEndScore,
          blue: match.blueEndScore,
          half: isRemote,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_1_rings'),
          red: details.red.wobbleRings1,
          blue: details.blue.wobbleRings1,
          half: isRemote,
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_2_rings'),
          red: details.red.wobbleRings2,
          blue: details.blue.wobbleRings2,
          half: isRemote,
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_1_end_position'),
          red: getUltimateGoalWobbleString(details.red.wobbleRings1, local),
          blue: getUltimateGoalWobbleString(details.blue.wobbleRings2, local),
          half: isRemote,
          text: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_2_end_position'),
          red: getUltimateGoalWobbleString(details.red.wobbleRings2, local),
          blue: getUltimateGoalWobbleString(details.blue.wobbleRings2, local),
          half: isRemote,
          text: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.power_shots'),
          red: details.red.endPowerShotPoints ~/ 15,
          blue: details.blue.endPowerShotPoints != null ? details.blue.endPowerShotPoints ~/ 15 : 0,
          half: isRemote,
          points: 15),

      MatchBreakdownRow(
          name: local.get('breakdowns.penalty'),
          red: match.redPenalty,
          blue: match.bluePenalty,
          half: isRemote,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.minor_penalty'),
          red: isRemote ? details.redMinPen : details.blueMinPen,
          blue: isRemote ? details.blueMinPen : details.redMinPen,
          half: isRemote,
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.major_penalty'),
          red: isRemote ? details.redMajPen : details.blueMajPen,
          blue: isRemote ? details.blueMajPen : details.redMajPen,
          half: isRemote,
          points: 20),
    ];
  }

  static getUltimateGoalWobbleString(int key, TOALocalizations local) {
    switch (key) {
        case 1:
          return local.get('breakdowns.ultimategoal.start_line') + ' (+5)';
        case 2:
          return local.get('breakdowns.ultimategoal.drop_zone') + ' (+20)';
        default:
          return local.get('breakdowns.ultimategoal.not_scored');
      }
  }
}
