import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginScreen/loginScreen.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // kIsWeb ? Firebase.initializeApp() :

  await Firebase.initializeApp();
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



  @override
  void initState() {
    super.initState();

  }







  @override
  Widget build(BuildContext context) {
    return loginScreen();
  }
}
