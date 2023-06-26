import 'dart:convert';
import 'package:toa_flutter/models/award.dart';
import 'package:toa_flutter/models/team.dart';

class AwardRecipient {
  AwardRecipient({
    this.awardsKey,
    this.eventKey,
    this.awardKey,
    this.teamKey,
    this.receiverName,
    this.awardName,
    this.award,
    this.team
  });

  final String awardsKey;
  final String eventKey;
  final String awardKey;
  final String teamKey;
  final String receiverName;
  final String awardName;
  final Award award; // unused?
  final Team team;

  static List<AwardRecipient> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => AwardRecipient.fromMap(obj))
        .toList()
        .cast<AwardRecipient>();
  }

  static AwardRecipient fromMap(Map map) {
    return AwardRecipient(
      awardsKey: map['awards_key'],
      eventKey: map['event_key'],
      awardKey: map['award_key'],
      teamKey: map['team_key'],
      receiverName: map['receiver_name'],
      awardName: map['award_name'],
      // award: Award.fromMap(map['award']),
      team: Team.fromMap(map['team'])
    );
  }
}