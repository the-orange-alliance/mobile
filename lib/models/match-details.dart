import 'dart:convert';

class MatchDetails {
  MatchDetails({
    this.matchDetailKey,
    this.matchKey,
    this.redMinPen,
    this.blueMinPen,
    this.redMajPen,
    this.blueMajPen,
    this.red,
    this.blue,
  });

  String? matchDetailKey;
  String? matchKey;
  int? redMinPen;
  int? blueMinPen;
  int? redMajPen;
  int? blueMajPen;

  // Map<String, dynamic> red;
  // Map<String, dynamic> blue;

  dynamic red;
  dynamic blue;

  static List<MatchDetails>? allFromResponse(String response) {
    return json
        .decode(response)
        .map((obj) => MatchDetails.fromMap(obj))
        .toList()
        .cast<MatchDetails>();
  }

  static MatchDetails fromMap(Map map) {
    return MatchDetails(
      matchDetailKey: map['match_detail_key'],
      matchKey: map['match_key'],
      redMinPen: map['red_min_pen'],
      blueMinPen: map['blue_min_pen'],
      redMajPen: map['red_maj_pen'],
      blueMajPen: map['blue_maj_pen'],
      red: map['red'] ?? null,
      blue: map['blue'] ?? null,
    );
  }
}
