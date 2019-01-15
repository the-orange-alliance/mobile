import 'package:flutter/material.dart';
import 'package:toa_flutter/providers/StaticData.dart';
import 'package:toa_flutter/Utils.dart';
import 'package:toa_flutter/models/Media.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/ui/widgets/NoDataWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamRobot extends StatelessWidget {

  TeamRobot(this.teamKey);
  final String teamKey;

  List<Media> data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return FutureBuilder<List<Media>>(
        future: ApiV3().getTeamMedia(teamKey, StaticData().sessonKey),
        
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<Media>> media) {
          if (media.data != null) {
            data = media.data;
          }
          return bulidPage(context);
        }
      );
    } else {
      return bulidPage(context);
    }
  }

  Widget bulidPage(BuildContext context) {
    if (data != null) {
      if (data.length > 0) {
        List<Widget> buttons = [];
        List<Widget> images = [];
        List<Widget> widgets = [];

        for (int i = 0; i < data.length; i++) {
          Media media = data[i];

          switch(media.mediaType) {
            case MediaType.GITHUB: {
              buttons.add(OutlineButton.icon(
                icon: Icon(MdiIcons.githubCircle, size: 18),
                label: Text('GitHub'),
                onPressed: () {
                  openLink(media.mediaLink, context);
                }
              ));
              break;
            }

            case MediaType.CAD: {
              buttons.add(OutlineButton.icon(
                icon: Icon(MdiIcons.drawing, size: 18),
                label: Text('CAD Design'),
                onPressed: () {
                  openLink(media.mediaLink, context);
                }
              ));
              break;
            }

            case MediaType.NOTEBOOK: {
              buttons.add(OutlineButton.icon(
                icon: Icon(MdiIcons.book, size: 18),
                label: Text('Engineering Notebook'),
                onPressed: () {
                  openLink(media.mediaLink, context);
                }
              ));
              break;
            }

            case MediaType.ROBOT_REVEAL: {
              buttons.add(OutlineButton.icon(
                icon: Icon(MdiIcons.youtube, size: 18),
                label: Text('Robot Reveal'),
                onPressed: () {
                  openLink(media.mediaLink, context);
                }
              ));
              break;
            }

            case MediaType.ROBOT_IMAGE: {
              images.add(Padding(
                padding: EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.memoryNetwork(
                    image: media.mediaLink,
                    placeholder: Utils().kTransparentImage
                  )
                )
              ));
              break;
            }
          }
        }

        if (buttons.length > 0) {
          widgets.add(Padding(
            padding: EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: buttons
            ),
          ));
        }

        if (images.length > 0) {
          widgets.add(Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              children: images
            )
          ));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets
        );

      } else {
        return NoDataWidget(MdiIcons.googlePhotos, "No media found");
      }
    } else {
      return Center(
          child: CircularProgressIndicator()
      );
    }
  }

  void openLink(String url, BuildContext context) async {
    if (await canLaunch (url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("An error has occurred")
      ));
    }
  }
}