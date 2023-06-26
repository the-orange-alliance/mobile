import 'dart:convert';
import 'package:toa_flutter/models/team.dart';

class Ranking {
  Ranking({
    this.rankKey,
    this.eventKey,
    this.teamKey,
    this.rank,
    this.rankChange,
    this.opr,
    this.wins,
    this.losses,
    this.ties,
    this.highestQualScore,
    this.rankingPoints,
    this.qualifyingPoints,
    this.tieBreakerPoints,
    this.disqualified,
    this.played,
    this.team,
  });

  final String rankKey;
  final String eventKey;
  final String teamKey;
  final num rank;
  final num rankChange;
  final num opr;
  final num wins;
  final num losses;
  final num ties;
  final num highestQualScore;
  final num rankingPoints;
  final num qualifyingPoints;
  final num tieBreakerPoints;
  final num disqualified;
  final num played;
  final Team team;

  static List<Ranking> allFromResponse(String response) {
    return json
        .decode(response)
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
        opr: map['opr'],
        wins: map['wins'],
        losses: map['losses'],
        ties: map['ties'],
        highestQualScore: map['highest_qual_score'],
        rankingPoints: map['ranking_points'],
        qualifyingPoints: map['qualifying_points'],
        tieBreakerPoints: map['tie_breaker_points'],
        disqualified: map['disqualified'],
        played: map['played'],
        team: map.containsKey('team') && map['team'] != null
            ? Team.fromMap(map['team'])
            : null);
  }
}
