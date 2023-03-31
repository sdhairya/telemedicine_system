import 'package:flutter/material.dart';
import 'package:telemedicine_system/profileScreen/body.dart';

class profileScreen extends StatelessWidget {

  final String id;
  final String? img;

  const profileScreen({Key? key, required this.id, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body(id: id,img: img,);
  }
}
