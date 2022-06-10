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
    apiKey: 'AIzaSyAzGCNhPyKymIeshbczIxnAzd9lYCyuJsw',
    appId: '1:413475314991:web:21bcfab5a1e1fccb6595da',
    messagingSenderId: '413475314991',
    projectId: 'plata-app-d38e6',
    authDomain: 'plata-app-d38e6.firebaseapp.com',
    storageBucket: 'plata-app-d38e6.appspot.com',
    measurementId: 'G-DK0X91CJJL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVGnoyPQOGIMF_4GqunHUbqqcLlZvmNkk',
    appId: '1:413475314991:android:dd791710c668e4446595da',
    messagingSenderId: '413475314991',
    projectId: 'plata-app-d38e6',
    storageBucket: 'plata-app-d38e6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqV9j0NW728hgV8fN6SOSCPPj-6LNFOVs',
    appId: '1:413475314991:ios:5743aaccf507ca106595da',
    messagingSenderId: '413475314991',
    projectId: 'plata-app-d38e6',
    storageBucket: 'plata-app-d38e6.appspot.com',
    iosClientId: '413475314991-k49dlmru66s03uls3ike3r054vgeo2po.apps.googleusercontent.com',
    iosBundleId: 'com.example.silverHeart',
  );
}
