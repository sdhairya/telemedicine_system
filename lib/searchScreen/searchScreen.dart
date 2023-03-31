import 'package:flutter/material.dart';
import 'package:telemedicine_system/searchScreen/body.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  @override
  Widget build(BuildContext context) {
    return body();
  }
}
