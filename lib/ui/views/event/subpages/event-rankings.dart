import 'package:flutter/material.dart';
import 'package:toa_flutter/models/event.dart';
import 'package:toa_flutter/models/ranking.dart';
import 'package:toa_flutter/sort.dart';
import 'package:toa_flutter/providers/api.dart';
import 'package:toa_flutter/ui/widgets/ranking-list-item.dart';
import 'package:toa_flutter/ui/widgets/no-data-widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/internationalization/localizations.dart';

class EventRankings extends StatelessWidget {

  EventRankings(this.event);

  final Event event;
  List<Ranking> data;
  TOALocalizations local;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

    if (data == null) {
      return FutureBuilder<List<Ranking>>(
        future: ApiV3().getEventRankings(event.eventKey),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<Ranking>> rankings) {
          if (rankings.data != null) {
            data = rankings.data;
            data.sort(Sort().rankingSorter);
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
            return RankingListItem(data[index]);
          }
        );
      } else {
        return NoDataWidget(MdiIcons.podium, local.get('no_data.rankings'));
      }
    } else {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  }
}