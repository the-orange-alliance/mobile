import 'package:flutter/material.dart';
import 'package:toa_flutter/internationalization/localizations.dart';
import 'package:toa_flutter/models/game-specifics/freight-frenzy-alliance-details.dart';
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
        name: local.get('breakdowns.freightfrenzy.robot_1_navigated'),
        red: navLocationToString(details.red.navigated1, local),
        blue: navLocationToString(details.blue.navigated1, local),
        text: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_2_navigated'),
        red: navLocationToString(details.red.navigated2, local),
        blue: navLocationToString(details.blue.navigated2, local),
        text: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.delivered_duck'),
        red: details.red.carousel,
        blue: details.blue.carousel,
        points: 10,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.storage_unit_freight'),
        red: details.red.autoStorageFreight,
        blue: details.blue.autoStorageFreight,
        points: 2,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_1_freight'),
        red: details.red.autoFreight1,
        blue: details.blue.autoFreight1,
        points: 6,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_2_freight'),
        red: details.red.autoFreight2,
        blue: details.blue.autoFreight2,
        points: 6,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_3_freight'),
        red: details.red.autoFreight3,
        blue: details.blue.autoFreight3,
        points: 6,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.barcode_element_1'),
        red: barcodeElementToString(details.red.barcodeElement1, local),
        blue: barcodeElementToString(details.blue.barcodeElement1, local),
        text: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.barcode_element_2'),
        red: barcodeElementToString(details.red.barcodeElement2, local),
        blue: barcodeElementToString(details.blue.barcodeElement2, local),
        text: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_1_bonus'),
        red: details.red.autoBonus1,
        blue: details.blue.autoBonus1,
        points: 20,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_2_bonus'),
        red: details.red.autoBonus2,
        blue: details.blue.autoBonus2,
        points: 20,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.teleop'),
        red: match.redScore,
        blue: match.blueScore,
        title: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.storage_unit_freight'),
        red: details.red.teleStorageFreight,
        blue: details.blue.teleStorageFreight,
        points: 1,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_1_freight'),
        red: details.red.teleFreight1,
        blue: details.blue.teleFreight1,
        points: 2,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_2_freight'),
        red: details.red.teleFreight2,
        blue: details.blue.teleFreight2,
        points: 4,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_3_freight'),
        red: details.red.teleFreight3,
        blue: details.blue.teleFreight3,
        points: 6,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.shared_hub_freight'),
        red: details.red.sharedFreight,
        blue: details.blue.sharedFreight,
        points: 4,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.end'),
        red: match.redEndScore,
        blue: match.blueEndScore,
        title: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.element_delivered'),
        red: details.red.endDelivered,
        blue: details.blue.endDelivered,
        points: 6,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.alliance_hub_balanced'),
        red: details.red.allianceBalanced,
        blue: details.blue.allianceBalanced,
        points: 10,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.shared_hub_unbalanced'),
        red: details.red.sharedUnbalanced,
        blue: details.blue.sharedUnbalanced,
        points: 20,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_1_parked'),
        red: navLocationToString(details.red.endParked1, local),
        blue: navLocationToString(details.blue.endParked1, local),
        text: true,
      ),
      MatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_2_parked'),
        red: navLocationToString(details.red.endParked2, local),
        blue: navLocationToString(details.blue.endParked2, local),
        text: true,
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
