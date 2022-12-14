// File generated by FlutterFire CLI.
//ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// Default [FirebaseOptions] for use with your Firebase apps.
// Example:
//```dart
//import 'firebase_options.dart';
//// ...
//await Firebase.initializeApp(
//  options: DefaultFirebaseOptions.currentPlatform,
//);
//```
///
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
    apiKey: 'AIzaSyCXs3KM9jS1J4D4eLfDSOf5320-OKeWVIk',
    appId: '1:734081539306:web:134f4995a553d06beacb93',
    messagingSenderId: '734081539306',
    projectId: 'seacan-334fd',
    authDomain: 'seacan-334fd.firebaseapp.com',
    storageBucket: 'seacan-334fd.appspot.com',
    measurementId: 'G-0YTFJ9L4C6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDy1fvDEGMZgE8EDqGQX_86GN6vK48_Mug',
    appId: '1:734081539306:android:5efbaf307541f106eacb93',
    messagingSenderId: '734081539306',
    projectId: 'seacan-334fd',
    storageBucket: 'seacan-334fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiU73t5YWUFq7uAb9c-d7JeXvYkTl7dic',
    appId: '1:734081539306:ios:19ea1d1b1f94636deacb93',
    messagingSenderId: '734081539306',
    projectId: 'seacan-334fd',
    storageBucket: 'seacan-334fd.appspot.com',
    iosClientId:
        '734081539306-up0mhemp86phoshsc3mridn4df34b47l.apps.googleusercontent.com',
    iosBundleId: 'com.example.mlkitTextRecognitionV2App',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiU73t5YWUFq7uAb9c-d7JeXvYkTl7dic',
    appId: '1:734081539306:ios:19ea1d1b1f94636deacb93',
    messagingSenderId: '734081539306',
    projectId: 'seacan-334fd',
    storageBucket: 'seacan-334fd.appspot.com',
    iosClientId:
        '734081539306-up0mhemp86phoshsc3mridn4df34b47l.apps.googleusercontent.com',
    iosBundleId: 'com.example.mlkitTextRecognitionV2App',
  );
}
