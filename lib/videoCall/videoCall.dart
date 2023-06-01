import 'package:flutter/material.dart';
import 'package:telemedicine_system/appointments/appointments.dart';
import 'package:telemedicine_system/colors.dart';
import 'package:telemedicine_system/components.dart';

import '../apis/api.dart';
import '../dataClass/dataClass.dart';
import '../videoCallScreen.dart';

class videoCall extends StatelessWidget {
  final String roomId;
  final String role;
  final appointment appointmentData;

  const videoCall({Key? key, required this.roomId, required this.role, required this.appointmentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api().patientAck(appointmentData.id.toString()),
      builder: (context, snapshot) {
        print(snapshot.data);
        if(snapshot.hasData){
          if(snapshot.data == "Doctor has not Joined yet!"){
            return Container(
              color: Colors.white,
              child: AlertDialog(
                title: components().text(snapshot.data!, FontWeight.w400, Colors.black, 16),
                actions: [
                  TextButton(
                    child: components().text("Ok", FontWeight.normal, colors().logo_darkBlue, 16),
                    onPressed: () {
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => appointments(),))
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          }
          else{
           return callScreen(roomId: roomId, role: role, appointmentData: appointmentData);
          }
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
