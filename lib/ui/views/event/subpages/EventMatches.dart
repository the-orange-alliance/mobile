import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/Sort.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/ui/widgets/MatchListItem.dart';
import 'package:toa_flutter/ui/widgets/NoDataWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventMatches extends StatelessWidget {

  EventMatches(this.event);
  final Event event;

  List<Match> data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return FutureBuilder<List<Match>>(
        future: ApiV3().getEventMatches(event.eventKey),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<Match>> matches) {
          if (matches.data != null) {
            data = matches.data;
            data.sort(Sort().matchSorter);
          }
          return bulidPage();
        }
      );
    } else {
      return bulidPage();
    }
  }

  Widget bulidPage() {
    if (data != null) {
      if (data.length > 0) {
        return ListView.separated(
          itemCount: data.length,
          separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
          itemBuilder: (BuildContext context, int index) {
            return MatchListItem(data[index], event: event);
          }
        );
      } else {
        return NoDataWidget(MdiIcons.gamepadVariant, "No matches found");
      }
    } else {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  }
}