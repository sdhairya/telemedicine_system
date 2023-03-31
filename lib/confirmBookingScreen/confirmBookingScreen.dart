import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemedicine_system/confirmBookingScreen/body.dart';

import '../apis/api.dart';
import '../dataClass/dataClass.dart';


class confirmBookingScreen extends StatefulWidget {

  final doctorProfile data;
  final appointmentData appointment_data;
  const confirmBookingScreen({Key? key, required this.data, required this.appointment_data}) : super(key: key);

  @override
  State<confirmBookingScreen> createState() => _confirmBookingScreenState();
}

class _confirmBookingScreenState extends State<confirmBookingScreen> {

  List<profile> data = [];

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: api().profiledetails(widget.appointment_data.patient_id),
      builder: (context, snapshot) {
        print(snapshot.data);
        if(snapshot.hasData){
          print(widget.appointment_data);

          return body(data: snapshot.data!, doctorData: widget.data, appointment_data: widget.appointment_data,);
        }
        else{

          return Scaffold(
            body: Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: Colors.black,),
            ),
          );
        }
      },
    );
    // return body(data: data,);

  }
}
