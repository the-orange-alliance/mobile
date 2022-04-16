import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:toa_flutter/models/game-specifics/freight-frenzy-match-details.dart';
import 'package:toa_flutter/models/game-specifics/relicrecovery-match-details.dart';
import 'package:toa_flutter/models/game-specifics/roverruckus-match-details.dart';
import 'package:toa_flutter/models/game-specifics/skystone-match-details.dart';
import 'package:toa_flutter/models/game-specifics/ultimategoal-match-details.dart';
import 'package:toa_flutter/models/match.dart';
import 'package:toa_flutter/models/match-details.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-2122.dart';
import 'package:toa_flutter/ui/views/match/years/remote-match-breakdown-2122.dart';
import 'package:toa_flutter/ui/widgets/no-data-widget.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-1718.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-1819.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-1920.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-2021.dart';
import 'package:toa_flutter/ui/views/match/years/remote-match-breakdown-2021.dart';

class GameData {
  static MatchDetails fromResponse(String seasonKey, String json) {
    if (json.toString() == 'null' || json.toString() == '[]') {
      return null;
    }
    try {
      switch (seasonKey) {
        case '1718':
          return RelicRecoveryMatchDetails.allFromResponse(json)
                  ?.elementAt(0) ??
              null;
        case '1819':
          return RoverRuckusMatchDetails.allFromResponse(json)?.elementAt(0) ??
              null;
        case '1920':
          return SkyStoneMatchDetails.allFromResponse(json)?.elementAt(0) ??
              null;
        case '2021':
          return UltimateGoalMatchDetails.allFromResponse(json)?.elementAt(0) ??
              null;
        case '2122':
          return FreightFrenzyMatchDetails.allFromResponse(json)
                  ?.elementAt(0) ??
              null;
        default:
          return null;
      }
    } catch (err) {
      return null;
    }
  }

  static List<Widget> getBreakdown(
      Match match, BuildContext context, bool isRemote) {
    List<Widget> noData = [
      NoDataWidget(MdiIcons.ballotOutline, 'Match Breakdown Unavailable')
    ];
    if (match.gameData == null) {
      return noData;
    }
    switch (match.getSeasonKey()) {
      case '1718':
        return MatchBreakdown1718.getRows(match, context);
      case '1819':
        return MatchBreakdown1819.getRows(match, context);
      case '1920':
        return MatchBreakdown1920.getRows(match, context);
      case '2021':
        return isRemote
            ? RemoteMatchBreakdown2021.getRows(match, context)
            : MatchBreakdown2021.getRows(match,
                context); // remote events were only introduced in 2020/2021
      case '2122':
        return isRemote
            ? noData
            : MatchBreakdown2122.getRows(match,
                context); // the 2122 remote match data has some anomalies
      default:
        return noData;
    }
  }
}
