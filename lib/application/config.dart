import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

initConfiguration() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp();



  // GetX Bindings
  Get.lazyPut<AuthService>(() => AuthService());
}
