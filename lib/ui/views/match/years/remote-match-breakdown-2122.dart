import 'package:flutter/material.dart';
import 'package:toa_flutter/internationalization/localizations.dart';
import 'package:toa_flutter/models/game-specifics/freight-frenzy-match-details.dart';
import 'package:toa_flutter/models/match.dart';
import 'package:toa_flutter/ui/widgets/remote-match-breakdown-row.dart';

class RemoteMatchBreakdown2122 {
  static List<Widget> getRows(Match match, BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    FreightFrenzyMatchDetails details = match.gameData;
    return [
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.autonomous'),
        team: match.redAutoScore,
        title: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.teleop'),
        team: match.redAutoScore,
        title: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.end'),
        team: match.redEndScore,
        title: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.penalty'),
        team: match.redPenalty,
        title: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.minor_penalty'),
        team: details.redMinPen,
        points: -5,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.major_penalty'),
        team: details.redMajPen,
        points: -20,
      ),
    ];
  }
}
