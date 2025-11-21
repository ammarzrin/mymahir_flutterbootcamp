import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutter_nov2025/app/views/login.screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyMahir Flutter Bootcamp Nov 2025',
      theme: ThemeData(
        // colorScheme: .fromSeed(seedColor: Colors.red),
        colorScheme: .fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
