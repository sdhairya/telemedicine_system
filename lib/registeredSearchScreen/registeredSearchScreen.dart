import 'package:flutter/material.dart';

import '../apis/api.dart';
import 'body.dart';

class registeredSearchScreen extends StatelessWidget {
  const registeredSearchScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    // return body(hospitals: []);
    return FutureBuilder(
      future: api().getDoctorCategories(),
      builder: (context, snapshot) {
        // print(snapshot.data);
        if(snapshot.hasData){
          return body(categories: snapshot.data!,);
        }
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: CircularProgressIndicator(backgroundColor: Colors.black,),
          ),
        );

      },
    );
  }


}

