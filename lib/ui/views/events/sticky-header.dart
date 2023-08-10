import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

import '../../../internationalization/localizations.dart';
import '../../../models/event.dart';
import '../../widgets/event-list-item.dart';

class StickyHeader {
  List<Widget> buildSideHeaderGrids(
      BuildContext context, int firstIndex, int count, List<Event>? events) {
    return List.generate(1, (sliverIndex) {
      sliverIndex += firstIndex;
      return SliverStickyHeader(
          overlapsContent: true,
          header: buildSideHeader(context, sliverIndex, events!),
          sliver: SliverPadding(
              padding: EdgeInsets.only(left: 60.0),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, i) => GestureDetector(
                  child: EventListItem(events[firstIndex + i], showDate: false),
                ),
                childCount: count,
              ))));
    });
  }

  Widget buildSideHeader(BuildContext context, int index, List<Event> events) {
    var date = DateTime.parse(events[index].startDate!);
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
                          child: Text(
                              DateFormat(
                                      "EEE",
                                      TOALocalizations.of(context)!
                                          .locale
                                          .toString())
                                  .format(date)
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 12),
                              textAlign: TextAlign.center)),
                      Text(date.day.toString(),
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.center)
                    ]))));
  }
}
