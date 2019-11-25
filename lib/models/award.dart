import 'dart:convert';

class Award {
  Award({
    this.awardKey,
    this.awardType,
    this.awardDescription,
    this.displayOrder
  });

  final String awardKey;
  final int awardType;
  final String awardDescription;
  final int displayOrder;

  static List<Award> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => Award.fromMap(obj))
        .toList()
        .cast<Award>();
  }

  static Award fromMap(Map map) {
    return Award(
      awardKey: map['award_key'],
      awardType: map['award_type'],
      awardDescription: map['award_description'],
      displayOrder: map['display_order']
    );
  }
}