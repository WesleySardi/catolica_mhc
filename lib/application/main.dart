import 'package:catolica_mhc/application/config.dart';
import 'package:catolica_mhc/pages_default/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'checkAuth.dart';

void main() async {
  await initConfiguration();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Alata'
    ),
    home: CheckAuth(),
  ));
}