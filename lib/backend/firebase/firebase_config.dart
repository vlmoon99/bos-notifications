import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC9JVZU-pTBdYZuX-FuVyrKVYVvLzrrP2s",
            authDomain: "bos-notifications-777.firebaseapp.com",
            projectId: "bos-notifications-777",
            storageBucket: "bos-notifications-777.appspot.com",
            messagingSenderId: "1098516707870",
            appId: "1:1098516707870:web:df27274b713f71162e8c0f",
            measurementId: "G-3LSP61LZWV"));
  } else {
    await Firebase.initializeApp();
  }
}
