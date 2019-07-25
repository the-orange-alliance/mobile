import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/AwardRecipient.dart';
import '../models/Event.dart';
import '../models/EventParticipant.dart';
import '../models/EventType.dart';
import '../models/LiveStream.dart';
import '../models/Match.dart';
import '../models/MatchDetails.dart';
import '../models/MatchParticipant.dart';
import '../models/Media.dart';
import '../models/Ranking.dart';
import '../models/Season.dart';
import '../models/Team.dart';
import '../models/TeamSeasonRecord.dart';
import '../models/game-specifics/GameData.dart';

class ApiV3 {
  Future<String> get(String endpoint) async {
    print('GET $endpoint');
    String baseURL = "https://theorangealliance.org/api";
    Map<String, String> headers = {
      'X-Application-Origin': 'TOA-WebApp-1819',
      'Content-Type': 'application/json'
    };

    var request = await http.get(baseURL + endpoint, headers: headers);
    return request.body;
  }

  Future<List<EventType>> getEventTypes() async {
    String res = await get("/event-types");
    return EventType.allFromResponse(res);
  }

  Future<List<Season>> getAllSeasons() async {
    String res = await get("/seasons");
    return Season.allFromResponse(res);
  }

  Future<List<Team>> getTeams() async {
    String res = await get("/team");
    return Team.allFromResponse(res);
  }

  Future<List<Event>> getEvents() async {
    String res = await get("/event");
    return Event.allFromResponse(res);
  }

  Future<List<Event>> getSeasonEvents(String seasonKey) async {
    String res = await get("/event?season_key=$seasonKey");
    return Event.allFromResponse(res);
  }

  Future<Event> getEvent(String eventKey) async {
    String res = await get("/event/$eventKey");
    return Event.allFromResponse(res)?.elementAt(0) ?? null;
  }

  Future<List<EventParticipant>> getEventTeams(String eventKey) async {
    String res = await get("/event/$eventKey/teams");
    return EventParticipant.allFromResponse(res);
  }

  Future<List<Ranking>> getEventRankings(String eventKey) async {
    String res = await get("/event/$eventKey/rankings");
    return Ranking.allFromResponse(res);
  }

  Future<List<Match>> getEventMatches(String eventKey) async {
    String res = await get("/event/$eventKey/matches");
    return Match.allFromResponse(res);
  }

  Future<List<AwardRecipient>> getEventAwards(String eventKey) async {
    String res = await get("/event/$eventKey/awards");
    return AwardRecipient.allFromResponse(res);
  }

  Future<List<Media>> getEventMedia(String eventKey) async {
    String res = await get("/event/$eventKey/media");
    return Media.allFromResponse(res);
  }

  Future<List<LiveStream>> getEventStreams(String eventKey) async {
    String res = await get("/event/$eventKey/streams");
    return LiveStream.allFromResponse(res);
  }

  Future<Team> getTeam(String teamKey) async {
    String res = await get("/team/$teamKey");
    return Team.allFromResponse(res)?.elementAt(0) ?? null;
  }

  Future<List<Ranking>> getTeamResults(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/results/$seasonKey");
    return Ranking.allFromResponse(res);
  }

  Future<List<EventParticipant>> getTeamEvents(
      String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/events/$seasonKey");
    return EventParticipant.allFromResponse(res);
  }

  Future<List<AwardRecipient>> getTeamAwards(
      String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/awards/$seasonKey");
    return AwardRecipient.allFromResponse(res);
  }

  Future<List<MatchParticipant>> getTeamMatches(
      String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/matches/$seasonKey");
    return MatchParticipant.allFromResponse(res);
  }

  Future<List<Media>> getTeamMedia(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/media/$seasonKey");
    return Media.allFromResponse(res);
  }

  Future<TeamSeasonRecord> getTeamWLT(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/wlt?season_key=$seasonKey");
    return TeamSeasonRecord.allFromResponse(res)?.elementAt(0) ?? null;
  }

  Future<Match> getMatch(String matchKey) async {
    String res = await get("/match/$matchKey");
    return Match.allFromResponse(res)?.elementAt(0) ?? null;
  }

  Future<List<MatchParticipant>> getMatchParticipants(String matchKey) async {
    String res = await get("/match/$matchKey/participants");
    return MatchParticipant.allFromResponse(res);
  }

  Future<Match> getHighScoreQual() async {
    String res = await get("/match/high-scores?type=quals");
    return Match.allFromResponse(res)?.elementAt(0) ?? null;
  }

  Future<Match> getHighScoreElim() async {
    String res = await get("/match/high-scores?type=elims");
    return Match.allFromResponse(res)?.elementAt(0) ?? null;
  }

  Future<Match> getHighScoreWithPenalty() async {
    String res = await get("/match/high-scores?type=all");
    return Match.allFromResponse(res)?.elementAt(0) ?? null;
  }

  Future<int> getMatchesSize() async {
    String res = await get("/match/size");
    return json.decode(res)['result'];
  }

  Future<MatchDetails> getMatchGameData(String matchKey) async {
    String res = await get("/match/$matchKey/details");
    return GameData.fromResponse(matchKey?.split('-')?.elementAt(0) ?? '', res);
  }
}
