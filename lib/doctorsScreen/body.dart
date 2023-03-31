import 'package:flutter/material.dart';
import 'package:telemedicine_system/colors.dart';
import 'package:telemedicine_system/consultationFormatScreen/consultationFormatScreen.dart';

import '../apis/api.dart';
import '../bookSlotScreen/bookSlotScreen.dart';
import '../components.dart';
import '../dataClass/dataClass.dart';

class body extends StatefulWidget {
  final List<List<doctorProfile>> data;
  final int tab;

  const body({Key? key, required this.data, required this.tab}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    String assetURL = "http://192.168.1.170:5024/";

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ListTile(
              leading: components().backButton(context),
              trailing:
                  Image(image: AssetImage("assets/images/logo_symbol.png")),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTabController(
                    length: 2,
                    initialIndex: widget.tab,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 10),
                          margin:
                              EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: colors().logo_lightBlue),
                          child: TabBar(
                            labelPadding: EdgeInsets.only(top: 10, bottom: 10),
                            indicator: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            onTap: (value) {},
                            tabs: [
                              components().text(
                                  "Online", FontWeight.bold, Colors.black, 22),
                              components().text(
                                  "Visit", FontWeight.bold, Colors.black, 22),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, bottom: 10, top: 10),
                          child: components().text("Let's find your Doctor",
                              FontWeight.bold, Colors.black, 24),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: widget.data[0].length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 15,
                                            right: 15),
                                        margin: EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 10,
                                            right: 10),
                                        decoration: BoxDecoration(
                                            color: Color(0xfff6f6f4),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.13,
                                                  margin: EdgeInsets.only(
                                                      right: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Image(
                                                      image: NetworkImage(api()
                                                              .uri +
                                                          widget.data[0][index]
                                                              .image)),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    components().text(
                                                        widget.data[0][index]
                                                            .name,
                                                        FontWeight.w500,
                                                        Colors.black,
                                                        20),
                                                    components().text(
                                                        widget.data[0][index]
                                                            .degree,
                                                        FontWeight.normal,
                                                        Colors.black,
                                                        20),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    InkWell(
                                                      child: components().text(
                                                          "ViewDetails",
                                                          FontWeight.normal,
                                                          Colors.blue,
                                                          16),
                                                      onTap: () {},
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        )),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            consultationFormatScreen(
                                                data: widget.data[0][index]),
                                      ));
                                    },
                                  );
                                },
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: widget.data[1].length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 15,
                                            right: 15),
                                        margin: EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 10,
                                            right: 10),
                                        decoration: BoxDecoration(
                                            color: Color(0xfff6f6f4),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.13,
                                                  margin: EdgeInsets.only(
                                                      right: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Image(
                                                      image: NetworkImage(api()
                                                              .uri +
                                                          widget.data[1][index]
                                                              .image)),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    components().text(
                                                        widget.data[1][index]
                                                            .name,
                                                        FontWeight.w500,
                                                        Colors.black,
                                                        20),
                                                    components().text(
                                                        widget.data[1][index]
                                                            .degree,
                                                        FontWeight.normal,
                                                        Colors.black,
                                                        20),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    InkWell(
                                                      child: components().text(
                                                          "ViewDetails",
                                                          FontWeight.normal,
                                                          Colors.blue,
                                                          16),
                                                      onTap: () {},
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        )),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => bookSlotScreen(
                                            data: widget.data[1][index],
                                            format: "visit"),
                                      ));
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
