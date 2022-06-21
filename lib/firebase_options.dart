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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0CsKOk-GDGjR920lbGvhwPuv3ybsAPEU',
    appId: '1:565902882470:android:48f977d48add280154e667',
    messagingSenderId: '565902882470',
    projectId: 'flash-chat-m1',
    storageBucket: 'flash-chat-m1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0BpGE2CjliDzoNceTgoA6xRtE7OgBzH4',
    appId: '1:565902882470:ios:1c9dc42cb83ea7bc54e667',
    messagingSenderId: '565902882470',
    projectId: 'flash-chat-m1',
    storageBucket: 'flash-chat-m1.appspot.com',
    iosClientId: '565902882470-kklo48uqj65ergjml8s84u7nvd0c1uns.apps.googleusercontent.com',
    iosBundleId: 'com.example.flashChat',
  );
}