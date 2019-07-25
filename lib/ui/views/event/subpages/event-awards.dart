import 'package:flutter/material.dart';
import 'package:toa_flutter/models/event.dart';
import 'package:toa_flutter/models/award-recipient.dart';
import 'package:toa_flutter/sort.dart';
import 'package:toa_flutter/providers/api.dart';
import 'package:toa_flutter/ui/widgets/award-list-item.dart';
import 'package:toa_flutter/ui/widgets/no-data-widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/internationalization/localizations.dart';

class EventAwards extends StatelessWidget {

  EventAwards(this.event);

  final Event event;
  List<AwardRecipient> data;
  TOALocalizations local;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

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
        return NoDataWidget(MdiIcons.trophyOutline, local.get('no_data.awards'));
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
      return local.get('awards.inspire');

    } else if (key.startsWith("THK")) {
      return local.get('awards.think');

    } else if (key.startsWith("CNT")) {
      return local.get('awards.connect');

    } else if (key.startsWith("INV")) {
      return local.get('awards.innovate');

    } else if (key.startsWith("DSN")) {
      return local.get('awards.design');

    } else if (key.startsWith("MOT")) {
      return local.get('awards.motivate');

    } else if (key.startsWith("CTL")) {
      return local.get('awards.control');

    } else if (key.startsWith("PRM")) {
      return local.get('awards.promote');

    } else if (key.startsWith("CMP")) {
      return local.get('awards.compass');

    } else if (key.startsWith("JUD")) {
      return local.get('awards.judges');

    } else if (key.startsWith("WIN")) {
      return local.get('awards.winning_alliance');

    } else if (key.startsWith("FIN")) {
      return local.get('awards.finalist_alliance');

    } else {
      return awardRecipient.awardName;
    }
  }

}