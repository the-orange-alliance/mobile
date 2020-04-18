import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_modal/rounded_modal.dart';

import '../../internationalization/localizations.dart';
import '../icon.dart';
import '../views/account/account-page.dart';
import '../views/account/login-page.dart';
import '../views/account/register-page.dart';

class ProfileBottomSheet {

  String appVersion = "2.1.2";
  double radius = 20;

  showProfileBottomSheet(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showRoundedModalBottomSheet(
      context: context,
      radius: radius,
      color: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  buildProfileRow(context),
                  Divider(height: 0),
                  FutureBuilder(
                    future: FirebaseAuth.instance.currentUser(),
                    initialData: null,
                    builder: (BuildContext context, AsyncSnapshot<FirebaseUser> data) {
                      if (data.data != null) {
                        return ListTile(
                          leading: Icon(MdiIcons.starOutline),
                          title: Text('myTOA'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) {
                                  return AccountPage();
                                }
                              )
                            );
                          }
                        );
                      }
                      return SizedBox(); // Empty
                    }
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.themeLightDark),
                    title: Text(local.get(isDark ? 'menu.switch_light_mode' : 'menu.switch_dark_mode')),
                    onTap: () {
                      Navigator.pop(context);
                      DynamicTheme.of(context).setBrightness(isDark ? Brightness.light : Brightness.dark);
                    }
                  ),
                  AboutListTile(
                    icon: Icon(TOAIcons.TOA),
                    applicationVersion: appVersion,
                    aboutBoxChildren: <Widget>[
                      Text(local.get('general.about_toa_short'))
                    ]
                  )
                ]
              )
            )
          )
        );
      }
    );
  }

  buildProfileRow(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);

    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      initialData: -1,
      builder: (BuildContext context, AsyncSnapshot<dynamic> data) {
        if (data.data == null) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Wrap(
              spacing: 12,
              runSpacing: 4,
              children: <Widget>[
                FlatButton(
                  child: Text(local.get('menu.login')),
                  textColor: Color(0xFF0175c2),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return LoginPage();
                        }
                      )
                    );
                  }
                ),
                FlatButton(
                  child: Text(local.get('menu.register')),
                  textColor: Color(0xFF0175c2),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return RegisterPage();
                        }
                      )
                    );
                  }
                )
              ]
            )
          );
        } else if (data.data == -1) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(local.get('general.loading'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
          );
        } else {
          FirebaseUser user = data.data;
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: (user.displayName?.length ?? -1) > 0 || user.photoUrl != null ? CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl ?? ''),
              child: user.photoUrl == null ? Text(user.displayName.substring(0, 1)) : null,
              radius: 16,
            ) : null,
            title: Text(user.displayName ?? 'TOA User'),
            subtitle: Text(user.email),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) {
                    return AccountPage();
                  }
                )
              );
            }
          );
        }
      }
    );
  }
}
