class UltimateGoalAllianceDetails {

  UltimateGoalAllianceDetails({
    this.dcTowerLow,
    this.dcTowerMid,
    this.dcTowerHigh,
    this. navigated1,
    this. navigated2,
    this.autoTowerLow,
    this.autoTowerMid,
    this.autoTowerHigh,
    this.autoTowerPoints,
    this. autoPowerShotLeft,
    this. autoPowerShotCenter,
    this. autoPowerShotRight,
    this.autoPowerShotPoints,
    this.autoWobblePoints,
    this.wobbleRings1,
    this.wobbleRings2,
    this.wobbleEnd1,
    this.wobbleEnd2,
    this. wobbleDelivered1,
    this. wobbleDelivered2,
    this.wobbleEndPoints,
    this.wobbleRingPoints,
    this. endPowerShotLeft,
    this. endPowerShotCenter,
    this. endPowerShotRight,
    this.endPowerShotPoints,
    this.navPts
  });

  int dcTowerLow;
  int dcTowerMid;
  int dcTowerHigh;
  bool navigated1;
  bool navigated2;
  int autoTowerLow;
  int autoTowerMid;
  int autoTowerHigh;
  int autoTowerPoints;
  bool autoPowerShotLeft;
  bool autoPowerShotCenter;
  bool autoPowerShotRight;
  int autoPowerShotPoints;
  int autoWobblePoints;
  int wobbleRings1;
  int wobbleRings2;
  int wobbleEnd1;
  int wobbleEnd2;
  bool wobbleDelivered1;
  bool wobbleDelivered2;
  int wobbleEndPoints;
  int wobbleRingPoints;
  bool endPowerShotLeft;
  bool endPowerShotCenter;
  bool endPowerShotRight;
  int endPowerShotPoints;
  int navPts;


  static UltimateGoalAllianceDetails fromMap(Map map) {
    return UltimateGoalAllianceDetails(
      dcTowerLow: map['tele_tower_low'],
      dcTowerMid: map['tele_tower_mid'],
      dcTowerHigh: map['tele_tower_high'],
      navigated1: map['auto_navigated_1'],
      navigated2: map['auto_navigated_2'],
      autoTowerLow: map['auto_tower_low'],
      autoTowerMid: map['auto_tower_mid'],
      autoTowerHigh: map['auto_tower_high'],
      autoTowerPoints: map['auto_tower_points'],
      autoPowerShotLeft: map['auto_power_shot_left'],
      autoPowerShotCenter: map['auto_power_shot_center'],
      autoPowerShotRight: map['auto_power_shot_right'],
      autoPowerShotPoints: map['auto_power_shot_points'],
      autoWobblePoints: map['auto_wobble_points'],
      wobbleRings1: map['end_wobble_rings_1'],
      wobbleRings2: map['end_wobble_rings_2'],
      wobbleEnd1: map['end_wobble_1'],
      wobbleEnd2: map['end_wobble_2'],
      wobbleDelivered1: map['auto_wobble_delivered_1'],
      wobbleDelivered2: map['auto_wobble_delivered_2'],
      wobbleEndPoints: map['end_wobble_points'],
      wobbleRingPoints: map['end_wobble_ring_points'],
      endPowerShotLeft: map['end_power_shot_left'],
      endPowerShotCenter: map['end_power_shot_center'],
      endPowerShotRight: map['end_power_shot_right'],
      endPowerShotPoints: map['end_power_shot_points'],
    );
  }
}
