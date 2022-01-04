import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication localAuth = LocalAuthentication();
  bool isAuthenticated = false;
  String isSupported = 'tidak support';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsDeviceSupported();
  }

  checkIsDeviceSupported() async {
    isSupported =
        await localAuth.isDeviceSupported() ? 'support' : 'tidak support';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSupported,
            ),
            isAuthenticated
                ? Text(
                    'Pesan Rahasia',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final bool result = await localAuth.authenticate(
                  localizedReason: 'Untuk menampilkan pesan rahasia',
                  // kalo mau pake biometric aja (fingerprint / face id)
                  biometricOnly: true,
                );

                setState(() {
                  isAuthenticated = result;
                });

                print(result);
              },
              child: Text(
                'Biometric Auth',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
