import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;

class CloudFirestoreUtility {

  final Firestore _db = Firestore.instance;
  final String _uid = 'pushnotificationapp-f3e69';
  final FirebaseMessaging firebaseMessaging;

  CloudFirestoreUtility(this.firebaseMessaging);

  saveTokenToDB(String county, String state) {
    if (Platform.isIOS) {
      firebaseMessaging.onIosSettingsRegistered.listen((data) {
        _saveDeviseToken(county, state);
      });

      firebaseMessaging
          .requestNotificationPermissions(const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true,
      ));

    } else if (Platform.isAndroid) {
      _saveDeviseToken(county, state);
    }
  }

  void _saveDeviseToken(String county, String state) async {


    String fcmToken = await firebaseMessaging.getToken();

    if (fcmToken != null) {
      var tokenReference = _db
          .collection('users')
          .document(_uid)
          .collection('tokens')
          .document(fcmToken);

      await tokenReference.setData({
        'token': fcmToken,
        'county' : '$county/$state'
      });
    }
  }
}