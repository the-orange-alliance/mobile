import 'package:flutter/material.dart';
import 'package:toa_flutter/internationalization/localizations.dart';
import 'package:toa_flutter/models/game-specifics/freight-frenzy-alliance-details.dart';
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
        name: local.get('breakdowns.freightfrenzy.robot_1_navigated'),
        team: navLocationToString(details.red.navigated1, local),
        text: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_2_navigated'),
        team: navLocationToString(details.red.navigated2, local),
        text: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.delivered_duck'),
        team: details.red.carousel,
        points: 10,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.storage_unit_freight'),
        team: details.red.autoStorageFreight,
        points: 2,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_1_freight'),
        team: details.red.autoFreight1,
        points: 6,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_2_freight'),
        team: details.red.autoFreight2,
        points: 6,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_3_freight'),
        team: details.red.autoFreight3,
        points: 6,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.barcode_element_1'),
        team: barcodeElementToString(details.red.barcodeElement1, local),
        text: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.barcode_element_2'),
        team: barcodeElementToString(details.red.barcodeElement2, local),
        text: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_1_bonus'),
        team: details.red.autoBonus1,
        points: 20,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_2_bonus'),
        team: details.red.autoBonus2,
        points: 20,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.teleop'),
        team: match.redAutoScore,
        title: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.storage_unit_freight'),
        team: details.red.teleStorageFreight,
        points: 1,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_1_freight'),
        team: details.red.teleFreight1,
        points: 2,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_2_freight'),
        team: details.red.teleFreight2,
        points: 4,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.level_3_freight'),
        team: details.red.teleFreight3,
        points: 6,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.shared_hub_freight'),
        team: details.red.sharedFreight,
        points: 4,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.end'),
        team: match.redEndScore,
        title: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.element_delivered'),
        team: details.red.endDelivered,
        points: 6,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.alliance_hub_balanced'),
        team: details.red.allianceBalanced,
        points: 10,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.shared_hub_unbalanced'),
        team: details.red.sharedUnbalanced,
        points: 20,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_1_parked'),
        team: navLocationToString(details.red.endParked1, local),
        text: true,
      ),
      RemoteMatchBreakdownRow(
        name: local.get('breakdowns.freightfrenzy.robot_2_parked'),
        team: navLocationToString(details.red.endParked2, local),
        text: true,
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
