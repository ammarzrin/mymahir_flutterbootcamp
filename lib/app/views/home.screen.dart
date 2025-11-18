import 'package:flutter/material.dart';
import 'package:myflutter_nov2025/app/views/layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  // Controllers for text fields
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  int total = 0;

  void calculate(String operation) {
    setState(() {
      if (num1Controller.text.isNotEmpty && num1Controller.text.isNotEmpty) {
        int num1 = int.parse(num1Controller.text);
        int num2 = int.parse(num2Controller.text);

        if (operation == '+') {
          total = num1 + num2;
        } else {
          total = num1 - num2;
        }
      }
    });
  }

  void clear() {
    setState(() {
      num1Controller.clear();
      num2Controller.clear();
      total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // backgroundColor: Colors.amber,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LayoutDemo()),
              );
            },
            child: Text("Layout Demo", style: TextStyle(color: Colors.white)),
          ),
        ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    calculate('+');
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    calculate('-');
                  },
                  icon: Icon(
                    Icons.remove,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  clear();
                },
                child: Text("CLEAR", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
