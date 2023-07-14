import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';

import './sticky-header.dart';
import '../../../sort.dart';
import '../../../utils.dart';
import '../../../internationalization/localizations.dart';
import '../../../models/content-tab.dart';
import '../../../models/event.dart';
import '../../../providers/cloud.dart';
import '../../../providers/cache.dart';
import '../../widgets/profile-bottom-sheet.dart';
import '../search/search.dart';

class EventsListPage extends StatefulWidget {
  @override
  EventsListPageState createState() => EventsListPageState();
}

class EventsListPageState extends State<EventsListPage>
    with TickerProviderStateMixin {
  TabController? tabController;
  List<Event>? events = [];
  List<ContentTab> tabs = [];
  TOALocalizations? local;
  bool tabChanged = false;

  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      packageInfo = info;
      return Cache().getEvents();
    }).then((List<Event>? cacheEvents) {
      setState(() {
        events = cacheEvents;
        events!.sort(Sort().eventSorter);
      });
    });
    Cloud.initFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

    Widget content;

    if (tabController == null) {
      makeNewTabController();
    }

    if (events!.isEmpty) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (tabController!.length != tabs.length || tabs.length == 0) {
        buildTabs(context);
      }
      content = TabBarView(
          controller: tabController,
          children: tabs.map((ContentTab tab) {
            return tab.content;
          }).toList());
    }

    int tab = findCurrentWeekTab();
    if (tab > -1 && tabController!.length > tab && !tabChanged) {
      tabController!.animateTo(tab);
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
              onPressed: () =>
                  ProfileBottomSheet().showProfileBottomSheet(context, packageInfo)),
          actions: <Widget>[
            IconButton(
                icon: Icon(MdiIcons.magnify),
                tooltip: local!.get('general.search'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                    return SearchPage();
                  }));
                })
          ]),
      body: content,
    );
  }

  // Fixes Flutter's bug - https://github.com/flutter/flutter/issues/20292#issuecomment-425601183
  void makeNewTabController() {
    tabController = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: 0,
    );
    tabController!.addListener(() {
      tabChanged = true;
    });
  }

  buildTabs(BuildContext context) {
    List<Widget> slivers = [];
    int firstIndex = 0, count = 0, itemsPerTab = 0, firstIndexInTab = 0;
    for (int i = 0; i < events!.length; i++) {
      if (i > 0 && events![i - 1].startDate != events![i].startDate) {
        slivers.addAll(StickyHeader()
            .buildSideHeaderGrids(context, firstIndex, count, events));
        firstIndex = i;
        count = i + 1 == events!.length ? 1 : 0;
      }

      if (i > 0 && getWeekName(events![i - 1].weekKey!) != getWeekName(events![i].weekKey!)) {
        ScrollController scrollController = ScrollController(
          initialScrollOffset: findScrollOffset(firstIndexInTab, itemsPerTab)
        );
        CustomScrollView scrollView = CustomScrollView(
          slivers: slivers,
          controller: scrollController
        );

        tabs.add(ContentTab(
          key: events![i - 1].weekKey!,
          title: getWeekName(events![i - 1].weekKey!),
          content: scrollView
        ));
        makeNewTabController();
        slivers = [];
        slivers.addAll(StickyHeader().buildSideHeaderGrids(context, firstIndex, count, events));
        firstIndex = i;
        firstIndexInTab = i;
        count = 0;
        itemsPerTab = 0;
      }

      if (i + 1 == events!.length) {
        ScrollController scrollController = ScrollController(
          initialScrollOffset: findScrollOffset(firstIndexInTab, itemsPerTab)
        );
        CustomScrollView scrollView = CustomScrollView(slivers: slivers, controller: scrollController);
        tabs.add(ContentTab(
          key: events![i].weekKey!,
          title: getWeekName(events![i].weekKey!),
          content: scrollView
        ));
        makeNewTabController();
        slivers = [];
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
    String weekName = local!.get('weeks.${weekKey.toLowerCase()}', defaultValue: '');
    if (weekName == null) {
      return 'Unknown week';
    } else if (weekName.isNotEmpty) {
      return weekName;
    } else if (double.tryParse(weekKey) != null) {
      // weekKey is a number
      return 'Week' + weekKey;
    } else {
      return local!.get('months.${weekKey.toLowerCase()}', defaultValue: weekKey);
    }
  }

  int findCurrentWeekTab() {
    if (tabs != null && tabs.length > 0) {
      String month = DateFormat('MMMM', 'en_US').format(DateTime.now());
      for (int i = 0; i < tabs.length; i++) {
        if (month.toLowerCase() == tabs[i].key.toLowerCase()) {
          return i;
        }
        if (month.toLowerCase() == 'april' &&
            tabs[i].key.toLowerCase() == 'march') {
          // World Championships
          return i + 1;
        }
      }
      return tabs.length - 1;
    } else {
      return -1;
    }
  }

  double findScrollOffset(int i, int count) {
    double itemHeight = 72;
    for (int j = 0; j < count; j++) {
      DateTime eventDate = events![j + i].getStartDate();
      DateTime now = DateTime.now();
      if (eventDate.year == now.year && eventDate.month == now.month) {
        if (Utils.isSameDate(eventDate, now)) {
          return j * itemHeight;

          // Find the next event
        } else if (eventDate.isAfter(now)) {
          return j * itemHeight;
        }
      } else {
        return 0;
      }
    }
    return 0;
  }
}
