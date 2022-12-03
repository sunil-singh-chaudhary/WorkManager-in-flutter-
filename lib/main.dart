import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    print("Task Exceution" + taskName);
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () {
                Workmanager().registerOneOffTask(
                  "FirsteverTask",
                  "backUp",
                  initialDelay: const Duration(seconds: 5),
                );
              },
              child: const Text("Start service")),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Workmanager().registerPeriodicTask(
                  "FirstPeriodicTask",
                  "backUp 2",
                  frequency: const Duration(minutes: 15),
                  initialDelay: const Duration(
                      seconds: 5), //start android in 15 minutes minimum
                );
              },
              child: const Text("Periodic Task")),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Workmanager().cancelByUniqueName("FirstPeriodicTask");
              },
              child: const Text("Start service")),
        ],
      ),
    );
  }
}
