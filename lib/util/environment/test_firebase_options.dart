// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
class TestFirebaseOptions {
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
    apiKey: 'AIzaSyBD6UVTl8WJ5ohaXO520ZtNb8HXr2Tumc0',
    appId: '1:184474353635:web:14aa77a81e8a9422a82ad6',
    messagingSenderId: '184474353635',
    projectId: 'noted-app-test',
    authDomain: 'noted-app-test.firebaseapp.com',
    storageBucket: 'noted-app-test.appspot.com',
    measurementId: 'G-2Q9XNQB773',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9wEeZQ6jJV1bwOc5i6_d0TVKOdUTQ7Pg',
    appId: '1:184474353635:android:fa731582671c4277a82ad6',
    messagingSenderId: '184474353635',
    projectId: 'noted-app-test',
    storageBucket: 'noted-app-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQQBuQ37K7RwPADJyE6TLdYtYfsl9WbgU',
    appId: '1:184474353635:ios:059b49a48c332e3da82ad6',
    messagingSenderId: '184474353635',
    projectId: 'noted-app-test',
    storageBucket: 'noted-app-test.appspot.com',
    iosClientId: '184474353635-i61nc15i69t27bgm9g1kc0hs1d1pvaus.apps.googleusercontent.com',
    iosBundleId: 'com.noted.notedApp',
  );
}
