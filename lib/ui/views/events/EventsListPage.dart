import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:toa_flutter/ui/Icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/ui/views/search/Search.dart';
import 'package:toa_flutter/models/ContentTab.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/providers/Cache.dart';
import 'package:toa_flutter/Sort.dart';
import 'package:toa_flutter/Utils.dart';
import 'package:toa_flutter/ui/views/events/StickyHeader.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:toa_flutter/internationalization/Localizations.dart';

class EventsListPage extends StatefulWidget {

  @override
  EventsListPageState createState() => EventsListPageState();
}

class EventsListPageState extends State<EventsListPage> with TickerProviderStateMixin {
  TabController tabController;
  List<Event> events = [];
  List<ContentTab> tabs = [];
  TOALocalizations local;

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

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

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
        leading: IconButton(
          icon: Icon(MdiIcons.accountCircleOutline),
          onPressed: showProfileBottomSheet
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.magnify),
            tooltip: local.get('general.search'),
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

  VoidCallback showProfileBottomSheet() {
    final ThemeData theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showRoundedModalBottomSheet(
      context: context,
      radius: 20,
      color: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Text('O'),
                  radius: 16,
                ),
                title: Text('Ofek Ashery'),
                subtitle: Text('ofek.ashery@gmail.com'),
                onTap: () {},
              ),
              Divider(height: 0),
              ListTile(
                leading: Icon(MdiIcons.themeLightDark),
                title: Text(local.get(isDark ? 'menu.switch_light_mode' : 'menu.switch_dark_mode')),
                onTap: () {
                  Navigator.pop(context);
                  DynamicTheme.of(context).setBrightness(isDark ? Brightness.light : Brightness.dark);
                }
              ),
              Divider(height: 0),
              AboutListTile(
                icon: Icon(TOAIcons.TOA),
                applicationVersion: 'Beta 1',
                aboutBoxChildren: <Widget>[
                  Text(local.get('general.about_toa_short'))
                ]
              )
            ]
          )
        );
      }
    );
  }


  // Fixes Flutter's bug - https://github.com/flutter/flutter/issues/20292#issuecomment-425601183
  void makeNewTabController() {
    tabController = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: 0,
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
        slivers.addAll(StickyHeader().buildSideHeaderGrids(context, firstIndex, count, events));
        firstIndex = i;
        count = i + 1 == events.length ? 1 : 0;
      }

      if (i > 0 && getWeekName(events[i - 1].weekKey) != getWeekName(events[i].weekKey)) {
        ScrollController scrollController = ScrollController(initialScrollOffset: findScrollOffset(firstIndexInTab, itemsPerTab));
        CustomScrollView scrollView = CustomScrollView(slivers: slivers, controller: scrollController);
        tabs.add(ContentTab(key: events[i - 1].weekKey, title: getWeekName(events[i - 1].weekKey), content: scrollView));
        makeNewTabController();
        slivers = List<Widget>();
        slivers.addAll(StickyHeader().buildSideHeaderGrids(context, firstIndex, count, events));
        firstIndex = i;
        firstIndexInTab = i;
        count = 0;
        itemsPerTab = 0;
      }

      if (i + 1 == events.length) {
        ScrollController scrollController = ScrollController(initialScrollOffset: findScrollOffset(firstIndexInTab, itemsPerTab));
        CustomScrollView scrollView = CustomScrollView(slivers: slivers, controller: scrollController);
        tabs.add(ContentTab(key: events[i].weekKey, title: getWeekName(events[i].weekKey), content: scrollView));
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
    String weekName = local.get('weeks.${weekKey.toLowerCase()}', defaultValue: '');
    if (weekName.isNotEmpty) {
      return weekName;
    } else if (double.parse(weekKey, (e) => null) != null) { // match a number include decimal, '+' and '-'
      return "Week" + weekKey;
    } else {
      return local.get('months.${weekKey.toLowerCase()}', defaultValue: weekKey);
    }
  }

  int findCurrentWeekTab() {
    if (tabs != null && tabs.length > 0) {
      String month = DateFormat("MMMM", 'en_US').format(DateTime.now());
      for (int i = 0; i < tabs.length; i++) {
        if (month.toLowerCase() == tabs[i].key.toLowerCase()) {
          return i;
        }
        if (month.toLowerCase() == 'april' && tabs[i].key.toLowerCase() == 'march') { // World Championships
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