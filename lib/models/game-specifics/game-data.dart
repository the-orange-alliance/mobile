import 'package:flutter/material.dart';
import 'package:toa_flutter/models/match.dart';
import 'package:toa_flutter/models/match-details.dart';
import 'package:toa_flutter/models/game-specifics/relicrecovery-match-details.dart';
import 'package:toa_flutter/models/game-specifics/roverruckus-match-details.dart';
import 'package:toa_flutter/models/game-specifics/skystone-match-details.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/ui/widgets/no-data-widget.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-1718.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-1819.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-1920.dart';

class GameData {

  static MatchDetails fromResponse(String seasonKey, String json) {
    if (json.toString() == 'null' || json.toString() == '[]') {
      return null;
    }
    switch (seasonKey) {
      case '1718':
        return RelicRecoveryMatchDetails.allFromResponse(json)?.elementAt(0) ?? null;
      case '1819':
        return RoverRuckusMatchDetails.allFromResponse(json)?.elementAt(0) ?? null;
      case '1920':
        return SkyStoneMatchDetails.allFromResponse(json)?.elementAt(0) ?? null;
      default:
        return null;
    }
  }
  
  static List<Widget> getBreakdown(Match match, BuildContext context) {
    List<Widget> noData = [NoDataWidget(MdiIcons.ballotOutline, 'No Breakdown found')];
    if (match.gameData == null) {
      return noData;
    }
    switch (match.getSessonKey()) {
      case '1718':
        return MatchBreakdown1718.getRows(match, context);
      case '1819':
        return MatchBreakdown1819.getRows(match, context);
      case '1920':
        return MatchBreakdown1920.getRows(match, context);
      default:
        return noData;
    }
  }
}