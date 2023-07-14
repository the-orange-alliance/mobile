import 'package:flutter/material.dart';
import 'package:toa_flutter/models/event.dart';
import 'package:toa_flutter/models/match.dart';
import 'package:toa_flutter/sort.dart';
import 'package:toa_flutter/providers/api.dart';
import 'package:toa_flutter/ui/widgets/match-list-item.dart';
import 'package:toa_flutter/ui/widgets/no-data-widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/internationalization/localizations.dart';

class EventMatches extends StatelessWidget {

  EventMatches(this.event);

  final Event? event;
  List<Match>? data;
  TOALocalizations? local;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

    if (data == null) {
      return FutureBuilder<List<Match>?>(
        future: ApiV3().getEventMatches(event!.eventKey),
        builder: (BuildContext context, AsyncSnapshot<List<Match>?> matches) {
          if (matches.data != null) {
            data = matches.data;
            data!.sort(Sort().matchSorter);
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
      if (data!.length > 0) {
        return ListView.separated(
          itemCount: data!.length,
          separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
          itemBuilder: (BuildContext context, int index) {
            return MatchListItem(data![index], event: event);
          }
        );
      } else {
        return NoDataWidget(MdiIcons.gamepadVariant, local!.get('no_data.matches'));
      }
    } else {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  }
}