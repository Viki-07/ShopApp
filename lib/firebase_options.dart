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
    apiKey: 'AIzaSyCc9qlCq3jAlJxQ277q75Qr0-H79GFcNs0',
    appId: '1:623139143710:web:2dec65df54ac8137e72e0f',
    messagingSenderId: '623139143710',
    projectId: 'ecommerce-app-aa110',
    authDomain: 'ecommerce-app-aa110.firebaseapp.com',
    storageBucket: 'ecommerce-app-aa110.appspot.com',
    measurementId: 'G-5EM1H5XNB1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdJ-RKhLlPSNIdnosasLQkZcycMFPxd34',
    appId: '1:623139143710:android:d4af7a246698fd61e72e0f',
    messagingSenderId: '623139143710',
    projectId: 'ecommerce-app-aa110',
    storageBucket: 'ecommerce-app-aa110.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvqz0NFTkSCeVpdcfUaglClX4Sr0MrjSM',
    appId: '1:623139143710:ios:ed129e5c78051a91e72e0f',
    messagingSenderId: '623139143710',
    projectId: 'ecommerce-app-aa110',
    storageBucket: 'ecommerce-app-aa110.appspot.com',
    iosBundleId: 'com.example.shopExample',
  );
}
