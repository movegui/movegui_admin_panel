import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:movegui_admin_panel/config/env.dart';
import 'package:movegui_admin_panel/config/environment.dart';

class FirebaseConfig {
  static Future<void> init(Env env) async {
    if (env.currentEnv == AppEnv.dev || Environment.isDev) {
      _connectToEmulators();
    }
  }

  // Auth is deliberately NOT emulated: the admin panel shares the production
  // Firebase Auth users with the movegui client app.
  static void _connectToEmulators() {
    final host = kIsWeb ? '127.0.0.1' : '10.0.2.2';

    FirebaseFirestore.instance.useFirestoreEmulator(host, 8086);
    // ⚡ Functions
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
    //  Storage
    FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }
}
