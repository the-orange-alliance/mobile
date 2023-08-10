import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/award-recipient.dart';
import '../models/event.dart';
import '../models/event-participant.dart';
import '../models/event-type.dart';
import '../models/live-stream.dart';
import '../models/match.dart';
import '../models/match-details.dart';
import '../models/match-participant.dart';
import '../models/media.dart';
import '../models/ranking.dart';
import '../models/season.dart';
import '../models/team.dart';
import '../models/team-season-record.dart';
import '../models/game-specifics/game-data.dart';

class ApiV3 {
  Future<String> get(String endpoint) async {
    print('GET $endpoint');
    String baseURL = 'https://theorangealliance.org/api';
    Map<String, String> headers = {
      'X-Application-Origin': 'TOA-WebApp-1819',
      'Content-Type': 'application/json'
    };

    var request =
        await http.get(Uri.parse(baseURL + endpoint), headers: headers);
    if (request.statusCode != 200) {
      throw request.body;
    }
    return request.body;
  }

  Future<List<EventType>> getEventTypes() async {
    String res = await get('/event-types');
    return EventType.allFromResponse(res);
  }

  Future<List<Season>> getAllSeasons() async {
    String res = await get('/seasons');
    return Season.allFromResponse(res);
  }

  Future<List<Team>> getTeams() async {
    String res = await get('/team');
    return Team.allFromResponse(res);
  }

  Future<List<Event>> getEvents() async {
    String res = await get('/event');
    return Event.allFromResponse(res);
  }

  Future<List<Event>> getSeasonEvents(String seasonKey) async {
    String res = await get('/event?season_key=$seasonKey');
    return Event.allFromResponse(res);
  }

  Future<Event?> getEvent(String eventKey) async {
    String res = await get('/event/$eventKey');
    var e = Event.allFromResponse(res);
    return e.isNotEmpty ? e.first : null;
  }

  Future<List<EventParticipant>> getEventTeams(String? eventKey) async {
    String res = await get('/event/$eventKey/teams');
    return EventParticipant.allFromResponse(res);
  }

  Future<List<Ranking>> getEventRankings(String? eventKey) async {
    String res = await get('/event/$eventKey/rankings');
    return Ranking.allFromResponse(res);
  }

  Future<List<Match>> getEventMatches(String? eventKey) async {
    String res = await get('/event/$eventKey/matches');
    return Match.allFromResponse(res);
  }

  Future<List<AwardRecipient>> getEventAwards(String? eventKey) async {
    String res = await get('/event/$eventKey/awards');
    return AwardRecipient.allFromResponse(res);
  }

  Future<List<Media>> getEventMedia(String eventKey) async {
    String res = await get('/event/$eventKey/media');
    return Media.allFromResponse(res);
  }

  Future<List<LiveStream>> getEventStreams(String? eventKey) async {
    String res = await get('/event/$eventKey/streams');
    return LiveStream.allFromResponse(res);
  }

  Future<Team?> getTeam(String? teamKey) async {
    String res = await get('/team/$teamKey');
    var t = Team.allFromResponse(res);
    return t.isNotEmpty ? t.first : null;
  }

  Future<List<Ranking>> getTeamResults(
      String? teamKey, String seasonKey) async {
    String res = await get('/team/$teamKey/results/$seasonKey');
    return Ranking.allFromResponse(res);
  }

  Future<List<EventParticipant>> getTeamEvents(
      String? teamKey, String seasonKey) async {
    String res = await get('/team/$teamKey/events/$seasonKey');
    return EventParticipant.allFromResponse(res);
  }

  Future<List<AwardRecipient>> getTeamAwards(
      String teamKey, String seasonKey) async {
    String res = await get('/team/$teamKey/awards/$seasonKey');
    return AwardRecipient.allFromResponse(res);
  }

  Future<List<MatchParticipant>> getTeamMatches(
      String teamKey, String seasonKey) async {
    String res = await get('/team/$teamKey/matches/$seasonKey');
    return MatchParticipant.allFromResponse(res);
  }

  Future<List<Media>> getTeamMedia(String teamKey, String seasonKey) async {
    String res = await get('/team/$teamKey/media/$seasonKey');
    return Media.allFromResponse(res);
  }

  Future<TeamSeasonRecord?> getTeamWLT(String teamKey, String seasonKey) async {
    String res = await get('/team/$teamKey/wlt?season_key=$seasonKey');
    var wlt = TeamSeasonRecord.allFromResponse(res);
    return wlt.isNotEmpty ? wlt.first : null;
  }

  Future<Match?> getMatch(String? matchKey) async {
    String res = await get('/match/$matchKey');
    List<Match> m = Match.allFromResponse(res);
    return m.isNotEmpty ? m.first : null;
  }

  Future<List<MatchParticipant>> getMatchParticipants(String matchKey) async {
    String res = await get('/match/$matchKey/participants');
    return MatchParticipant.allFromResponse(res);
  }

  Future<Match?> getHighScoreQual() async {
    String res = await get('/match/high-scores?type=quals');
    var m = Match.allFromResponse(res);
    return m.isNotEmpty ? m.first : null;
  }

  Future<Match?> getHighScoreElim() async {
    String res = await get('/match/high-scores?type=elims');
    var m = Match.allFromResponse(res);
    return m.isNotEmpty ? m.first : null;
  }

  Future<Match?> getHighScoreWithPenalty() async {
    String res = await get('/match/high-scores?type=all');
    var m = Match.allFromResponse(res);
    return m.isNotEmpty ? m.first : null;
  }

  Future<int> getMatchesSize() async {
    String res = await get('/match/size');
    return json.decode(res)['result'];
  }

  Future<MatchDetails?> getMatchGameData(String? matchKey) async {
    String res = await get('/match/$matchKey/details');
    return GameData.fromResponse(matchKey?.split('-').elementAt(0) ?? '', res);
  }
}
