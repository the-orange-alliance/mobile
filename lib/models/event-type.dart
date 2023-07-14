import 'dart:convert';

class EventType {
  EventType({
    this.eventTypeKey,
    this.description,
  });

  final String? eventTypeKey;
  final String? description;

  static List<EventType>? allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => EventType.fromMap(obj))
        .toList()
        .cast<EventType>();
  }

  static EventType fromMap(Map map) {
    return EventType(
      eventTypeKey: map['event_type_key'].toString(),
      description: map['description'].toString(),
    );
  }
}