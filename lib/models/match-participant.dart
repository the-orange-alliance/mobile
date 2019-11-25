import 'dart:convert';

class MatchParticipant {
  MatchParticipant({
    this.matchParticipantKey,
    this.matchKey,
    this.teamKey,
    this.station,
    this.stationStatus,
    this.refStatus,
  });

  final String matchParticipantKey;
  final String matchKey;
  final String teamKey;
  final int station;
  final int stationStatus;
  final int refStatus;

  static List<MatchParticipant> allFromResponse(String response) {
    if (response == null) { return new List(); }
    return jsonDecode(response)
        .map((obj) => MatchParticipant.fromMap(obj))
        .toList()
        .cast<MatchParticipant>();
  }

  static MatchParticipant fromMap(Map map) {
    return MatchParticipant(
      matchParticipantKey: map['match_participant_key'],
      matchKey: map['match_key'],
      teamKey: map['team_key'].toString(),
      station: map['station'],
      stationStatus: map['station_status'],
      refStatus: map['ref_status'],
    );
  }
}