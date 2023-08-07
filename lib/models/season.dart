import 'dart:convert';

class Season {
  Season({
    this.seasonKey,
    this.description,
    this.isActive
  });

  final String? seasonKey;
  final String? description;
  final bool? isActive;

  static List<Season> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => Season.fromMap(obj))
        .toList()
        .cast<Season>();
  }

  static Season fromMap(Map map) {
    return Season(
      seasonKey: map['season_key'],
      description: map['description'],
      isActive: map['is_active']
    );
  }
}