import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Training MyMahir',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Training Nov 2025'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controllers for text fields
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  int total = 0;

  void calculate() {
    setState(() {
      if (num1Controller.text.isNotEmpty && num1Controller.text.isNotEmpty) {
        int num1 = int.parse(num1Controller.text);
        int num2 = int.parse(num2Controller.text);
        total = num1 + num2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // backgroundColor: Colors.amber,
        title: Center(
          child: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Calculator App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: .bold,
                  // color: Colors.blue,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                controller: num1Controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter first number',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                controller: num2Controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter second number',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: Text("TOTAL: $total", style: TextStyle(fontSize: 20)),
            ),
            IconButton(
              onPressed: () {
                calculate();
              },
              icon: Icon(
                Icons.add,
                color: Colors.red,
                size: 40,
                // shadows: [
                //   Shadow(
                //     blurRadius: 5.0,
                //     color: Colors.grey,
                //     offset: Offset(2.0, 2.0),
                //   ),
                // ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
