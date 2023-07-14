import 'dart:async';

import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:flutter/material.dart';
import 'package:toa_flutter/models/event.dart';
import 'package:toa_flutter/providers/api.dart';
import 'package:toa_flutter/models/season.dart';
import 'package:toa_flutter/models/live-stream.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as Cal;
import 'package:toa_flutter/ui/widgets/title.dart';
import 'package:toa_flutter/internationalization/localizations.dart';

class EventInfo extends StatelessWidget {

  EventInfo(this.event);
  final Event? event;

  ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context)!;
    theme = Theme.of(context);

    // Event Info Card
    List<Widget?> eventInfoCard = [
      TOATitle(local.get('pages.event.info.event_info'), context),
      buildCardItem(
        context,
        MdiIcons.informationOutline,
        event!.eventName!,
        subtitle: event!.divisionName != null ? event!.divisionName! + ' Division' : null
      ),
      buildCardItem(
        context,
        MdiIcons.calendarOutline,
        event!.getDateString(context),
        onTap: () {
          Cal.Add2Calendar.addEvent2Cal(Cal.Event(
            title: event!.getFullName(),
            description: '${local.get('pages.event.info.cal_description')}: https://theorangealliance.org/events/${ event!.eventKey }. Powered by The Orange Alliance',
            location: event!.getFullLocation(),
            startDate: DateTime(event!.getStartDate().year, event!.getStartDate().month, event!.getStartDate().day, 7, 30),
            endDate: DateTime(event!.getEndDate().year, event!.getEndDate().month, event!.getEndDate().day, 18, 30)
          ));
        }
      ),
      buildCardItem(
        context,
        MdiIcons.mapMarkerOutline,
        event!.venue != null ? event!.venue! : event!.getShortLocation(),
        subtitle: event!.venue != null ? event!.getShortLocation() : null,
        onTap: () async {
          final url = "geo:0,0?q=${ event!.getFullLocation() }";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(local.get('general.error_occurred')),
            ));
          }
        }
      ),

      event!.website != null ? buildCardItem(
        context,
        MdiIcons.earth,
        local.get('pages.event.info.view_website'),
        onTap: () async {
          final url = event!.website!;
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(local.get('general.error_occurred')),
            ));
          }
        }
      ) : null,
      FutureBuilder(
        future: getLiveStream(event!.eventKey),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<LiveStream?> data) {
          LiveStream? stream = data.data;
          if (stream != null) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: FloatingActionButton.extended(
                  elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),

                    icon: Icon(MdiIcons.videoOutline),
                  label:  Text(local.get('pages.event.info.stream_available')),
                  onPressed: () async {
                    final url = stream.streamType == '1' ? stream.channelURL! : stream.streamURL!;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(local.get('general.error_occurred')),
                      ));
                    }
                  }
                )
              )
            );
          } else {
            return SizedBox();  // Empty
          }
        }
      )
    ].whereNotNull().toList();

    // Event Game Card
    List<Widget> gameInfoCard = [
      TOATitle(local.get('pages.event.info.game_info'), context),
      FutureBuilder(
        future: getSeasonName(event!.seasonKey),
        initialData: local.get('pages.event.info.loading_season'),
        builder: (BuildContext context, AsyncSnapshot<String?> seasonName) {
          return buildCardItem(context, MdiIcons.gamepadVariant, seasonName.data ?? "${event!.seasonKey} Season");
        }
      ),
      buildCardItem(context, MdiIcons.humanHandsup, "${event!.allianceCount} ${local.get('pages.event.info.alliances')}"),
      buildCardItem(context, MdiIcons.soccerField, "${event!.fieldCount} ${local.get('pages.event.info.fields')}"),
    ];

    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: eventInfoCard as List<Widget>
            )
          )
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: gameInfoCard
            )
          )
        )
      ]
    );
  }

  Widget buildCardItem(BuildContext context, IconData icon, String title, {String? subtitle, GestureTapCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
      )
    );
  }

  Future<String?> getSeasonName(String? seasonKey) async {
    String? seasonName = "$seasonKey Season";
    List<Season> seasons = await (ApiV3().getAllSeasons() as FutureOr<List<Season>>);
    for (int i = 0; i < seasons.length; i++) {
      Season season = seasons[i];
      if (season.seasonKey == seasonKey) {
        seasonName = season.description;
        break;
      }
    }
    return seasonName;
  }
  
  Future<LiveStream?> getLiveStream(String? eventKey) async {
    List<LiveStream> streams = await (ApiV3().getEventStreams(eventKey) as FutureOr<List<LiveStream>>);
    if (streams.length > 0) {
      return streams[0];
    }
    return null;
  }
}