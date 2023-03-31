import 'package:flutter/material.dart';
import 'package:telemedicine_system/signUpScreen/body1.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  @override
  Widget build(BuildContext context) {
    return body1();
  }
}
