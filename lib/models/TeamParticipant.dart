import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/AwardRecipient.dart';
import 'package:toa_flutter/models/Ranking.dart';

class TeamParticipant {
  TeamParticipant({
    this.teamKey,
    this.event,
    this.matches,
    this.awards,
    this.ranking,
  });

  String teamKey;
  Event event;
  List<Match> matches;
  List<AwardRecipient> awards;
  Ranking ranking;
}