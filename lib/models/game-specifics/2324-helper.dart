import 'package:flutter/material.dart';
import 'package:toa_flutter/internationalization/localizations.dart';
import 'package:toa_flutter/models/match-details.dart';
import 'package:toa_flutter/providers/layouts.dart';
import 'package:toa_flutter/ui/widgets/match-breakdown-row.dart';

abstract class CenterStageHelper {
  /**
   * purple pixel on spike mark tape = 10
   * purple pixel on tape w/ team element = 20
   * yellow pixel w/ marked tape  = 10
   * yellow pixel w/ team element = 20
   */
  static List<String> getBonus(
      Map<String, dynamic> alliance, String name, TOALocalizations local) {
    List<String> l = [];
    String type;

    if (name == 'centerstage.purple_bonus') {
      type = 'spike_mark_pixel';
    } else {
      type = 'target_backdrop_pixel';
    }

    for (int i = 1; i < 3; i++) {
      if (alliance['init_team_prop_${i}'] && alliance['${type}_${i}']) {
        l.add('${local.get('breakdowns.centerstage.with_team_prop')} (+20)');
      } else if (alliance['${type}_${i}']) {
        l.add('${local.get('breakdowns.centerstage.without_team_prop')} (+10)');
      } else {
        l.add(local.get('breakdowns.centerstage.none'));
      }
    }

    return l;
  }

  static String getZoneText(int zone, TOALocalizations local) {
    if (zone == 0) return local.get("breakdowns.centerstage.none");

    return "${local.get("breakdowns.centerstage.zone_${zone}")} (+${(4 - zone) * 10})";
  }

  static List<String> getEndNav(
      TOALocalizations local, Map<String, dynamic> alliance) {
    List<String> navs = [];
    for (int i = 1; i < 3; i++) {
      String? l = alliance['end_robot_${i}'];
      String nav = local.get('breakdowns.centerstage.${l!.toLowerCase()}');

      if (l != 'NONE') {
        nav += ' (+${l == 'RIGGING' ? 20 : 5})';
      }

      navs.add(nav);
    }
    return navs;
  }

  static List<Widget> customBreakdownRow(MatchBreakdownLayoutElement e,
      MatchDetails details, TOALocalizations? local) {
    final Map<String, dynamic>? red = details.red;
    final Map<String, dynamic>? blue = details.blue;

    switch (e.name) {
      case 'centerstage.purple_bonus':
      case 'centerstage.yellow_bonus':
        final redbonus = getBonus(red!, e.name!, local!);
        final bluebonus = getBonus(blue!, e.name!, local);
        return [
          MatchBreakdownRow(
            name: local.get('breakdowns.${e.name}_1'),
            blue: bluebonus[0],
            red: redbonus[0],
            text: true,
          ),
          MatchBreakdownRow(
            name: local.get('breakdowns.${e.name}_2'),
            blue: bluebonus[1],
            red: redbonus[1],
            text: true,
          )
        ];
      case 'centerstage.drone_1':
      case 'centerstage.drone_2':
        final drone = e.name!.split(".").last;
        return [
          MatchBreakdownRow(
            name: local!.get('breakdowns.${e.name}'),
            blue: getZoneText(blue![drone], local),
            red: getZoneText(red![drone], local),
            text: true,
          )
        ];
      case 'centerstage.end_nav':
        final redend = getEndNav(local!, red!);
        final blueend = getEndNav(local, blue!);
        return [
          MatchBreakdownRow(
            name: local.get('breakdowns.${e.name}_1'),
            blue: blueend[0],
            red: redend[0],
            text: true,
          ),
          MatchBreakdownRow(
            name: local.get('breakdowns.${e.name}_2'),
            blue: blueend[1],
            red: redend[1],
            text: true,
          )
        ];
      default:
        print('something didn\'t line up: ${e.name}');
        return [];
    }
  }
}
