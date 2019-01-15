import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:toa_flutter/ui/views/search/Search.dart';
import 'package:toa_flutter/ui/widgets/EventListItem.dart';
import 'package:toa_flutter/models/ContentTab.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/providers/Cache.dart';
import 'package:toa_flutter/Sort.dart';
import 'package:toa_flutter/Utils.dart';

class EventsListPage extends StatefulWidget {

  @override
  EventsListPageState createState() => EventsListPageState();
}

class EventsListPageState extends State<EventsListPage> with TickerProviderStateMixin {
  TabController tabController;
  List<Event> events = [];
  List<ContentTab> tabs = [];

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    var response = await Cache().getEvents();
    setState(() {
      events = response;
      events.sort(Sort().eventSorter);
    });
  }

  // Fixes Flutter's bug - https://github.com/flutter/flutter/issues/20292#issuecomment-425601183
  void makeNewTabController() {
    tabController = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: 0,
    );
  }

  Widget buildSideHeader(BuildContext context, int index) {
    var date = DateTime.parse(events[index].startDate);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 52.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Text(DateFormat("EEE").format(date).toUpperCase(), style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 12), textAlign: TextAlign.center)
              ),
              Text(date.day.toString(), style: TextStyle(fontSize: 22), textAlign: TextAlign.center)
            ]
          )
        )
      )
    );
  }

  buildTabs(BuildContext context) {
    List<Widget> slivers = List<Widget>();
    var firstIndex = 0, count = 0, itemsPerTab = 0, firstIndexInTab = 0;
    for(var i = 0; i < events.length; i++) {

        /////////////////////
       //  DO NOT TOUCH!  //
      /////////////////////

      if (i > 0 && events[i - 1].startDate != events[i].startDate) {
        slivers.addAll(buildSideHeaderGrids(context, firstIndex, count));
        firstIndex = i;
        count = i + 1 == events.length ? 1 : 0;
      }

      if (i > 0 && getWeekName(events[i - 1].weekKey) != getWeekName(events[i].weekKey)) {
        ScrollController scrollController = ScrollController(initialScrollOffset: findScrollOffset(firstIndexInTab, itemsPerTab));
        CustomScrollView scrollView = CustomScrollView(slivers: slivers, controller: scrollController);
        tabs.add(ContentTab(title: getWeekName(events[i - 1].weekKey), content: scrollView));
        makeNewTabController();
        slivers = List<Widget>();
        slivers.addAll(buildSideHeaderGrids(context, firstIndex, count));
        firstIndex = i;
        firstIndexInTab = i;
        count = 0;
        itemsPerTab = 0;
      }

      if (i + 1 == events.length) {
        ScrollController scrollController = ScrollController(initialScrollOffset: findScrollOffset(firstIndexInTab, itemsPerTab));
        CustomScrollView scrollView = CustomScrollView(slivers: slivers, controller: scrollController);
        tabs.add(ContentTab(title: getWeekName(events[i].weekKey), content: scrollView));
        makeNewTabController();
        slivers = List<Widget>();
        firstIndex = i;
        firstIndexInTab = i;
        count = 0;
        itemsPerTab = 0;
      }

      count++;
      itemsPerTab++;
    }
  }

  String getWeekName(String weekKey) {
    switch (weekKey) {
      case "CMP":
        return "FIRST Championship";
      case "CMPHOU":
        return "FIRST Championship - Houston";
      case "CMPSTL":
        return "FIRST Championship - St. Louis";
      case "CMPDET":
        return "FIRST Championship - Detroit";
      case "ESR":
        return "East Super Regional Championship";
      case "NSR":
        return "North Super Regional Championship";
      case "SSR":
        return "South Super Regional Championship";
      case "WSR":
        return "West Super Regional Championship";
      case "SPR":
        return "Super Regionals";
      case "FOC":
        return "Festival of Champions";
      default:
        if (double.parse(weekKey, (e) => null) != null) { // match a number include decimal, '+' and '-'
          return "Week" + weekKey;
        } else {
          return weekKey;
        }
    }
  }

  List<Widget> buildSideHeaderGrids(BuildContext context, int firstIndex, int count) {
    return List.generate(1, (sliverIndex) {
      sliverIndex += firstIndex;
      return SliverStickyHeader(
        overlapsContent: true,
        header: buildSideHeader(context, sliverIndex),
        sliver: SliverPadding(
          padding: EdgeInsets.only(left: 60.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => GestureDetector(
                child: EventListItem(events[firstIndex+i], showDate: false),
              ),
              childCount: count,
            )
          )
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (tabController == null) {
      makeNewTabController();
    }

    if (events.isEmpty) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      buildTabs(context);
      content = TabBarView(
        controller: tabController,
        children: tabs.map((ContentTab tab) {
          return tab.content;
        }).toList()
      );
    }

    int tab = findCurrentWeekTab();
    if (tab > -1 && tabController.length > tab) {
      tabController.animateTo(tab);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('The Orange Alliance'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: Colors.black,
          tabs: tabs.map((ContentTab tab) {
            return Tab(
              text: tab.title,
            );
          }).toList(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.magnify),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) {
                    return SearchPage();
                  }
                )
              );
            }
          )
        ]
      ),
      body: content,
    );
  }

  int findCurrentWeekTab() {
    if (tabs != null && tabs.length > 0) {
      String month = DateFormat("MMMM", 'en_US').format(DateTime.now());
      for (int i = 0; i < tabs.length; i++) {
        if (month.toLowerCase() == tabs[i].title.toLowerCase()) {
          return i;
        }
        if (month.toLowerCase() == 'april' && tabs[i].title.toLowerCase() == 'march') { // World Championships
          return i + 1;
        }
      }
    } else {
      return -1;
    }

    return 0;
  }

  double findScrollOffset(int i, int count) {
    double ITEM_HEIGHT = 72;
    for (int j = 0; j < count; j++) {
      DateTime eventDate = events[j+ i].getStartDate();
      DateTime now = DateTime.now();
      if (eventDate.year == now.year && eventDate.month == now.month) {
        if (Utils.isSameDate(eventDate, now)) {
          return j * ITEM_HEIGHT;

          // Find the next event
        } else if (eventDate.isAfter(now)) {
          return j * ITEM_HEIGHT;
        }
      } else {
        return 0;
      }
    }
    return 0;
  }
}