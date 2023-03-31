import 'package:flutter/material.dart';
import 'package:telemedicine_system/bookSlotScreen/body.dart';

import '../dataClass/dataClass.dart';

class bookSlotScreen extends StatelessWidget {

  final doctorProfile data;
  final String format;
  const bookSlotScreen({Key? key, required this.data, required this.format}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(data: data, format: format,);
  }
}
