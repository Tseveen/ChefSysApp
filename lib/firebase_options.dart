// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDap7aEpsZh5A_40XoELHi_Bp1WzHGw_0A',
    appId: '1:39338144910:web:912b7732cc2d19071445df',
    messagingSenderId: '39338144910',
    projectId: 'chefsys-app',
    authDomain: 'chefsys-app.firebaseapp.com',
    storageBucket: 'chefsys-app.appspot.com',
    measurementId: 'G-R6JJ8JV5LH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAo2DdQzX-I2V-UJef6Y_NJcfNV7BBgj3s',
    appId: '1:39338144910:android:f5da7b972c37b1c71445df',
    messagingSenderId: '39338144910',
    projectId: 'chefsys-app',
    storageBucket: 'chefsys-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAlhw9qg1mGYtqye5fQ8sfnw3_mdDFMNI',
    appId: '1:39338144910:ios:e1d4592db68a2ffc1445df',
    messagingSenderId: '39338144910',
    projectId: 'chefsys-app',
    storageBucket: 'chefsys-app.appspot.com',
    iosBundleId: 'com.example.chefsysApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDAlhw9qg1mGYtqye5fQ8sfnw3_mdDFMNI',
    appId: '1:39338144910:ios:2cd8975408aab2fa1445df',
    messagingSenderId: '39338144910',
    projectId: 'chefsys-app',
    storageBucket: 'chefsys-app.appspot.com',
    iosBundleId: 'com.example.chefsysApp.RunnerTests',
  );
}