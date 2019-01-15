import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/models/Season.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as Cal;

class EventInfo extends StatelessWidget {

  EventInfo(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {

    // Event Info Card
    List<Widget> eventInfoCard = [
      buildCardTitle("Event Info"),
      buildCardItem(
          MdiIcons.informationOutline,
          event.eventName,
          event.divisionName != null ? event.divisionName + ' Division' : null,
          context
      ),
      InkWell(
        onTap: () {
          Cal.Add2Calendar.addEvent2Cal(Cal.Event(
            title: event.getFullName(),
            description: 'For more details and results in real time: https://theorangealliance.org/events/${ event.eventKey }. Powered by The Orange Alliance',
            location: event.getFullLocation(),
            startDate: DateTime(event.getStartDate().year, event.getStartDate().month, event.getStartDate().day, 7, 30),
            endDate: DateTime(event.getEndDate().year, event.getEndDate().month, event.getEndDate().day, 18, 30))
          );
        },
        child: buildCardItem(
          MdiIcons.calendarOutline,
          event.getDateString(),
          null,
          context
        )
      ),
      InkWell(
        onTap: () async {
          final url = "geo:0,0?q=${ event.getFullLocation() }";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("An error has occurred"),
            ));
          }
        },
        child: buildCardItem(
          MdiIcons.mapMarkerOutline,
          event.venue != null ? event.venue : event.getShortLocation(),
          event.venue != null ? event.getShortLocation() : null,
          context
        )
      ),
    ];

    if (event.website != null) {
      eventInfoCard.add(
          InkWell(
            onTap: () async {
              final url = event.website;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("An error has occurred"),
              ));
              }
            },
            child: buildCardItem(MdiIcons.earth, "View event's website", null, context),
          )
      );
    }

    // Event Game Card
    List<Widget> gameInfoCard = List();
    gameInfoCard.add(buildCardTitle("Game Info"));
    gameInfoCard.add(FutureBuilder(
        future: getSeasonName(event.seasonKey),
        initialData: "Loading sesson name...",
        builder: (BuildContext context, AsyncSnapshot<String> seasonName) {
          return buildCardItem(MdiIcons.gamepadVariant, seasonName.data, null, context);
        })
    );
    gameInfoCard.add(buildCardItem(MdiIcons.humanHandsup, "${event.allianceCount} Alliances", null, context));
    gameInfoCard.add(buildCardItem(MdiIcons.soccerField, "${event.fieldCount} Fields", null, context));

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
      padding: const EdgeInsets.only(left: 16.0, top: 20, bottom: 8, right: 16),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }

  Widget buildCardItem(IconData icon, String title, String subtitle, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
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