import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:toa_flutter/models/event.dart';

import '../../internationalization/localizations.dart';
import '../icon.dart';
import '../views/account/account-page.dart';
import '../views/account/login-page.dart';
import '../views/account/register-page.dart';

class ProfileBottomSheet {
  double radius = 20;

  showProfileBottomSheet(BuildContext context, PackageInfo packageInfo) {
    TOALocalizations local = TOALocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    var _tapPosition;

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
                  myTOATile(context),
                  GestureDetector(
                    onTapDown: (details) =>
                        _tapPosition = details.globalPosition,
                    child: ListTile(
                      leading: Icon(MdiIcons.themeLightDark),
                      title: Text(local.get(isDark
                          ? 'menu.switch_light_mode'
                          : 'menu.switch_dark_mode')),
                      onTap: () {
                        Navigator.pop(context);
                        EasyDynamicTheme.of(context).changeTheme(
                          dark: isDark ? false : true,
                          dynamic: false,
                        );
                      },
                      onLongPress: () {
                        final RenderBox overlay =
                            Overlay.of(context).context.findRenderObject();
                        showMenu(
                          context: context,
                          // its 2 am -k
                          // https://stackoverflow.com/questions/54300081/flutter-popupmenu-on-long-press
                          position: RelativeRect.fromRect(
                              _tapPosition &
                                  const Size(
                                      40, 40), // smaller rect, the touch area
                              Offset.zero &
                                  overlay.size // Bigger rect, the entire screen
                              ),
                          items: [
                            PopupMenuItem(
                              value: 0,
                              child: Text("Light Theme"),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Text("Dark Theme"),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("Auto"),
                            ),
                          ],
                        ).then((value) {
                          switch (value) {
                            case 0:
                              EasyDynamicTheme.of(context).changeTheme(
                                dark: false,
                                dynamic: false,
                              );
                              break;
                            case 1:
                              EasyDynamicTheme.of(context).changeTheme(
                                dark: true,
                                dynamic: false,
                              );
                              break;
                            case 2:
                              EasyDynamicTheme.of(context).changeTheme(
                                dynamic: true,
                              );
                              break;
                          }
                        });
                      },
                    ),
                  ),
                  AboutListTile(
                    icon: Icon(TOAIcons.TOA),
                    applicationVersion: packageInfo.version ?? '',
                    aboutBoxChildren: <Widget>[
                      Text(local.get('general.about_toa_short'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  myTOATile(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return ListTile(
        leading: Icon(MdiIcons.starOutline),
        title: Text('myTOA'),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) {
                return AccountPage();
              },
            ),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }

  buildProfileRow(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    User user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: (user.displayName?.length ?? -1) > 0 || user.photoURL != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL ?? ''),
                child: user.photoURL == null
                    ? Text(user.displayName.substring(0, 1))
                    : null,
                radius: 16,
              )
            : null,
        title: Text(user.displayName ?? 'TOA User'),
        subtitle: Text(user.email),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            return AccountPage();
          }));
        },
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Wrap(
          spacing: 12,
          runSpacing: 4,
          children: <Widget>[
            TextButton(
              child: Text(
                local.get('menu.login'),
                style: TextStyle(color: Color(0xFF0175c2)),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                  return LoginPage();
                }));
              },
            ),
            TextButton(
              child: Text(
                local.get('menu.register'),
                style: TextStyle(color: Color(0xFF0175c2)),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                  return RegisterPage();
                }));
              },
            )
          ],
        ),
      );
    }
  }
}
