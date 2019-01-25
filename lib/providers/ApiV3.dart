import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:toa_flutter/models/EventType.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/models/Season.dart';
import 'package:toa_flutter/models/Team.dart';
import 'package:toa_flutter/models/TeamSeasonRecord.dart';
import 'package:toa_flutter/models/EventParticipant.dart';
import 'package:toa_flutter/models/Ranking.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/Media.dart';
import 'package:toa_flutter/models/AwardRecipient.dart';
import 'package:toa_flutter/models/MatchParticipant.dart';
import 'package:toa_flutter/models/MatchDetails.dart';
import 'package:toa_flutter/models/game-specifics/GameData.dart';

class ApiV3 {

  Future<String> get(String endpoint) async {
//    const baseURL = "https://theorangealliance.org/api";
    const baseURL = "http://35.202.99.121/api";
    const headers = {
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
    return Event.allFromResponse(res)[0];
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

  Future<Team> getTeam(String teamKey) async {
    String res = await get("/team/$teamKey");
    return Team.allFromResponse(res)[0];
  }

  Future<List<Ranking>> getTeamResults(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/results/$seasonKey");
    return Ranking.allFromResponse(res);
  }

  Future<List<EventParticipant>> getTeamEvents(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/events/$seasonKey");
    return EventParticipant.allFromResponse(res);
  }

  Future<List<AwardRecipient>> getTeamAwards(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/awards/$seasonKey");
    return AwardRecipient.allFromResponse(res);
  }

  Future<List<MatchParticipant>> getTeamMatches(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/matches/$seasonKey");
    return MatchParticipant.allFromResponse(res);
  }

  Future<List<Media>> getTeamMedia(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/media/$seasonKey");
    return Media.allFromResponse(res);
  }

  Future<TeamSeasonRecord> getTeamWLT(String teamKey, String seasonKey) async {
    String res = await get("/team/$teamKey/wlt?season_key=$seasonKey");
    return TeamSeasonRecord.allFromResponse(res)[0];
  }

  Future<Match> getMatch(String matchKey) async {
    String res = await get("/match/$matchKey");
    return Match.allFromResponse(res)[0];
  }

  Future<List<MatchParticipant>> getMatchParticipants(String matchKey) async {
    String res = await get("/match/$matchKey/participants");
    return MatchParticipant.allFromResponse(res);
  }

  Future<Match> getHighScoreQual() async {
    String res = await get("/match/high-scores?type=quals");
    return Match.allFromResponse(res)[0];
  }

  Future<Match> getHighScoreElim() async {
    String res = await get("/match/high-scores?type=elims");
    return Match.allFromResponse(res)[0];
  }

  Future<Match> getHighScoreWithPenalty() async {
    String res = await get("/match/high-scores?type=all");
    return Match.allFromResponse(res)[0];
  }

  Future<int> getMatchesSize() async {
    String res = await get("/match/size");
    return json.decode(res)['result'];
  }

  Future<MatchDetails> getMatchGameData(String matchKey) async {
    String res = await get("/match/$matchKey/details");
    return GameData.fromResponse(matchKey.split('-')[0], res);
  }
}
