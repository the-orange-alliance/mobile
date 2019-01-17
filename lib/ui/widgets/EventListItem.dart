import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/ui/views/event/EventPage.dart';

class EventListItem extends StatelessWidget {

  EventListItem(this.event, {this.showDate = true});
  final Event event;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) {
              return EventPage(event);
            }
          )
        );
      },
      child: ListTile(
        title: Text(event.getFullName(), overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(showDate ? event.getSubtitle(context) : event.getShortLocation(), overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w500))
      )
    );
  }
}
