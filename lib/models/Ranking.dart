import 'dart:convert';

class Ranking {
  Ranking({
    this.rankKey,
    this.eventKey,
    this.teamKey,
    this.rank,
    this.rankChange,
    this.wins,
    this.losses,
    this.ties,
    this.highestQualScore,
    this.rankingPoints,
    this.qualifyingPoints,
    this.tieBreakerPoints,
    this.disqualified,
    this.played
  });

  final String rankKey;
  final String eventKey;
  final String teamKey;
  final int rank;
  final int rankChange;
  final int wins;
  final int losses;
  final int ties;
  final int highestQualScore;
  final int rankingPoints;
  final int qualifyingPoints;
  final int tieBreakerPoints;
  final int disqualified;
  final int played;

  static List<Ranking> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => Ranking.fromMap(obj))
        .toList()
        .cast<Ranking>();
  }

  static Ranking fromMap(Map map) {
    return Ranking(
      rankKey: map['rank_key'],
      eventKey: map['event_key'],
      teamKey: map['team_key'].toString(),
      rank: map['rank'],
      rankChange: map['rank_change'],
      wins: map['wins'],
      losses: map['losses'],
      ties: map['ties'],
      highestQualScore: map['highest_qual_score'],
      rankingPoints: map['ranking_points'],
      qualifyingPoints: map['qualifying_points'],
      tieBreakerPoints: map['tie_breaker_points'],
      disqualified: map['disqualified'],
      played: map['played']
    );
  }
}