import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import './cache.dart';
import '../models/event-settings.dart';
import '../models/user.dart';

class Cloud {
  static final String baseURL = 'https://functions.theorangealliance.org';

  static Future<bool> getNotificationsState() async {
    if (Platform.isAndroid) return true;
    TOAUser? user = await getUser();
    return user != null && user.level! >= 6; // Beta, Admins only.
  }

  static Future<TOAUser?> getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String token = await user.getIdToken();
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'data': 'basic'
      };
      Response res = await http.get(Uri.parse(baseURL + '/user'), headers: headers);
      return TOAUser.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<EventSettings?> getEventSettings(String? eventKey) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String token = await user.getIdToken();
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'data': eventKey!
      };
      Response res =
          await http.get(Uri.parse(baseURL + '/user/getEventSettings'), headers: headers);
      return EventSettings.fromResponse(res.body);
    } else {
      return null;
    }
  }

  static Future<bool> updateEventSettings(
      String? eventKey, EventSettings? eventSettings) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String token = await user.getIdToken();
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'data': eventKey!
      };
      Response res = await http.post(
        Uri.parse(baseURL + '/user/updateEventSettings'),
        headers: headers,
        body: jsonEncode(eventSettings!.toJson()),
      );
      return res.statusCode == 200;
    } else {
      return false;
    }
  }

  static Future<String?> getUID() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  static Future<bool> isFavTeam(String? teamKey) async {
    TOAUser? user = await getUser();
    return user != null ? user.favoriteTeams!.contains(teamKey) : false;
  }

  static setFavTeam(String? teamKey, bool fav) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String token = await user.getIdToken();
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
        'data': 'team',
      };
      Response res = await http.post(
        Uri.parse(baseURL + '/user/${fav ? 'addFavorite' : 'removeFavorite'}'),
        headers: headers,
        body: teamKey,
      );
      return res.statusCode == 200;
    } else {
      return false;
    }
  }

  static saveMessagingToken(String fcmToken, String deviceName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String token = await user.getIdToken();
      Map<String, String> headers = {
        'authorization': 'Bearer $token',
      };
      // TODO: Save the device name
      Response res = await http.post(
        Uri.parse(baseURL + '/user/saveMessagingToken'),
        headers: headers,
        body: fcmToken,
      );
      print(res.statusCode);
      return res.statusCode == 200;
    } else {
      return false;
    }
  }

  static initFirebaseMessaging() async {
    if (await getNotificationsState() == false) return;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission(
      sound: false, badge: true, alert: true
    ).then((NotificationSettings settings) {
      print('Settings registered: $settings');
    });

    String cacheKey = 'fcm-token';
    if (await Cache().getString(cacheKey) != null) return;
    if (await Cloud.getUID() == null) return; // no myTOA account

    // Generate token
    String token = (await firebaseMessaging.getToken())!;
    print('Push Messaging token: $token');

    // Find the device name
    String deviceName = 'Unknown device - Mobile App';
    try {
      if (Platform.isAndroid) {
        deviceName = (await deviceInfo.androidInfo).model + ' - Android App';
      } else if (Platform.isIOS) {
        deviceName = (await deviceInfo.iosInfo).utsname.machine + ' - iOS App';
      }
    } on PlatformException {}

    await saveMessagingToken(token, deviceName).then((ok) {
      if (ok) {
        Cache().setString(cacheKey, token);
      }
    });
  }
}
