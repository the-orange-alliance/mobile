import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventInfo.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventTeams.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventMatches.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventRankings.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventAwards.dart';
import 'package:toa_flutter/internationalization/Localizations.dart';

class EventPage extends StatefulWidget {
  EventPage(this.event);

  final Event event;

  @override
  EventPageState createState() => new EventPageState();
}

class EventPageState extends State<EventPage> {

  bool myBool = true;

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    ThemeData theme = Theme.of(context);
    Color appBarColor = theme.brightness == Brightness.light ? Color(0xE6FF9800) : theme.primaryColor;

    EventInfo eventInfo = EventInfo(widget.event);
    EventTeams eventTeams = new EventTeams(widget.event);
    Widget eventMatches = new EventMatches(widget.event);
    Widget eventRanking = new EventRankings(widget.event);
    Widget eventAwards = new EventAwards(widget.event);

    return DefaultTabController(
      length: 5,
      child: Stack(
        children: <Widget>[
          DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(color: appBarColor),
            child: Image.asset(
              "assets/images/event.jpg",
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            )
          ),
          Scaffold(
            appBar: AppBar(
              title: Text(widget.event.eventName),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(MdiIcons.refresh),
                  tooltip: local.get('general.refresh'),
                  onPressed: () {
                    // Rebuild the page
                    setState(() {});
                  }
                )
              ],
              bottom: TabBar(
                indicatorColor: theme.brightness == Brightness.light ? Colors.black : Colors.white,
                isScrollable: true,
                tabs: [
                  Tab(text: local.get('pages.event.info.title')),
                  Tab(text: local.get('pages.event.teams.title')),
                  Tab(text: local.get('pages.event.matches.title')),
                  Tab(text: local.get('pages.event.rankings.title')),
                  Tab(text: local.get('pages.event.awards.title'))
                ]
              )
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              color: theme.scaffoldBackgroundColor,
              child: TabBarView(
                children: [
                  eventInfo,
                  eventTeams,
                  eventMatches,
                  eventRanking,
                  eventAwards
                ]
              )
            )
          )
        ]
      )
    );
  }
}
