import 'dart:convert';
import 'package:toa_flutter/models/match-participant.dart';
import 'package:toa_flutter/models/match-details.dart';

class Match {
  Match({
    required this.matchKey,
    required this.eventKey,
    required this.tournamentLevel,
    required this.scheduledTime,
    this.matchName,
    this.playNumber,
    this.fieldNumber,
    this.prestartTime,
    this.prestartCount,
    this.cycleTime,
    this.redScore,
    this.blueScore,
    this.redPenalty,
    this.bluePenalty,
    this.redAutoScore,
    this.blueAutoScore,
    this.redTeleScore,
    this.blueTeleScore,
    this.redEndScore,
    this.blueEndScore,
    this.videoURL,
    this.participants
  });

  String matchKey;
  String eventKey;
  int tournamentLevel;
  String? scheduledTime;
  String? matchName;
  int? playNumber;
  int? fieldNumber;
  int? prestartTime;
  int? prestartCount;
  String? cycleTime;
  int? redScore;
  int? blueScore;
  int? redPenalty;
  int? bluePenalty;
  int? redAutoScore;
  int? blueAutoScore;
  int? redTeleScore;
  int? blueTeleScore;
  int? redEndScore;
  int? blueEndScore;
  String? videoURL;
  List<MatchParticipant>? participants;
  MatchDetails? gameData;

  static List<Match> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => Match.fromMap(obj))
        .toList()
        .cast<Match>();
  }

  static Match fromMap(Map map) {
    return Match(
      matchKey: map['match_key'],
      eventKey: map['event_key'],
      tournamentLevel: map['tournament_level'],
      scheduledTime: map['scheduled_time'],
      matchName: map['match_name'],
      playNumber: map['play_number'],
      fieldNumber: map['field_number'] is int ? map['field_number'] : int.parse(map['field_number']),
      prestartTime: map['prestart_time'],
      prestartCount: map['prestart_count'],
      cycleTime: map['cycle_time'],
      redScore: map['red_score'],
      blueScore: map['blue_score'],
      redPenalty: map['red_penalty'],
      bluePenalty: map['blue_penalty'],
      redAutoScore: map['red_auto_score'],
      blueAutoScore: map['blue_auto_score'],
      redTeleScore: map['red_tele_score'],
      blueTeleScore: map['blue_tele_score'],
      redEndScore: map['red_end_score'],
      blueEndScore: map['blue_end_score'],
      videoURL: map['video_url'],
      participants: map.containsKey('participants') ? MatchParticipant.allFromResponse(json.encode(map['participants'])) : []
    );
  }

  String getSeasonKey() {
    return matchKey.split('-')[0];
  }
}

class MatchType {
/*
    0  - Practice Match
    1  - Qualification Match
    21 - Quarterfinals Series 1
    22 - Quarterfinals Series 2
    23 - Quarterfinals Series 3
    24 - Quarterfinals Series 4
    31 - Semis Series 1 Match
    32 - Semis Series 2 Match
    4  - Finals Match
*/

  static int PRACTICE_MATCH = 0;
  static int QUALS_MATCH = 1;
  static int QUARTERS_MATCH_1 = 21;
  static int QUARTERS_MATCH_2 = 22;
  static int QUARTERS_MATCH_3 = 23;
  static int QUARTERS_MATCH_4 = 24;
  static int SEMIS_MATCH_1 = 31;
  static int SEMIS_MATCH_2 = 32;
  static int FINALS_MATCH = 4;
}