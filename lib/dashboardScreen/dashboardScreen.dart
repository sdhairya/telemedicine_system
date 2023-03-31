import 'package:flutter/material.dart';
import 'package:telemedicine_system/apis/api.dart';
import 'package:telemedicine_system/dashboardScreen/body.dart';

import '../dataClass/dataClass.dart';

class dashboardScreen extends StatefulWidget {

  final String id;

  const dashboardScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {

  List<profile> data = [];
  loadData(){
    api().profiledetails(widget.id).then((value){
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if(data.isEmpty){
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: Colors.black,),
            ),
          );
        }
        else{
          return body(data: data,id: widget.id);
        }
      },
    );
    // return body(data: data,);

  }
}
