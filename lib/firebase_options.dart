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
    apiKey: 'AIzaSyCwcDahkJGd4Lu2EoO8p3ks4TXXbFaOSpE',
    appId: '1:821029638582:web:88518b81eee1d60f74f117',
    messagingSenderId: '821029638582',
    projectId: 'socar-opensorce-team9',
    authDomain: 'socar-opensorce-team9.firebaseapp.com',
    storageBucket: 'socar-opensorce-team9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDi4CSfnVXbITrComrQ3vM2t8pMm_WePgk',
    appId: '1:821029638582:android:4a6bcd8299767b6b74f117',
    messagingSenderId: '821029638582',
    projectId: 'socar-opensorce-team9',
    storageBucket: 'socar-opensorce-team9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfEMhQzcYzsLhawPT7duq1drZSsdxId0A',
    appId: '1:821029638582:ios:36ca0f3c897b8c1574f117',
    messagingSenderId: '821029638582',
    projectId: 'socar-opensorce-team9',
    storageBucket: 'socar-opensorce-team9.appspot.com',
    iosBundleId: 'socar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfEMhQzcYzsLhawPT7duq1drZSsdxId0A',
    appId: '1:821029638582:ios:36ca0f3c897b8c1574f117',
    messagingSenderId: '821029638582',
    projectId: 'socar-opensorce-team9',
    storageBucket: 'socar-opensorce-team9.appspot.com',
    iosBundleId: 'socar',
  );
}
