import 'package:chefsysproject/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  //message hiih jishee
  final _firebaseMessaging = FirebaseMessaging.instance;

  //notification hiideg
  Future<void> initNotifications() async {
    //hereglegchees huselt ilgeeh zovshoorol
    await _firebaseMessaging.requestPermission();
    //hereglej bga device-d ogoh
    final fCMtoken = await _firebaseMessaging.getToken();
    //hevleh serverees
    print("Token: $fCMtoken");
    //irsen message haruulna app deer
    void handleMessage(RemoteMessage? message) {
      //message bhgui bol yuch hiihguie
      if (message == null) return;
      //hervee message irvel hereglegch daraad orj uzne
      navigatorKey.currentState?.pushNamed(
        '/notification_screen',
        arguments: message,
      );
    }
  }
  //function background settings
  Future initPushNotifications()async{
    
  }
}
