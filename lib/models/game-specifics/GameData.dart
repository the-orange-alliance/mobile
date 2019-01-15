import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/MatchDetails.dart';
import 'package:toa_flutter/models/game-specifics/RelicRecoveryMatchDetails.dart';
import 'package:toa_flutter/models/game-specifics/RoverRuckusMatchDetails.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/ui/widgets/NoDataWidget.dart';
import 'package:toa_flutter/ui/views/match/years/MatchBreakdown1718.dart';
import 'package:toa_flutter/ui/views/match/years/MatchBreakdown1819.dart';

class GameData {

  static MatchDetails fromResponse(String seasonKey, String json) {
    switch (seasonKey) {
      case '1718':
        return RelicRecoveryMatchDetails.allFromResponse(json)[0];
      case '1819':
        return RoverRuckusMatchDetails.allFromResponse(json)[0];
      default:
        return MatchDetails();
    }
  }
  
  static List<Widget> getBreakdown(Match match) {
    List<Widget> noData = [NoDataWidget(MdiIcons.ballotOutline, 'No Breakdown found')];
    if (match.gameData == null) {
      return noData;
    }
    switch (match.getSessonKey()) {
      case '1718':
        return MatchBreakdown1718.getRows(match);
      case '1819':
        return MatchBreakdown1819.getRows(match);
      default:
        return noData;
    }
  }
}