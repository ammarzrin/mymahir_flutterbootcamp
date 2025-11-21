import 'package:flutter/material.dart';
import 'package:myflutter_nov2025/app/app.dart';
import 'package:myflutter_nov2025/app/services/sharedprefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const MyApp());
}
