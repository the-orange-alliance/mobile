import 'package:flutter/material.dart';

import '../../../../internationalization/localizations.dart';
import '../../../../models/match.dart';
import '../../../../models/game-specifics/roverruckus-match-details.dart';
import '../../../widgets/match-breakdown-row.dart';

class MatchBreakdown1819 {
  static List<Widget> getRows(Match match, BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    RoverRuckusMatchDetails details = match.gameData;
    return <Widget>[
      MatchBreakdownRow(
          name: local.get('breakdowns.autonomous'),
          red: match.redAutoScore,
          blue: match.blueAutoScore,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.landing'),
          red: details.redAutoLand,
          blue: details.blueAutoLand,
          points: 30),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.sampling'),
          red: details.redAutoSamp,
          blue: details.blueAutoSamp,
          points: 25),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.claiming'),
          red: details.redAutoClaim,
          blue: details.blueAutoClaim,
          points: 15),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.parking'),
          red: details.redAutoPark,
          blue: details.blueAutoPark,
          points: 10),
      MatchBreakdownRow(
          name: local.get('breakdowns.teleop'),
          red: match.redTeleScore,
          blue: match.blueTeleScore,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.gold'),
          red: details.redDriverGold,
          blue: details.blueDriverGold,
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.silver'),
          red: details.redDriverSilver,
          blue: details.blueDriverSilver,
          points: 5),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.depot'),
          red: details.redDriverDepot,
          blue: details.blueDriverDepot,
          points: 2),
      MatchBreakdownRow(
          name: local.get('breakdowns.end'),
          red: match.redEndScore,
          blue: match.blueEndScore,
          title: true),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.robots_latched'),
          red: details.redEndLatch,
          blue: details.blueEndLatch,
          points: 50),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.parked_in'),
          red: details.redEndIn,
          blue: details.blueEndIn,
          points: 15),
      MatchBreakdownRow(
          name: local.get('breakdowns.roverruckus.parked_completely'),
          red: details.redEndComp,
          blue: details.blueEndComp,
          points: 25),
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
}
