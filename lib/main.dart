// import 'dart:js';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pbl/forecast.dart';
import 'package:pbl/location.dart';
import 'package:pbl/register.dart';
import 'location1.dart';
import 'login.dart';
import 'forgot.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => const MyLogin(),
        'register': (context) => const MyRegister(),
        'forgot': (context) => MyForgot(),
        'forecast': (context) => MyForecast(userLocation: ''),
        'location': (context) => const MyLocation(),
        'location1': (context) =>LocationInputScreen()
      }));
}
