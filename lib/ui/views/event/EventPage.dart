import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventInfo.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventTeams.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventMatches.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventRankings.dart';
import 'package:toa_flutter/ui/views/event/subpages/EventAwards.dart';

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
    Widget eventInfo = EventInfo(widget.event);
    Widget eventTeams = EventTeams(widget.event);
    Widget eventMatches = EventMatches(widget.event);
    Widget eventRanking = EventRankings(widget.event);
    Widget eventAwards = EventAwards(widget.event);

    return DefaultTabController(
      length: 5,
      child: Stack(
        children: <Widget>[
          DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(color: const Color(0xE6FF9800)),
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
                  tooltip: 'Refresh',
                  onPressed: () {
                    // Rebuild the page
                    // TODO: rebuild page
                  }
                )
              ],
              bottom: TabBar(
                indicatorColor: Colors.black,
                isScrollable: true,
                tabs: [
                  Tab(text: "Info"),
                  Tab(text: "Teams"),
                  Tab(text: "Matches"),
                  Tab(text: "Rankings"),
                  Tab(text: "Awards")
                ]
              )
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              color: Color(0xFFF9F9F9),
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
