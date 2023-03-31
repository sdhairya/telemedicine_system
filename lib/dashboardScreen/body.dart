import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_system/appointments/appointments.dart';
import 'package:telemedicine_system/components.dart';
import 'package:telemedicine_system/loginScreen/loginScreen.dart';
import 'package:telemedicine_system/profileScreen/profileScreen.dart';
import 'package:telemedicine_system/registeredSearchScreen/registeredSearchScreen.dart';
import 'package:http/http.dart' as http;

import '../apis/api.dart';
import '../colors.dart';
import '../dataClass/dataClass.dart';
import '../searchScreen/searchScreen.dart';
import '../videoCallScreen.dart';

class body extends StatefulWidget {
  //
  final String id;
  final List<profile> data;

  const body({Key? key, required this.id, required this.data}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/dashboard.png"),fit:BoxFit.fill)
          ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ListTile(
                  leading: ElevatedButton(
                    child: Icon(Icons.search, size: 30, color: Color(0xff383434)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff6f6f4),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10)
                    ),
                    onPressed: () {

                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => searchScreen()));

                    },
                  ),
                  trailing: Wrap(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff6f6f4),
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10)
                        ),
                        child: Icon(Icons.logout,color: Color(0xff383434),size: 30),
                        onPressed: () {

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => loginScreen()));

                        },
                      ),
                      InkWell(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: MediaQuery.of(context).size.width * 0.13,
                          width: MediaQuery.of(context).size.width * 0.13,
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: colors().logo_darkBlue),
                              shape: BoxShape.circle,
                              color: Colors.white70),
                          child: CircleAvatar(
                              radius:
                              MediaQuery.of(context).size.width * 0.17,
                              child: widget.data[0].image!.isEmpty ?
                              Icon(Icons.person,color: Color(0xff383434),size: 30):
                              ClipOval(
                                  child: Image.network(
                                    api().uri + widget.data[0].image!,
                                    fit: BoxFit.fill,
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                  )),

                              )

                        ),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => profileScreen(id: widget.id,img: api().uri + widget.data[0].image!,)));
                        },
                      ),

                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       backgroundColor: Color(0xfff6f6f4),
                      //       shape: CircleBorder(),
                      //       padding: EdgeInsets.all(10)
                      //   ),
                      //   child:
                      //   onPressed: () {



                        // },
                      // )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/doctor4.png"),alignment: Alignment.topRight,)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            components().text("Welcome !\n"+widget.data[0].name, FontWeight.bold, Colors.black, 34),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            components().text("Have a nice day ☺", FontWeight.normal, Colors.black, 20),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffed2828),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15)
                              ),
                              child: Wrap(
                                children: [
                                  Image(image: AssetImage("assets/images/urgent_care.png")),
                                  SizedBox(width: 10,),
                                  components().text("Urgent Care", FontWeight.w500, Colors.white, 22)
                                ],
                              ),
                              onPressed: () async {
                                await api().getDoctorCategories();
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 30,left: 20,right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60)),
                            color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            components().text(" Our Services", FontWeight.bold, Colors.black, 22),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  buildServicesList("Consultation", "assets/images/consultation.png", registeredSearchScreen()),
                                  SizedBox(width: 30,),
                                  buildServicesList("Appointments", "assets/images/medicines.jpg", appointments(id: widget.id)),
                                  SizedBox(width: 30,),
                                  // buildServicesList("Medicines", "assets/images/medicines.jpg", callScreen(roomId: " ",role: "role", )),
                                  SizedBox(width: 30,),
                                  buildServicesList("Lab Test", "assets/images/labtest.png", Container())
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.028,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  components().text("My Appointments", FontWeight.bold, Colors.black, 22),
                                  buildAppointmentList()
                                ],
                              ),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          )
        ),
      )
    );
  }

  Widget buildServicesList(String label, String imagePath, Widget screen, ){

    return InkWell(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
            margin: EdgeInsets.only(top: 10,bottom: 5),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imagePath)),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.black45,width: 1)
            ),
          ),
          components().text(label, FontWeight.w400, Colors.black87, 18)
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen,));
      },
    );

  }

  Widget buildAppointmentList(){

    return Container(
          // height: MediaQuery.of(context).size.height * 0.2,
          margin: EdgeInsets.only(top: 10,bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              gradient: new LinearGradient(
                  stops: [0.02, 0.02],
                  colors: [Colors.blue, Color(0xfff6f6f4)]
              ),
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10,bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    components().text("Appointment Date", FontWeight.w400, Colors.grey, 16),
                    Icon(Icons.more_vert, size: 32, color: Colors.grey,),
                  ],
                ),
                Wrap(
                  children: [
                    Icon(Icons.access_time_outlined, size: 19,),
                    components().text("Time", FontWeight.normal, Colors.black, 16),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.18,
                          width: MediaQuery.of(context).size.width * 0.18,
                          margin: EdgeInsets.only(top: 10,bottom: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.18,
                          margin: EdgeInsets.only(left: 10),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              components().text("Doctor Name", FontWeight.bold, Colors.black, 16),
                              components().text("Doctor Degree", FontWeight.normal, Colors.grey, 16),
                            ],
                          ),
                        )
                      ],
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),
                    ElevatedButton(
                      child: components().text("Join", FontWeight.normal, Colors.white, 16),
                      onPressed: () {

                      },
                    ),
                  ],
                )
              ],
            ),
          ),






      ],
    ),
        );

  }

  
}
