import 'package:toa_flutter/models/match.dart';

abstract class FreightFrenzyHelper {
  static List<int> getPenaltyPoints(Match m) {
    return [
      m.gameData.redMajPen * -20 + m.gameData.redMinPen * -5,
      m.gameData.blueMajPen * -20 + m.gameData.blueMinPen * -5,
    ];
  }
}
