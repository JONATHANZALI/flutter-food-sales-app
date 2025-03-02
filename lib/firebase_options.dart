// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDEQmgGGY6of0-YJ1o8aGg5qHsqRo-rjyo',
    appId: '1:81040565266:web:843b60697b627f468724cb',
    messagingSenderId: '81040565266',
    projectId: 'food-sales-app',
    authDomain: 'food-sales-app.firebaseapp.com',
    storageBucket: 'food-sales-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwqkpIGDTLON3YzZi0zKXoP1DCuGkc6rU',
    appId: '1:81040565266:android:d2818fafcb2c82e08724cb',
    messagingSenderId: '81040565266',
    projectId: 'food-sales-app',
    storageBucket: 'food-sales-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzmbGsOb-cVe5m5DN3DJicj8Ds3e5EEEM',
    appId: '1:81040565266:ios:50d85c30078108898724cb',
    messagingSenderId: '81040565266',
    projectId: 'food-sales-app',
    storageBucket: 'food-sales-app.firebasestorage.app',
    iosBundleId: 'com.example.foodApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCzmbGsOb-cVe5m5DN3DJicj8Ds3e5EEEM',
    appId: '1:81040565266:ios:50d85c30078108898724cb',
    messagingSenderId: '81040565266',
    projectId: 'food-sales-app',
    storageBucket: 'food-sales-app.firebasestorage.app',
    iosBundleId: 'com.example.foodApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDEQmgGGY6of0-YJ1o8aGg5qHsqRo-rjyo',
    appId: '1:81040565266:web:9b4ee4e7a88c62828724cb',
    messagingSenderId: '81040565266',
    projectId: 'food-sales-app',
    authDomain: 'food-sales-app.firebaseapp.com',
    storageBucket: 'food-sales-app.firebasestorage.app',
  );
}
