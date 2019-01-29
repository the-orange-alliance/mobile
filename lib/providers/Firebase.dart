import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:toa_flutter/models/User.dart';

class Firebase {


  Future<String> getUID() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<bool> isFavEvent(String eventKey) async {
    String uid = await getUID();
    if (uid == null) {
      return false;
    }
    User userData = User.fromDataSnapshot(await FirebaseDatabase.instance.reference().child('Users').child(uid).once());
    return userData.getEvents().contains(eventKey);
  }

  setFavEvent(String eventKey, bool fav) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      if (fav) {
        FirebaseDatabase.instance.reference().child('Users/${user.uid}/favEvents').child(eventKey).set(true);
      } else {
        FirebaseDatabase.instance.reference().child('Users/${user.uid}/favEvents').child(eventKey).remove();
      }
    }
  }

  Future<bool> isFavTeam(String teamKey) async {
    String uid = await getUID();
    if (uid == null) {
      return false;
    }
    User userData = User.fromDataSnapshot(await FirebaseDatabase.instance.reference().child('Users').child(uid).once());
    return userData.getTeams().contains(teamKey);
  }

  setFavTeam(String teamKey, bool fav) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      if (fav) {
        FirebaseDatabase.instance.reference().child(
            'Users/${user.uid}/favTeams').child(teamKey).set(true);
      } else {
        FirebaseDatabase.instance.reference().child(
            'Users/${user.uid}/favTeams').child(teamKey).remove();
      }
    }
  }
}