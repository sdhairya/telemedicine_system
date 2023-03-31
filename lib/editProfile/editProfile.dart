import 'package:flutter/material.dart';
import 'package:telemedicine_system/editProfile/body.dart';

import '../apis/api.dart';
import '../dataClass/dataClass.dart';

class editProfile extends StatefulWidget {

  final String id;
  const editProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {

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
              height: 100,
              width: 100,
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

