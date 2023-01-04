import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Navigation Basics',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController frontController = TextEditingController();
  TextEditingController backController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:  Center(
              child: TextField(
                controller: frontController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Front",
                    labelStyle: TextStyle(fontSize: 18)),
              ),
            ),
          ),
           Center(
            child: TextField(
              controller: backController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Back",
                  labelStyle: TextStyle(fontSize: 18)),
            ),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                child: Text('Second Route'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute(front: frontController.text, back: backController.text,)),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  late final  String front;
  late final String back;
  SecondRoute({super.key, required this.back,required this.front});
  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Column(
        children: [
          Text(widget.front),
          Text(widget.back),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ),
        ],
      ),
    );
  }
}
