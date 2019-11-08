class SkyStoneAllianceDetails {

  SkyStoneAllianceDetails({
    this.autoStone1,
    this.autoStone2,
    this.autoStone3,
    this.autoStone4,
    this.autoStone5,
    this.autoStone6,
    this.autoDeliveredSkystones,
    this.autoDeliveredStones,
    this.autoReturned,
    this.firstReturnedIsSkystone,
    this.autoPlaced,
    this.foundationRepositioned,
    this.teleDelivered,
    this.teleReturned,
    this.telePlaced,
    this.foundationMoved,
    this.autoTransportPoints,
    this.autoPlacedPoints,
    this.repositionPoints,
    this.navPoints,
    this.teleTransportPoints,
    this.telePlacedPoints,
    this.towerBonus,
    this.towerCappingBonus,
    this.towerLevelBonus,
    this.endRobotsParked,
    this.autoPoints,
    this.autoTotal,
    this.teleTotal,
    this.endTotal,
    this.penaltyTotal,

    this.robot1Nav,
    this.robot1Parked,
    this.robot1CapLevel,
    this.robot2Nav,
    this.robot2Parked,
    this.robot2CapLevel
  });

  String autoStone1;
  String autoStone2;
  String autoStone3;
  String autoStone4;
  String autoStone5;
  String autoStone6;
  int autoDeliveredSkystones;
  int autoDeliveredStones;
  int autoReturned;
  bool firstReturnedIsSkystone;
  int autoPlaced;
  bool foundationRepositioned;
  int teleDelivered;
  int teleReturned;
  int telePlaced;
  bool foundationMoved;
  int autoTransportPoints;
  int autoPlacedPoints;
  int repositionPoints;
  int navPoints;
  int teleTransportPoints;
  int telePlacedPoints;
  int towerBonus;
  int towerCappingBonus;
  int towerLevelBonus;
  int endRobotsParked;
  int autoPoints;
  int autoTotal;
  int teleTotal;
  int endTotal;
  int penaltyTotal;

  bool robot1Nav;
  bool robot1Parked;
  int robot1CapLevel;
  bool robot2Nav;
  bool robot2Parked;
  int robot2CapLevel;

  static SkyStoneAllianceDetails fromMap(Map map) {
    return SkyStoneAllianceDetails(
      autoStone1: map['auto_stone_1'],
      autoStone2: map['auto_stone_2'],
      autoStone3: map['auto_stone_3'],
      autoStone4: map['auto_stone_4'],
      autoStone5: map['auto_stone_5'],
      autoStone6: map['auto_stone_6'],
      autoDeliveredSkystones: map['auto_delivered_skystones'],
      autoDeliveredStones: map['auto_delivered_stones'],
      autoReturned: map['auto_returned'],
      firstReturnedIsSkystone: map['first_returned_is_skystone'],
      autoPlaced: map['auto_placed'],
      foundationRepositioned: map['foundation_repositioned'],
      teleDelivered: map['tele_delivered'],
      teleReturned: map['tele_returned'],
      telePlaced: map['tele_placed'],
      foundationMoved: map['foundation_moved'],
      autoTransportPoints: map['auto_transport_points'],
      autoPlacedPoints: map['auto_placed_points'],
      repositionPoints: map['reposition_points'],
      navPoints: map['nav_points'],
      teleTransportPoints: map['tele_transport_points'],
      telePlacedPoints: map['tele_placed_points'],
      towerBonus: map['tower_bonus'],
      towerCappingBonus: map['tower_capping_bonus'],
      towerLevelBonus: map['tower_level_bonus'],
      endRobotsParked: map['end_robots_parked'],
      autoPoints: map['auto_points'],
      autoTotal: map['auto_total'],
      teleTotal: map['tele_total'],
      endTotal: map['end_total'],
      penaltyTotal: map['penalty_total'],

      robot1Nav: map['robot_1']['nav'],
      robot1Parked: map['robot_1']['parked'],
      robot1CapLevel: map['robot_1']['cap_level'],
      robot2Nav: map['robot_2']['nav'],
      robot2Parked: map['robot_2']['parked'],
      robot2CapLevel: map['robot_2']['cap_level']
    );
  }
}
