import 'dart:convert';

class Team {
  Team({
    required this.teamKey,
    required this.regionKey,
    required this.leagueKey,
    required this.teamNumber,
    this.teamNameShort,
    this.teamNameLong,
    this.robotName,
    this.lastActive,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.rookieYear,
    this.website
  });

  final String teamKey;
  final String regionKey;
  final String leagueKey;
  final int teamNumber;
  final String? teamNameShort;
  final String? teamNameLong;
  final String? robotName;
  final String? lastActive;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final int? rookieYear;
  final String? website;

  static List<Team>? allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => Team.fromMap(obj))
        .toList()
        .cast<Team>();
  }

  static String encode(List<Team> teams) {
    return jsonEncode(teams
        .map((obj) => Team.toMap(obj))
        .toList());
  }

  static Team fromMap(Map map) {
    return Team(
      teamKey: map['team_key'],
      regionKey: map['region_key'],
      leagueKey: map['league_key'],
      teamNumber: map['team_number'],
      teamNameShort: map['team_name_short'],
      teamNameLong: map['team_name_long'],
      robotName: map['robot_name'],
      lastActive: map['last_active'],
      city: map['city'],
      state: map['state_prov'],
      zipCode: map['zip_code'].toString(),
      country: map['country'],
      rookieYear: map['rookie_year'],
      website: map['website']
    );
  }

  static Map toMap(Team team) {
    return {
      'team_key': team.teamKey,
      'region_key': team.regionKey,
      'league_key': team.leagueKey,
      'team_number': team.teamNumber,
      'team_name_short': team.teamNameShort,
      'team_name_long': team.teamNameLong,
      'robot_name': team.robotName,
      'last_active': team.lastActive,
      'city': team.city,
      'state_prov': team.state,
      'zip_code': team.zipCode,
      'country': team.country,
      'rookie_year': team.rookieYear,
      'website': team.website
    };
  }

  String? getName() {
    return teamNameShort != null ? teamNameShort : 'Team #$teamNumber';
  }

  String getNameWithNumber() {
    return teamNameShort != null ? '$teamNameShort #$teamNumber' : 'Team #$teamNumber';
  }

  String getFullLocation() {
    return city! + ", " + (state != null && state!.isNotEmpty ? state! + ", " : "") + country!;
  }
}