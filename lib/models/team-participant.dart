import 'package:toa_flutter/models/event.dart';
import 'package:toa_flutter/models/match.dart';
import 'package:toa_flutter/models/award-recipient.dart';
import 'package:toa_flutter/models/ranking.dart';

class TeamParticipant {
  TeamParticipant({
    this.teamKey,
    this.event,
    this.matches,
    this.awards,
    this.ranking,
  });

  String? teamKey;
  Event? event;
  List<Match>? matches;
  List<AwardRecipient>? awards;
  Ranking? ranking;
}