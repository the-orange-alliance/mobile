import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/models/Season.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as Cal;
import 'package:toa_flutter/internationalization/Localizations.dart';

class EventInfo extends StatelessWidget {

  EventInfo(this.event);

  final Event event;

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);

    // Event Info Card
    List<Widget> eventInfoCard = [
      buildCardTitle(local.get('pages.event.info.event_info')),
      buildCardItem(
        context,
        MdiIcons.informationOutline,
        event.eventName,
        subtitle: event.divisionName != null ? event.divisionName + ' Division' : null
      ),
      buildCardItem(
        context,
        MdiIcons.calendarOutline,
        event.getDateString(context),
        onTap: () {
          Cal.Add2Calendar.addEvent2Cal(Cal.Event(
            title: event.getFullName(),
            description: '${local.get('pages.event.info.cal_description')}: https://theorangealliance.org/events/${ event.eventKey }. Powered by The Orange Alliance',
            location: event.getFullLocation(),
            startDate: DateTime(event.getStartDate().year, event.getStartDate().month, event.getStartDate().day, 7, 30),
            endDate: DateTime(event.getEndDate().year, event.getEndDate().month, event.getEndDate().day, 18, 30)
          ));
        }
      ),
      buildCardItem(
        context,
        MdiIcons.mapMarkerOutline,
        event.venue != null ? event.venue : event.getShortLocation(),
        subtitle: event.venue != null ? event.getShortLocation() : null,
        onTap: () async {
          final url = "geo:0,0?q=${ event.getFullLocation() }";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(local.get('general.error_occurred')),
            ));
          }
        }
      )
    ];

    if (event.website != null) {
      eventInfoCard.add(
        buildCardItem(
          context,
          MdiIcons.earth,
          local.get('pages.event.info.view_website'),
          onTap: () async {
            final url = event.website;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(local.get('general.error_occurred')),
              ));
            }
          }
        )
      );
    }

    // Event Game Card
    List<Widget> gameInfoCard = [
      buildCardTitle(local.get('pages.event.info.game_info')),
      FutureBuilder(
        future: getSeasonName(event.seasonKey),
        initialData: local.get('pages.event.info.loading_sesson'),
        builder: (BuildContext context, AsyncSnapshot<String> seasonName) {
          return buildCardItem(context, MdiIcons.gamepadVariant, seasonName.data);
        }
      ),
      buildCardItem(context, MdiIcons.humanHandsup, "${event.allianceCount} ${local.get('pages.event.info.alliances')}"),
      buildCardItem(context, MdiIcons.soccerField, "${event.fieldCount} ${local.get('pages.event.info.fields')}")
    ];

    return ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: eventInfoCard
              )
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
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

  Widget buildCardTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, bottom: 8, right: 16),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

  Widget buildCardItem(BuildContext context, IconData icon, String title, {String subtitle, GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
      )
    );
  }

  Future<String> getSeasonName(String seasonKey) async {
    String seasonName = "$seasonKey Season";
    List<Season> seasons = await ApiV3().getAllSeasons();
    for (int i = 0; i < seasons.length; i++) {
      Season season = seasons[i];
      if (season.seasonKey == seasonKey) {
        seasonName = season.description;
        break;
      }
    }
    return seasonName;
  }
}