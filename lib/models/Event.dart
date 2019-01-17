import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toa_flutter/Utils.dart';

class Event {
  Event({
    this.eventKey,
    this.seasonKey,
    this.regionKey,
    this.leagueKey,
    this.eventCode,
    this.eventRegionNumber,
    this.divisionKey,
    this.eventTypeKey,
    this.eventName,
    this.divisionName,
    this.startDate,
    this.endDate,
    this.weekKey,
    this.city,
    this.state,
    this.country,
    this.venue,
    this.website,
    this.timezone,
    this.isActive,
    this.isfinal,
    this.activeTournamentLevel,
    this.allianceCount,
    this.fieldCount,
    this.advanceSpots,
    this.advanceEvent,
  });

  final String eventKey;
  final String seasonKey;
  final String regionKey;
  final String leagueKey;
  final String eventCode;
  final int eventRegionNumber;
  final String divisionKey;
  final String eventTypeKey;
  final String eventName;
  final String divisionName;
  final String startDate;
  final String endDate;
  final String weekKey;
  final String city;
  final String state;
  final String country;
  final String venue;
  final String website;
  final String timezone;
  final int activeTournamentLevel;
  final bool isActive;
  final bool isfinal;
  final int allianceCount;
  final int fieldCount;
  final int advanceSpots;
  final String advanceEvent;

  static List<Event> allFromResponse(String response) {
    return jsonDecode(response)
        .map((obj) => Event.fromMap(obj))
        .toList()
        .cast<Event>();
  }

  static String encode(List<Event> events) {
    return jsonEncode(events
        .map((obj) => Event.toMap(obj))
        .toList());
  }

  static Event fromMap(Map map) {
    return Event(
      eventKey: map['event_key'],
      seasonKey: map['season_key'],
      regionKey: map['region_key'],
      leagueKey: map['league_key'],
      eventCode: map['event_code'],
      eventRegionNumber: map['event_region_number'],
      divisionKey: map['division_key'] != null ? map['division_key'].toString() : null,
      eventTypeKey: map['event_type_key'],
      eventName: map['event_name'],
      divisionName: map['division_name'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      weekKey: map['week_key'],
      city: map['city'],
      state: map['state_prov'],
      country: map['country'],
      venue: map['venue'],
      website: map['website'],
      timezone: map['time_zone'],
      isActive: map['is_active'],
      isfinal: map['is_final'],
      activeTournamentLevel: map['active_tournament_level'],
      allianceCount: map['alliance_count'],
      fieldCount: map['field_count'],
      advanceSpots: map['advance_spots'],
      advanceEvent: map['advance_event'],
    );
  }

  static Map toMap(Event event) {
    return {
      'event_key': event.eventKey,
      'season_key': event.seasonKey,
      'region_key': event.regionKey,
      'league_key': event.leagueKey,
      'event_code': event.eventCode,
      'event_region_number': event.eventRegionNumber,
      'division_key': event.divisionKey,
      'event_type_key': event.eventTypeKey,
      'event_name': event.eventName,
      'division_name': event.divisionName,
      'start_date': event.startDate,
      'end_date': event.endDate,
      'week_key': event.weekKey,
      'city': event.city,
      'state_prov': event.state,
      'country': event.country,
      'venue': event.venue,
      'website': event.website,
      'time_zone': event.timezone,
      'is_active': event.isActive,
      'is_final': event.isfinal,
      'active_tournament_level': event.activeTournamentLevel,
      'alliance_count': event.allianceCount,
      'field_count': event.fieldCount,
      'advance_spots': event.advanceSpots,
      'advance_event': event.advanceEvent
    };
  }

  DateTime getStartDate() {
    return DateTime.parse(startDate);
  }

  DateTime getEndDate() {
    return DateTime.parse(endDate);
  }

  String getDateString(BuildContext context) {
    return Utils.dateToString(this, context);
  }

  String getSubtitle(BuildContext context) {
    return Utils.eventSubtitle(this, context);
  }

  String getShortLocation() {
    return city + ", " + (state != null && state.isNotEmpty ? state + ", " : "") + country;
  }

  String getFullLocation() {
    return (venue != null && venue.isNotEmpty ? venue + ", " : "") + city + ", " + (state != null && !state.isEmpty ? state + ", " : "") + country;
  }

  String getFullName() {
    return eventName + (divisionName != null ? " - $divisionName Division" : "");
  }
}