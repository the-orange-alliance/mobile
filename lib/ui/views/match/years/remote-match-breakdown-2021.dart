import 'package:flutter/material.dart';

import '../../../../internationalization/localizations.dart';
import '../../../../models/match.dart';
import '../../../widgets/remote-match-breakdown-row.dart';
import 'package:toa_flutter/models/game-specifics/ultimategoal-match-details.dart';

class RemoteMatchBreakdown2021 {
  static List<Widget> getRows(
      Match match, BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    UltimateGoalMatchDetails details = match.gameData;
    return <Widget>[
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.autonomous'),
          team: match.redAutoScore,
          title: true),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_high'),
          team: details.red.autoTowerHigh,
          points: 12),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_middle'),
          team: details.red.autoTowerMid,
          points: 6),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_low'),
          team: details.red.autoTowerLow,
          points: 3),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.power_shots'),
          team: details.red.autoPowerShotPoints != null
              ? details.red.autoPowerShotPoints ~/ 15
              : 0,
          points: 15),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_1_delivered'),
          team: details.red.wobbleDelivered1,
          points: 15),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_2_delivered'),
          team: details.red.wobbleDelivered2,
          points: 15),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.robot_1_navigated'),
          team: details.red.navigated1,
          points: 5),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.teleop'),
          team: match.redTeleScore,
          title: true),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_high'),
          team: details.red.dcTowerHigh,
          points: 6),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_middle'),
          team: details.red.dcTowerMid,
          points: 4),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.rings_low'),
          team: details.red.dcTowerLow,
          points: 2),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.end'),
          team: match.redEndScore,
          title: true),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_1_rings'),
          team: details.red.wobbleRings1,
          points: 5),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_2_rings'),
          team: details.red.wobbleRings2,
          points: 5),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_1_end_position'),
          team: getUltimateGoalWobbleString(details.red.wobbleEnd1, local),
          text: true),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.wobble_goal_2_end_position'),
          team: getUltimateGoalWobbleString(details.red.wobbleEnd2, local),
          text: true),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.ultimategoal.power_shots'),
          team: details.red.endPowerShotPoints != null
              ? details.red.endPowerShotPoints ~/ 15
              : 0,
          points: 15),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.penalty'),
          team: match.redPenalty,
          title: true),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.minor_penalty'),
          team: details.redMinPen,
          points: 5),
      RemoteMatchBreakdownRow(
          name: local.get('breakdowns.major_penalty'),
          team: details.redMajPen,
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
