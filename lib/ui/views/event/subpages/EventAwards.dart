import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/models/AwardRecipient.dart';
import 'package:toa_flutter/Sort.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/ui/widgets/AwardListItem.dart';
import 'package:toa_flutter/ui/widgets/NoDataWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventAwards extends StatelessWidget {

  EventAwards(this.event);
  final Event event;

  List<AwardRecipient> data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return FutureBuilder<List<AwardRecipient>>(
        future: ApiV3().getEventAwards(event.eventKey),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<AwardRecipient>> awards) {
          if (awards.data != null) {
            data = awards.data;
            data.sort(Sort().awardParticipantSorter);
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
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            AwardListItem awardListItem = AwardListItem(data[index]);
            if (index == 0 || getHeader(data[index-1]) != getHeader(data[index])) {
              List<Widget> widget = [];
              if (index > 0) {
                widget.add(Divider(height: 0));
              }
              widget.add(
                Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(getHeader(data[index]))
                )
              );
              widget.add(awardListItem);

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget
              );
            } else {
              return awardListItem;
            }
          }
        );
      } else {
        return NoDataWidget(MdiIcons.trophyOutline, "No awards found");
      }
    } else {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  }

  String getHeader(AwardRecipient awardRecipient) {
    String key = awardRecipient.awardKey;
    if (key.startsWith("INS")) {
      return "Inspire Award";
    } else if (key.startsWith("THK")) {
      return "Think Award";
    } else if (key.startsWith("CNT")) {
      return "Connect Award";
    } else if (key.startsWith("INV")) {
      return "Rockwell Collins Innovate Award";
    } else if (key.startsWith("DSN")) {
      return "Design Award";
    } else if (key.startsWith("MOT")) {
      return "Motivate Award";
    } else if (key.startsWith("CTL")) {
      return "Control Award";
    } else if (key.startsWith("PRM")) {
      return "Promote Award";
    } else if (key.startsWith("CMP")) {
      return "Compass Award";
    } else if (key.startsWith("JUD")) {
      return "Judges Award";
    } else if (key.startsWith("WIN")) {
      return "Winning Alliance Award";
    } else if (key.startsWith("FIN")) {
      return "Finalist Alliance Award";
    } else {
      return awardRecipient.awardName;
    }
  }

}