import 'package:flutter/material.dart';
import 'package:toa_flutter/models/event.dart';
import 'package:toa_flutter/sort.dart';
import 'package:toa_flutter/providers/api.dart';
import 'package:toa_flutter/models/event-participant.dart';
import 'package:toa_flutter/ui/widgets/team-list-item.dart';
import 'package:toa_flutter/ui/widgets/no-data-widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/internationalization/localizations.dart';

class EventTeams extends StatelessWidget {

  EventTeams(this.event);

  Event? event;
  List<EventParticipant>? data;
  TOALocalizations? local;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

    if (data == null) {
      return FutureBuilder<List<EventParticipant>?>(
        future: ApiV3().getEventTeams(event!.eventKey),
        builder: (BuildContext context, AsyncSnapshot<List<EventParticipant>?> teams) {
          if (teams.data != null) {
            data = teams.data;
            data!.sort(Sort.eventParticipantSorter);

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
            return TeamListItem(data![index].team);
          }
        );
      } else {
        return NoDataWidget(MdiIcons.accountGroupOutline, local!.get('no_data.teams'));
      }
    } else {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  }
}