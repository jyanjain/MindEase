import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BluetoothConnection _connection;
  String _receivedData = '';

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  Future<void> _connectToDevice() async {
    String address = "00:23:02:35:08:22"; // Replace with your HC-05 MAC address
    try {
      _connection = await BluetoothConnection.toAddress(address);
      _connection.input!.listen((Uint8List data) {
        // Handle incoming data here
        setState(() {
          _receivedData = String.fromCharCodes(data);
        });
      });
    } catch (exception) {
      print('Failed to connect: $exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bluetooth Data Receiver"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Received Data:"),
              Text(_receivedData),
            ],
          ),
        ),
      ),
    );
  }
}
