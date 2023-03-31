import 'package:flutter/material.dart';
import 'package:telemedicine_system/colors.dart';
import 'package:telemedicine_system/consultationFormatScreen/consultationFormatScreen.dart';
import 'package:telemedicine_system/doctorsScreen/doctorsScreen.dart';

import '../bookSlotScreen/bookSlotScreen.dart';
import '../components.dart';
import '../dataClass/dataClass.dart';

class body extends StatefulWidget {

  final String category;
  final doctorProfile data;

  const body({Key? key, required this.category, required this.data}) : super(key: key);

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
                      components().text("Choose Format",
                          FontWeight.bold, Colors.black, 26),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xfff6f6f4),
                          border: Border.all(color: Color(0xffe1d7d7)),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          direction: Axis.vertical,
                          children: [
                            components().text("Online", FontWeight.bold, Colors.black, 24),
                            components().text("Consultation", FontWeight.bold, Colors.black, 24),
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors().logo_lightBlue,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.phone_android,size: 70, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.012,
                                    bottom: MediaQuery.of(context).size.height * 0.012,
                                    right: MediaQuery.of(context).size.width * 0.15,
                                    left: MediaQuery.of(context).size.width * 0.15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: colors().logo_lightBlue
                              ),
                              child: Wrap(
                                children: [
                                  components().text("Click Here", FontWeight.w500, Colors.white, 20),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white),
                                ],
                              ),
                              onPressed: () {
                                if(widget.data.name == "name"){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => doctorsScreen(category: widget.category, tab: 0),));

                                }
                                else{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => consultationFormatScreen(data: widget.data),));

                                }
                              },
                            )

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xfff6f6f4),
                            border: Border.all(color: Color(0xffe1d7d7)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          direction: Axis.vertical,
                          children: [
                            components().text("Visit", FontWeight.bold, Colors.black, 24),
                            components().text("a Doctor", FontWeight.bold, Colors.black, 24),
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors().logo_darkBlue,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Image(image: AssetImage("assets/images/stethoscope.png"),fit: BoxFit.fill, height: 60, width: 60,)
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.012,
                                      bottom: MediaQuery.of(context).size.height * 0.012,
                                      right: MediaQuery.of(context).size.width * 0.15,
                                      left: MediaQuery.of(context).size.width * 0.15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  backgroundColor: colors().logo_darkBlue
                              ),
                              child: Wrap(
                                children: [
                                  components().text("Click Here", FontWeight.w500, Colors.white, 20),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white),
                                ],
                              ),
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => doctorsScreen(category: widget.category,),));
                                if(widget.data.name == "name"){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => doctorsScreen(category: widget.category, tab: 1),));

                                }
                                else{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => bookSlotScreen(data: widget.data, format: "visit"),));

                                }
                              },
                            )

                          ],
                        ),
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
