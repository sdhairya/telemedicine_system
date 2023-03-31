import 'package:flutter/material.dart';

import '../dataClass/dataClass.dart';
import 'body.dart';

class consultationModeScreen extends StatelessWidget {

  final String category;
  final doctorProfile data;

  const consultationModeScreen({Key? key, required this.category, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(category: category,data: data,);
  }
}
