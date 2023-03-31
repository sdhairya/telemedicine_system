import 'package:flutter/material.dart';
import 'package:telemedicine_system/components.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/logo_white.png"),alignment: FractionalOffset(0.5, 0.65),scale: 1.1),
          gradient: LinearGradient(
            begin: Alignment(0, 0),
            end: Alignment(0,1),
            colors: [
              Color(0xff1f5c92),
              Color(0xff2c6db0),
              Color(0xff12b2d8)
            ]
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05,left: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 30),child: components().backButton(context),),
                    Wrap(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.005,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.005,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                )
                ,

                TextField(
                  keyboardType: TextInputType.text,
                  controller: _searchController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Color(0xffd7d7d7))),
                    filled: true,
                    fillColor: Color(0xfff6f4f4),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Search Diseases, Doctors, Hospitals",
                    prefixIcon: Icon(Icons.search,size: 30),
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}

