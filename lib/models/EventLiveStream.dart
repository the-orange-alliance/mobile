import 'dart:convert';

class EventLiveStream {
  EventLiveStream({
    this.streamKey,
    this.eventKey,
    this.streamType,
    this.isActive,
    this.streamURL,
    this.channelName,
    this.streamName,
    this.startDateTime,
    this.endDateTime,
    this.channelURL
  });

  final String streamKey;
  final String eventKey;
  final int streamType;
  final bool isActive;
  final String streamURL;
  final String channelName;
  final String streamName;
  final String startDateTime;
  final String endDateTime;
  final String channelURL;

  static List<EventLiveStream> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => EventLiveStream.fromMap(obj))
        .toList()
        .cast<EventLiveStream>();
  }

  static EventLiveStream fromMap(Map map) {
    return EventLiveStream(
      streamKey: map['stream_key'],
      eventKey: map['event_key'],
      streamType: map['stream_type'],
      isActive: map['is_active'],
      streamURL: map['url'],
      channelName: map['channel_name'],
      streamName: map['stream_name'],
      startDateTime: map['start_datetime'],
      endDateTime: map['end_datetime'],
      channelURL: map['channel_url'],
    );
  }
}