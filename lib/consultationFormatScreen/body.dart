import 'package:flutter/material.dart';
import 'package:telemedicine_system/bookSlotScreen/bookSlotScreen.dart';
import 'package:telemedicine_system/colors.dart';
import 'package:telemedicine_system/doctorsScreen/doctorsScreen.dart';

import '../components.dart';
import '../dataClass/dataClass.dart';

class body extends StatefulWidget {

  final doctorProfile data;
  const body({Key? key, required this.data}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ListTile(
                  leading: components().backButton(context),
                  trailing: Image(image: AssetImage("assets/images/logo_symbol.png")),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      components().text("Choose\nConsultation\n Format",
                          FontWeight.bold, Colors.black, 32),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10, left: 15, right: 15),
                            margin: EdgeInsets.only(top: 5,bottom: 5, left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Color(0xfff6f6f4),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.height * 0.07,
                                      margin: EdgeInsets.only(right: 20),
                                      child: Image(image: AssetImage("assets/images/messageConsult.png")),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        components().text("Book", FontWeight.w500, Colors.black, 20),
                                        components().text("Message consult", FontWeight.w500, Colors.black, 20),
                                      ],
                                    ),
                                  ],
                                ),

                                Icon(Icons.arrow_forward_ios),
                              ],
                            )


                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => bookSlotScreen(data: widget.data, format: "message"),));
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10, left: 15, right: 15),
                            margin: EdgeInsets.only(top: 5,bottom: 5, left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Color(0xfff6f6f4),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, )]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.height * 0.07,
                                      margin: EdgeInsets.only(right: 20),
                                      child: Image(image: AssetImage("assets/images/videoConsult.png")),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        components().text("Book", FontWeight.w500, Colors.black, 20),
                                        components().text("Video consult", FontWeight.w500, Colors.black, 20),
                                      ],
                                    ),
                                  ],
                                ),

                                Icon(Icons.arrow_forward_ios),
                              ],
                            )


                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => bookSlotScreen(data: widget.data, format: "video"),));
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10, left: 15, right: 15),
                            margin: EdgeInsets.only(top: 5,bottom: 5, left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Color(0xfff6f6f4),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, )]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.height * 0.07,
                                      margin: EdgeInsets.only(right: 20),
                                      child: Image(image: AssetImage("assets/images/audioConsult.png")),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        components().text("Book", FontWeight.w500, Colors.black, 20),
                                        components().text("Audio consult", FontWeight.w500, Colors.black, 20),
                                      ],
                                    ),
                                  ],
                                ),

                                Icon(Icons.arrow_forward_ios),
                              ],
                            )


                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => bookSlotScreen(data: widget.data, format: "audio"),));
                        },
                      ),


                    ],
                  ),
                )

              ],
            ),
          )),
    );
  }
}
