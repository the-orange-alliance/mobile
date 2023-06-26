import 'package:flutter/material.dart';
import 'package:toa_flutter/internationalization/localizations.dart';
import 'package:toa_flutter/models/match-details.dart';
import 'package:toa_flutter/models/match.dart';
import 'package:toa_flutter/providers/layouts.dart';
import 'package:toa_flutter/ui/widgets/match-breakdown-row.dart';

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

  static List<Widget> customBreakdownRow(MatchBreakdownLayoutElement e,
      MatchDetails details, TOALocalizations local) {
    final Map<String, dynamic> red = details.red;
    final Map<String, dynamic> blue = details.blue;

    switch (e.name) {
      case 'powerplay.auto_nav':
        final redNav = PowerPlayHelper.getAutoNav(local, red);
        final blueNav = PowerPlayHelper.getAutoNav(local, blue);
        return List.generate(
          2,
          (i) => MatchBreakdownRow(
            name: local.get('breakdowns.powerplay.robot_${i + 1}_navigated'),
            red: redNav[i],
            blue: blueNav[i],
            text: true,
          ),
        );
      case 'powerplay.junctions_owned_cone':
        return [
          MatchBreakdownRow(
            name: local.get('breakdowns.powerplay.junctions_owned_cone'),
            red: PowerPlayHelper.junctionsOwned(red),
            blue: PowerPlayHelper.junctionsOwned(blue),
            points: 3,
          )
        ];
      default:
        print('something didn\'t line up: ${e.name}');
        return [];
    }
  }
}
