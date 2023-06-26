import 'package:toa_flutter/internationalization/localizations.dart';
import 'package:toa_flutter/models/match.dart';

abstract class PowerPlayHelper {
  static List<int> getPenaltyPoints(Match m) {
    return [
      m.gameData.blue['penalty_points_comitted'],
      m.gameData.red['penalty_points_comitted']
    ];
  }

  static List<String> getAutoNav(
      TOALocalizations local, Map<String, dynamic> alliance) {
    List<String> navs = [];
    for (int i = 1; i < 3; i++) {
      String l = alliance['auto_robot_${i}'];

      if (alliance['init_signal_sleeve_${i}'] && l == 'SIGNAL_ZONE') {
        l = 'CUSTOM_SIGNAL_ZONE';
      }

      navs.add(local.get('breakdowns.powerplay.${l.toLowerCase()}'));
    }
    return navs;
  }

  static int junctionsOwned(Map<String, dynamic> alliance) {
    return alliance['owned_junctions'] - alliance['beacons'];
  }
}
