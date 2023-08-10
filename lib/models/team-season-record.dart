import 'dart:convert';

class TeamSeasonRecord {
  TeamSeasonRecord({
    this.wins,
    this.losses,
    this.ties
  });

  int? wins;
  int? losses;
  int? ties;

  static List<TeamSeasonRecord> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => TeamSeasonRecord.fromMap(obj))
        .toList()
        .cast<TeamSeasonRecord>();
  }

  static TeamSeasonRecord fromMap(Map map) {
    return TeamSeasonRecord(
      wins: map['wins'],
      losses: map['losses'],
      ties: map['ties']
    );
  }
}