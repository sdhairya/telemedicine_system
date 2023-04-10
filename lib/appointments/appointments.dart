import 'package:flutter/material.dart';
import 'package:telemedicine_system/appointments/body.dart';
import '../apis/api.dart';
import '../dataClass/dataClass.dart';

class appointments extends StatelessWidget {

  final String id;
  final profile patientProfile;
  const appointments({Key? key, required this.id, required this.patientProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api().getAppointments(id),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return body(data: snapshot.data!, patientProfile:  patientProfile,);
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
