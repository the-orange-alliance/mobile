import 'package:flutter/material.dart';
import 'package:toa_flutter/internationalization/localizations.dart';
import 'package:toa_flutter/models/game-specifics/2122-helper.dart';
import 'package:toa_flutter/models/game-specifics/2223-helper.dart';
import 'package:toa_flutter/models/match-details.dart';
import 'package:toa_flutter/models/match.dart';
import 'package:toa_flutter/providers/layouts.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-1718.dart';
import 'package:toa_flutter/ui/views/match/years/match-breakdown-1819.dart';
import 'package:toa_flutter/ui/widgets/match-breakdown-row.dart';

class MatchBreakdownBuilder {
  static List<Widget> getRows(Match match, BuildContext context) {
    TOALocalizations? local = TOALocalizations.of(context);
    MatchDetails? details = match.gameData;
    final season = match.getSeasonKey();

    // skip pre-match detail seasons
    if (season == '1718') {
      return MatchBreakdown1718.getRows(match, context);
    } else if (season == '1819') {
      return MatchBreakdown1819.getRows(match, context);
    }

    Map<String, dynamic>? red = details!.red;
    Map<String, dynamic>? blue = details.blue;

    List<Widget> rows = [];

    /**
     * SCHEMA:
     * name: string; contains the i18n value of the row.

     * type: 'title' | 'text' | 'points' | 'custom'

     * value: string; where the data is received from; 
     *            titles and match (gameData) are resolved via _getalliancevalue
     *            alliance_details - gameData.red or blue
     */

    for (MatchBreakdownLayoutElement e
        in MatchBreakdownLayouts.getSeason(season)!) {
      switch (e.type) {
        case 'title':
          final name = local!.get(e.name!);
          final scores = _getAllianceValue(e.value, match, season);

          rows.add(MatchBreakdownRow(
            name: name,
            red: scores[0],
            blue: scores[1],
            title: true,
          ));
          break;

        case 'text':
          final name = local!.get(e.name!);
          final value = e.value!.split('.')[1];

          if (!red!.containsKey(value)) break;

          if (red[value] is bool) {
            rows.add(MatchBreakdownRow(
              name: name,
              red: red[value],
              blue: blue![value],
              text: true,
            ));
          } else {
            final localeStart = e.name!.substring(0, e.name!.lastIndexOf('.'));
            rows.add(MatchBreakdownRow(
              name: name,
              red: local
                  .get('${localeStart}.${red[value].toString().toLowerCase()}'),
              blue: local.get(
                  '${localeStart}.${blue![value].toString().toLowerCase()}'),
              text: true,
            ));
          }
          break;

        case 'points':
          final name = local!.get(e.name!);
          final type = e.value!.split('.')[0];
          final value = e.value!.split('.')[1];
          var outval = [];

          if (type == 'match') {
            outval = _getAllianceValue(value, match, season);
            // penalties can add to opponents
            if (e.points! > 0) outval = outval.reversed.toList();
          } else if (value.contains("::")) {
            // refer to something in a list
            final v2 = value.split('::');
            outval = [
              red![v2[0]][int.parse(v2[1])],
              blue![v2[0]][int.parse(v2[1])]
            ];
          } else {
            outval = [red![value], blue![value]];
          }

          rows.add(MatchBreakdownRow(
            name: name,
            red: outval[0],
            blue: outval[1],
            points: e.points,
          ));
          break;

        case 'custom':
          switch (season) {
            case '2223':
              rows.addAll(
                  PowerPlayHelper.customBreakdownRow(e, details, local));
          }
      }
    }

    return rows;
  }

  static List<int?> _getAllianceValue(String? val, Match m, String season) {
    switch (val) {
      case 'auto_score':
        return [m.redAutoScore, m.blueAutoScore];
      case 'total_score':
        return [m.redScore, m.blueScore];
      case 'end_score':
        return [m.redEndScore, m.blueEndScore];
      case 'penalty':
        switch (season) {
          case '2122':
            return FreightFrenzyHelper.getPenaltyPoints(m);
          case '2223':
            return PowerPlayHelper.getPenaltyPoints(m);
          default:
            throw Error();
        }
      case 'minor_penalty':
        return [m.gameData!.redMinPen, m.gameData!.blueMinPen];
      case 'major_penalty':
        return [m.gameData!.redMajPen, m.gameData!.blueMajPen];
      default:
        throw Error();
    }
  }
}
