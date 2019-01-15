import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/game-specifics/RoverRuckusMatchDetails.dart';
import 'package:toa_flutter/ui/widgets/MatchBreakdownRow.dart';

class MatchBreakdown1819 {

  static List<Widget> getRows(Match match) {
    RoverRuckusMatchDetails details = match.gameData;
    return <Widget>[
      MatchBreakdownRow(name: 'Autonomous', red: match.redAutoScore, blue: match.blueAutoScore, title: true),
      MatchBreakdownRow(name: 'Landing', red: details.redAutoLand, blue: details.blueAutoLand, points: 30),
      MatchBreakdownRow(name: 'Sampling', red: details.redAutoSamp, blue: details.blueAutoSamp, points: 25),
      MatchBreakdownRow(name: 'Claiming', red: details.redAutoClaim, blue: details.blueAutoClaim, points: 15),
      MatchBreakdownRow(name: 'Parking', red: details.redAutoPark, blue: details.blueAutoPark, points: 10),

      MatchBreakdownRow(name: 'TeleOp', red: match.redTeleScore, blue: match.blueTeleScore, title: true),
      MatchBreakdownRow(name: 'Gold Mineral', red: details.redDriverGold, blue: details.blueDriverGold, points: 5),
      MatchBreakdownRow(name: 'Silver Mineral', red: details.redDriverSilver, blue: details.blueDriverSilver, points: 5),
      MatchBreakdownRow(name: 'Any Mineral in Depot', red: details.redDriverDepot, blue: details.blueDriverDepot, points: 2),

      MatchBreakdownRow(name: 'End Game', red: match.redEndScore, blue: match.blueEndScore, title: true),
      MatchBreakdownRow(name: 'Robots Latched', red: details.redEndLatch, blue: details.blueEndLatch, points: 50),
      MatchBreakdownRow(name: 'Robots Parked In Crater', red: details.redEndIn, blue: details.blueEndIn, points: 15),
      MatchBreakdownRow(name: 'Robots Parked Completely In Crater', red: details.redEndComp, blue: details.blueEndComp, points: 25),

      MatchBreakdownRow(name: 'Penalty', red: match.bluePenalty, blue: match.redPenalty, title: true),
      MatchBreakdownRow(name: 'Minor Penalty', red: details.blueMinPen, blue: details.redMinPen, points: 10),
      MatchBreakdownRow(name: 'Major Penalty', red: details.blueMajPen, blue: details.redMajPen, points: 40),
    ];
  }
}