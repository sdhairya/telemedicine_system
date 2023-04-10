import 'package:flutter/material.dart';
import 'package:telemedicine_system/consultationFormatScreen/body.dart';
import 'package:telemedicine_system/dataClass/dataClass.dart';

class consultationFormatScreen extends StatelessWidget {

  final doctorProfile data;
  const consultationFormatScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(data: data);
  }
}
