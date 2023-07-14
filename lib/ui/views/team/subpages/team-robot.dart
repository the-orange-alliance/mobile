import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../internationalization/localizations.dart';
import '../../../../models/media.dart';
import '../../../../providers/api.dart';
import '../../../../providers/static-data.dart';
import '../../../widgets/no-data-widget.dart';

class TeamRobot extends StatelessWidget {

  TeamRobot(this.teamKey);

  final String? teamKey;
  List<Media>? data;
  TOALocalizations? local;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);
    theme = Theme.of(context);

    if (data == null) {
      return FutureBuilder<List<Media>?>(
        future: ApiV3().getTeamMedia(teamKey, StaticData.seasonKey),

        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<Media>?> media) {
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
      List<Widget> buttons = [];
      List<Widget> images = [];
      List<Widget> widgets = [];
      bool openSource = false;

      for (int i = 0; i < data!.length; i++) {
        Media media = data![i];

        switch(media.mediaType) {
          case TeamMediaType.GITHUB: {
            openSource = true;
            buttons.add(OutlinedButton.icon(
                icon: Icon(MdiIcons.github, size: 18),
                label: Text('GitHub'),
                onPressed: () {
                  openLink(media.mediaLink!, context);
                }
            ));
            break;
          }

          case TeamMediaType.CAD: {
            openSource = true;
            buttons.add(OutlinedButton.icon(
                icon: Icon(MdiIcons.drawing, size: 18),
                label: Text('CAD Design'),
                onPressed: () {
                  openLink(media.mediaLink!, context);
                }
            ));
            break;
          }

          case TeamMediaType.NOTEBOOK: {
            buttons.add(OutlinedButton.icon(
                icon: Icon(MdiIcons.book, size: 18),
                label: Text(local!.get('pages.team.robot_profile.engineering_notebook')),
                onPressed: () {
                  openLink(media.mediaLink!, context);
                }
            ));
            break;
          }

          case TeamMediaType.ROBOT_REVEAL: {
            buttons.add(OutlinedButton.icon(
                icon: Icon(MdiIcons.youtube, size: 18),
                label: Text(local!.get('pages.team.robot_profile.robot_reveal')),
                onPressed: () {
                  openLink(media.mediaLink!, context);
                }
            ));
            break;
          }

          case TeamMediaType.ROBOT_IMAGE: {
            images.add(Padding(
              padding: EdgeInsets.all(4),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: GestureDetector(
                    child: Hero(
                      tag: media.mediaKey!,
                      child: FadeInImage.assetNetwork(
                        image: media.mediaLink!,
                        placeholder: 'assets/images/loading.gif'
                      )
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(title: Text('#$teamKey\'s Robot')),
                          body: SizedBox.expand(
                            child: Hero(
                              tag: media.mediaKey!,
                              child: FadeInImage.assetNetwork(
                                image: media.mediaLink!,
                                placeholder: 'assets/images/loading.gif',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        );
                      }));
                    }
                  )
                )
            ));
            break;
          }
        }
      }

      if (buttons.length > 0 || images.length > 0) {
        if (buttons.length > 0) {
          if (openSource) {
            widgets.add(buildTitle(local!.get('pages.team.robot_profile.open_source')));
          }
          widgets.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: buttons
            ),
          ));
        }

        if (images.length > 0) {
          widgets.add(buildTitle(local!.get('pages.team.robot_profile.photos')));
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
        return NoDataWidget(MdiIcons.robot, local!.get('no_data.robot_profile'));
      }
    } else {
      return Center(
          child: CircularProgressIndicator()
      );
    }
  }

  void openLink(String url, BuildContext context) async {
    final uri = Uri.dataFromString(url);
    if (await canLaunchUrl (uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('general.error_occurred')
      ));
    }
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 35, bottom: 8, right: 16),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: theme.primaryTextTheme.headline6!.color),
      ),
    );
  }
}