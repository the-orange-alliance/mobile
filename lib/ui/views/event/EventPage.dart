import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

import './subpages/EventAwards.dart';
import './subpages/EventInfo.dart';
import './subpages/EventMatches.dart';
import './subpages/EventRankings.dart';
import './subpages/EventTeams.dart';
import '../../../internationalization/Localizations.dart';
import '../../../models/Event.dart';
import '../../../models/EventSettings.dart';
import '../../../providers/Cloud.dart';
import '../../dialogs/event-settings.dart';

class EventPage extends StatefulWidget {
  EventPage(this.event);

  final Event event;

  @override
  EventPageState createState() => new EventPageState();
}

class EventPageState extends State<EventPage>
    with TickerProviderStateMixin, RouteAware {
  EventSettings eventSettings;
  TabController tabController;
  int currentIndex = 0;

  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 150);
  GlobalKey fabKey = RectGetter.createGlobalKey();
  Rect rect;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });

    Cloud()
        .getEventSettings(widget.event.eventKey)
        .then((EventSettings eventSettings) {
      setState(() {
        this.eventSettings = eventSettings;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    ThemeData theme = Theme.of(context);
    Color appBarColor = theme.brightness == Brightness.light
        ? Color(0xE6FF9800)
        : theme.primaryColor;
    String eventKey = widget.event.eventKey;

    EventInfo eventInfo = EventInfo(widget.event);
    EventTeams eventTeams = EventTeams(widget.event);
    Widget eventMatches = EventMatches(widget.event);
    Widget eventRanking = EventRankings(widget.event);
    Widget eventAwards = EventAwards(widget.event);

    return Stack(children: <Widget>[
      DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(color: appBarColor),
          child: Image.asset(
            "assets/images/event.jpg",
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
          )),
      Scaffold(
          appBar: AppBar(
              title: Text(widget.event.eventName, overflow: TextOverflow.fade),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                PopupMenuButton(onSelected: (String value) {
                  if (value == 'add_to_mytoa') {
                    eventSettings.isFavorite = true;
                    Cloud().updateEventSettings(eventKey, eventSettings);
                  }
                  if (value == 'remove_from_mytoa') {
                    eventSettings.isFavorite = false;
                    Cloud().updateEventSettings(eventKey, eventSettings);
                  }
                  setState(() {});
                }, itemBuilder: (BuildContext c) {
                  return [
                    PopupMenuItem(
                      value: 'refresh',
                      child: Text(local.get('general.refresh')),
                    ),
                    eventSettings != null && eventSettings.isFavorite
                        ? PopupMenuItem(
                            value: 'remove_from_mytoa',
                            child: Text(local.get('general.remove_from_mytoa')),
                          )
                        : null,
                    eventSettings != null && !eventSettings.isFavorite
                        ? PopupMenuItem(
                            value: 'add_to_mytoa',
                            child: Text(local.get('general.add_to_mytoa')),
                          )
                        : null
                  ].where((o) => o != null).toList();
                })
              ],
              bottom: TabBar(
                  controller: tabController,
                  indicatorColor: theme.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  isScrollable: true,
                  tabs: [
                    Tab(text: local.get('pages.event.info.title')),
                    Tab(text: local.get('pages.event.teams.title')),
                    Tab(text: local.get('pages.event.matches.title')),
                    Tab(text: local.get('pages.event.rankings.title')),
                    Tab(text: local.get('pages.event.awards.title'))
                  ])),
          backgroundColor: Colors.transparent,
          floatingActionButton: currentIndex == 0 && eventSettings != null
              ? FloatingActionButton(
                  key: fabKey,
                  onPressed: () {
                    setState(() => rect = RectGetter.getRectFromKey(fabKey));
                    WidgetsBinding.instance
                        .addPostFrameCallback((Duration timeStamp) {
                      setState(() => rect = rect.inflate(
                          1.3 * MediaQuery.of(context).size.longestSide));
                      Future.delayed(animationDuration + delay, () {
                        Navigator.of(context)
                            .push(FadeRouteBuilder(
                                page: EventSettingsDialog(eventSettings)))
                            .then((dynamic eventSettings) {
                          setState(() => rect = null);
                          if (eventSettings != null) {
                            this.eventSettings = eventSettings;
                            Cloud()
                                .updateEventSettings(eventKey, eventSettings);
                          }
                        });
                      }); //<-- after delay, go to next page
                    });

//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (c) {
//                    return EventSettingsDialog(eventSettings);
//                  }
//                )
//              ).then((v) {
//                print(v);
//              });
                  },
                  child: Icon(Icons.star),
                )
              : null,
          body: Container(
              color: theme.scaffoldBackgroundColor,
              child: TabBarView(controller: tabController, children: [
                eventInfo,
                eventTeams,
                eventMatches,
                eventRanking,
                eventAwards
              ]))),
      rect == null
          ? Container()
          : AnimatedPositioned(
              duration: animationDuration,
              left: rect.left,
              right: MediaQuery.of(context).size.width - rect.right,
              top: rect.top,
              bottom: MediaQuery.of(context).size.height - rect.bottom,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }
}
