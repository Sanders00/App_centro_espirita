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
    apiKey: 'AIzaSyA1LGDP7cabUrnLm_j344eMjr769xuMDgA',
    appId: '1:1083340880393:web:abe6083b38f75c33fc96d8',
    messagingSenderId: '1083340880393',
    projectId: 'appcepac-dnv',
    authDomain: 'appcepac-dnv.firebaseapp.com',
    storageBucket: 'appcepac-dnv.appspot.com',
    measurementId: 'G-NXS2XVJ2F6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAB12wBghRLGddSUgRq_WylCEnvJv4GXfk',
    appId: '1:1083340880393:android:3f3f7cf287b1f3d6fc96d8',
    messagingSenderId: '1083340880393',
    projectId: 'appcepac-dnv',
    storageBucket: 'appcepac-dnv.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAg8P-Y-DZoyGFjVl7EGhfiaapKh18uq80',
    appId: '1:1083340880393:ios:2396129c41f834eefc96d8',
    messagingSenderId: '1083340880393',
    projectId: 'appcepac-dnv',
    storageBucket: 'appcepac-dnv.appspot.com',
    iosClientId: '1083340880393-em7lbv14ro1s6jk0rkch9rgi6pjmcr49.apps.googleusercontent.com',
    iosBundleId: 'com.example.appCentroEspirita',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAg8P-Y-DZoyGFjVl7EGhfiaapKh18uq80',
    appId: '1:1083340880393:ios:45950ba40fde273bfc96d8',
    messagingSenderId: '1083340880393',
    projectId: 'appcepac-dnv',
    storageBucket: 'appcepac-dnv.appspot.com',
    iosClientId: '1083340880393-5tngmq2mkr0lu0vpae70gunq33o5r2tv.apps.googleusercontent.com',
    iosBundleId: 'com.example.appCentroEspirita.RunnerTests',
  );
}
