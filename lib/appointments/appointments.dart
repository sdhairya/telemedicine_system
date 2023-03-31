import 'package:flutter/material.dart';
import 'package:telemedicine_system/appointments/body.dart';
import '../apis/api.dart';

class appointments extends StatelessWidget {

  final String id;
  const appointments({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api().getAppointments(id),
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
