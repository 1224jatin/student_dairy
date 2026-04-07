import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can re-run the FlutterFire CLI to generate but for now we only have android.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can re-run the FlutterFire CLI to generate but for now we only have android.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can re-run the FlutterFire CLI to generate but for now we only have android.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can re-run the FlutterFire CLI to generate but for now we only have android.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can re-run the FlutterFire CLI to generate but for now we only have android.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5fHW2rn4SiGzxbfdRk_fG_hrppa9AePE',
    appId: '1:216709569275:android:929df0d25bed218da86e5e',
    messagingSenderId: '216709569275',
    projectId: 'studentapp-6298d',
    storageBucket: 'studentapp-6298d.firebasestorage.app',
  );
}
