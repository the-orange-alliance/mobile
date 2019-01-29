import 'package:flutter/material.dart';
import 'package:toa_flutter/providers/Firebase.dart';
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

  bool firebaseConnected = false;
  bool isFav = false;

  Future<void> loadUser() async {
    String uid = await Firebase().getUID();
    bool isFav = await Firebase().isFavEvent(widget.event.eventKey);
    setState(() {
      this.isFav = isFav;
      this.firebaseConnected = uid != null;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    ThemeData theme = Theme.of(context);
    Color appBarColor = theme.brightness == Brightness.light ? Color(0xE6FF9800) : theme.primaryColor;
    String eventKey = widget.event.eventKey;

    EventInfo eventInfo = EventInfo(widget.event);
    EventTeams eventTeams = EventTeams(widget.event);
    Widget eventMatches = EventMatches(widget.event);
    Widget eventRanking = EventRankings(widget.event);
    Widget eventAwards = EventAwards(widget.event);

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
              title: Text(widget.event.eventName, overflow: TextOverflow.fade),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                PopupMenuButton(
                  onSelected: (String value) {
                    if (value == 'add_to_mytoa') {
                      Firebase().setFavEvent(eventKey, true);
                    }
                    if (value == 'remove_from_mytoa') {
                      Firebase().setFavEvent(eventKey, false);
                    }
                    setState(() {});
                  },
                  itemBuilder: (BuildContext c) {
                    return [
                      PopupMenuItem(
                        value: 'refresh',
                        child: Text(local.get('general.refresh')),
                      ),
                      firebaseConnected && isFav ? PopupMenuItem(
                        value: 'remove_from_mytoa',
                        child: Text(local.get('general.remove_from_mytoa')),
                      ) : null,
                      firebaseConnected && !isFav ? PopupMenuItem(
                        value: 'add_to_mytoa',
                        child: Text(local.get('general.add_to_mytoa')),
                      ) : null
                    ].where((o) => o != null).toList();
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
