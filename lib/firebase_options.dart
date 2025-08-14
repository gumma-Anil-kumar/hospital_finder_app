// @dart=2.12
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCozkUWsoMO1UaQBSeOsFyk7n5tQGASWNU',
    appId: '1:164773803652:web:your-web-app-id',
    messagingSenderId: '164773803652',
    projectId: 'smart-hospital-finder-47a07',
    authDomain: 'smart-hospital-finder-47a07.firebaseapp.com',
    storageBucket: 'smart-hospital-finder-47a07.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCozkUWsoMO1UaQBSeOsFyk7n5tQGASWNU',
    appId: '1:164773803652:android:d87c33781442a155ceb4d1',
    messagingSenderId: '164773803652',
    projectId: 'smart-hospital-finder-47a07',
    storageBucket: 'smart-hospital-finder-47a07.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCozkUWsoMO1UaQBSeOsFyk7n5tQGASWNU',
    appId: '1:164773803652:ios:your-ios-app-id',
    messagingSenderId: '164773803652',
    projectId: 'smart-hospital-finder-47a07',
    storageBucket: 'smart-hospital-finder-47a07.appspot.com',
    iosBundleId: 'com.example.hospitalFinder',
  );
}