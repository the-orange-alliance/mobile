import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/Sort.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/models/EventParticipant.dart';
import 'package:toa_flutter/ui/widgets/TeamListItem.dart';
import 'package:toa_flutter/ui/widgets/NoDataWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/internationalization/Localizations.dart';

class EventTeams extends StatelessWidget {

  EventTeams(this.event);

  Event event;
  List<EventParticipant> data;
  TOALocalizations local;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

    if (data == null) {
      return FutureBuilder<List<EventParticipant>>(
        future: ApiV3().getEventTeams(event.eventKey),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<EventParticipant>> teams) {
          if (teams.data != null) {
            data = teams.data;
            data.sort(Sort().eventParticipantSorter);

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
            return TeamListItem(data[index].team);
          }
        );
      } else {
        return NoDataWidget(MdiIcons.accountGroupOutline, local.get('no_data.teams'));
      }
    } else {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  }
}