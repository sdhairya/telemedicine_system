import 'package:flutter/material.dart';
import 'package:telemedicine_system/doctorsScreen/body.dart';

import '../apis/api.dart';
import '../dataClass/dataClass.dart';

class doctorsScreen extends StatelessWidget {

  final String category;
  final int tab;

  const doctorsScreen({Key? key, required this.category, required this.tab}) : super(key: key);

  Widget build(BuildContext context) {
    // return body(hospitals: []);
    return FutureBuilder(
      future: api().getDoctorsDegree(category),
      builder: (context, snapshot) {
        print(snapshot.data);
        if(snapshot.hasData){
          return body(data: snapshot.data!, tab: tab);
        }
        else{
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: Colors.black,),
            ),
          );
        }


      },
    );
  }
}
