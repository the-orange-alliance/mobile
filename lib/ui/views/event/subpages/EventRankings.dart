import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/models/Ranking.dart';
import 'package:toa_flutter/Sort.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/ui/widgets/RankingListItem.dart';
import 'package:toa_flutter/ui/widgets/NoDataWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventRankings extends StatelessWidget {

  EventRankings(this.event);
  final Event event;

  List<Ranking> data;

  @override
  Widget build(BuildContext context) {
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
        return NoDataWidget(MdiIcons.podium, "No rankings found");
      }
    } else {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  }
}