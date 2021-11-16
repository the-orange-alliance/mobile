import 'package:flutter/material.dart';
import 'package:toa_flutter/internationalization/localizations.dart';
import 'package:toa_flutter/models/game-specifics/freight-frenzy-match-details.dart';
import 'package:toa_flutter/models/match.dart';
import 'package:toa_flutter/ui/widgets/match-breakdown-row.dart';

class MatchBreakdown2122 {
  static List<Widget> getRows(Match match, BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    FreightFrenzyMatchDetails details = match.gameData;
    return [
      MatchBreakdownRow(
        name: local.get('breakdowns.autonomous'),
        red: match.redAutoScore,
        blue: match.blueAutoScore,
        title: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.teleop'),
        red: match.redAutoScore,
        blue: match.blueAutoScore,
        title: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.end'),
        red: match.redEndScore,
        blue: match.blueEndScore,
        title: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.penalty'),
        red: match.redPenalty,
        blue: match.bluePenalty,
        title: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.minor_penalty'),
        red: details.redMinPen,
        blue: details.blueMinPen,
        points: -5,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.major_penalty'),
        red: details.redMajPen,
        blue: details.blueMajPen,
        points: -20,
      ),
    ];
  }
}
