import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  static int? _number = 0;
  static int? _random = 0;
  static const platformChannel = MethodChannel('your_channel_name');

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    int? Function()? nativeDisplayNumber;
    int? Function()? nativeDisplayRandomNumber;

    if (Platform.isWindows) {
      final DynamicLibrary nativeLib = DynamicLibrary.open("platformTest.dll");

      nativeDisplayNumber = nativeLib
          .lookup<NativeFunction<Int32 Function()>>("displayNumber")
          .asFunction();
      nativeDisplayRandomNumber = nativeLib
          .lookup<NativeFunction<Int32 Function()>>("getRandom")
          .asFunction();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'And the number: $_number',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Random: $_random',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();

          setState(() {
            if (Platform.isAndroid) {
              _invokeNativeMethod();
            } else if (Platform.isWindows) {
              _number = nativeDisplayNumber!();
              _random = nativeDisplayRandomNumber!();
            }
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  static Future<void> _invokeNativeMethod() async {
    try {
      _random = await platformChannel.invokeMethod('getRandom');
      _number = await platformChannel.invokeMethod('displaySum');

      print('Result from native: $_random ----- $_number');
    } on PlatformException catch (e) {
      print("Failed to invoke native method:'${e.message}'.");
    }
  }
}
