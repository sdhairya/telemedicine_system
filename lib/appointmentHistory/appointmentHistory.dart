import 'package:flutter/material.dart';
import 'package:telemedicine_system/apis/api.dart';
import 'package:telemedicine_system/appointmentHistory/body.dart';

class appointmentHistory extends StatelessWidget {

  final String id;
  const appointmentHistory({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api().getAppointmentsHistory(id),
      builder: (context, snapshot) {

        if(snapshot.hasData){
          return body(data: snapshot.data!,);
        }

        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
