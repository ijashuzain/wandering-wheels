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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBR5ypw2seRHYD_NUlbj5xZr7G5tHVOR6s',
    appId: '1:118542655300:web:1872492326c1b5606dc111',
    messagingSenderId: '118542655300',
    projectId: 'wandering-wheels-884a8',
    authDomain: 'wandering-wheels-884a8.firebaseapp.com',
    storageBucket: 'wandering-wheels-884a8.appspot.com',
    measurementId: 'G-EPX8P0DS3J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1WP05YMNij5oeubQ40Gqq12OMEkr77YE',
    appId: '1:118542655300:android:1fbcc54ae87180a26dc111',
    messagingSenderId: '118542655300',
    projectId: 'wandering-wheels-884a8',
    storageBucket: 'wandering-wheels-884a8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUNOmXQoXOmAgXTjrPi_ZzGna-7TTYcys',
    appId: '1:118542655300:ios:027487a2f227382c6dc111',
    messagingSenderId: '118542655300',
    projectId: 'wandering-wheels-884a8',
    storageBucket: 'wandering-wheels-884a8.appspot.com',
    iosClientId: '118542655300-eggj3farn35vf89kq1kb85rr0bdch1v6.apps.googleusercontent.com',
    iosBundleId: 'com.example.wanderingWheels',
  );
}
