import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Biometric Authentication'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isAuthenticated ? Text('Pesan rahasia') : SizedBox(),
              ElevatedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Authenticate'),
                    Icon(Icons.fingerprint),
                  ],
                ),
                onPressed: () async {
                  try {
                    final result =
                        await auth.authenticate(localizedReason: 'Reason');
                    print(result);
                    setState(() {
                      isAuthenticated = result;
                    });
                  } catch (e) {
                    setState(() {
                      isAuthenticated = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
