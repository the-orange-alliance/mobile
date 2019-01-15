import 'dart:convert';
import 'package:toa_flutter/models/Team.dart';

class EventParticipant {
  EventParticipant({
    this.eventParticipantKey,
    this.eventKey,
    this.teamKey,
    this.isActive,
    this.cardStatus,
    this.team
  });

  final String eventParticipantKey;
  final String eventKey;
  final String teamKey;
  final bool isActive;
  final String cardStatus;
  final Team team;

  static List<EventParticipant> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => EventParticipant.fromMap(obj))
        .toList()
        .cast<EventParticipant>();
  }

  static EventParticipant fromMap(Map map) {
    return EventParticipant(
        eventParticipantKey: map['event_participant_key'],
        eventKey: map['event_key'],
        teamKey: map['team_key'].toString(),
        isActive: map['is_active'],
        cardStatus: map['card_status'],
        team: Team.fromMap(map['team'])
    );
  }
}