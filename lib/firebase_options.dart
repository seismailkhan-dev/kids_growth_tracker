import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

/// Default Firebase configuration options for this app.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  /// Android Firebase options
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdPSKIgrnXRBtsJP_4pRhCxLBAJ3mVLv0',
    appId: '1:844348427220:android:8d749c7e057ed6556b6441',
    messagingSenderId: '844348427220',
    projectId: 'famliyhealthtracker',
    storageBucket: 'famliyhealthtracker.firebasestorage.app',
  );

  /// iOS Firebase options
  /// ❌ Replace these values after creating an iOS app in Firebase Console
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCA8SSYYrtGyEJnxcDJDZNk9dng1HjYpS0',
    appId: '1:844348427220:ios:8dbf22ccaf8ce15c6b6441',
    messagingSenderId: '844348427220',
    projectId: 'famliyhealthtracker',
    storageBucket: 'famliyhealthtracker.firebasestorage.app',
    iosBundleId: 'com.ikappsstudio.familyhealthtracker',
  );
}