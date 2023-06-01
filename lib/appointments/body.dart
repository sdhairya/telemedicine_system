import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_system/apis/api.dart';
import 'package:telemedicine_system/videoCallScreen.dart';

import '../audioCall/audioCall.dart';
import '../audioCall/audioCallScreen.dart';
import '../colors.dart';
import '../components.dart';
import '../dataClass/dataClass.dart';
import '../videoCall/videoCall.dart';

class body extends StatefulWidget {

  final List<appointment> data;
  final profile patientProfile;

  const body({Key? key, required this.data, required this.patientProfile}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {

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
              leading: const components().backButton(context),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 10, left: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 10, left: 10),
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: colors().logo_darkBlue),
                      child: TabBar(
                        labelPadding:
                            const EdgeInsets.only(top: 10, bottom: 10),
                        indicator: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        unselectedLabelColor: Colors.white,
                        labelColor: colors().logo_darkBlue,
                        onTap: (value) {},
                        tabs: const [
                          Text("Pending", style: TextStyle(fontSize: 20)),
                          Text("Approved", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.72,
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.data.length,
                            itemBuilder: (context, index) {
                              if(widget.data[index].status == "Pending"){
                                return InkWell(
                                  child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 15),
                                      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10,right: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xfff6f6f4),
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: [
                                              const Icon(Icons.access_time_filled, color: Color(0xff474747), size: 15),
                                              const SizedBox(width: 5,),
                                              const components().text(widget.data[index].date, FontWeight.normal, Color(0xff474747), 14),
                                              const SizedBox(width: 10,),
                                              const components().text(widget.data[index].time, FontWeight.normal, Color(0xff474747), 14)
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                  alignment: Alignment.bottomCenter,
                                                  height: MediaQuery.of(context).size.width * 0.2,
                                                  width: MediaQuery.of(context).size.width * 0.2,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white70),
                                                  child: CircleAvatar(
                                                    radius:
                                                    MediaQuery.of(context).size.width * 0.17,
                                                    child: widget.data[index].image!.isEmpty ?
                                                    Icon(Icons.person,color: Color(0xff383434),size: 30):
                                                    ClipOval(
                                                        child: Image.network(
                                                          api().uri + widget.data[index].image!,
                                                          fit: BoxFit.fill,
                                                          height: double.maxFinite,
                                                          width: double.maxFinite,
                                                        )),

                                                  )

                                              ),
                                              const SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const components().text(widget.data[index].name, FontWeight.w500, Colors.black, 16),
                                                  const components().text("Mode: "+widget.data[index].mode, FontWeight.w400, Color(0xff474747), 14),


                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: const Color(0xffBDEAF8),
                                                    ),
                                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                                    alignment: Alignment.bottomRight,
                                                    child: Wrap(
                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                      children: [
                                                        Icon(Icons.remove_red_eye_outlined, color: colors().logo_darkBlue, size: 17),
                                                        const components().text("View", FontWeight.normal, colors().logo_darkBlue, 14)
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),


                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                  onTap: () {

                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.data.length,
                            itemBuilder: (context, index) {
                              if(widget.data[index].status == "Approved"){
                                return InkWell(
                                  child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 15),
                                      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10,right: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xfff6f6f4),
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: [
                                              const Icon(Icons.access_time_filled, color: Color(0xff474747), size: 15),
                                              const SizedBox(width: 5,),
                                              const components().text(widget.data[index].date.substring(0,10), FontWeight.normal, Color(0xff474747), 14),
                                              const SizedBox(width: 10,),
                                              const components().text(widget.data[index].time, FontWeight.normal, Color(0xff474747), 14)
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                  alignment: Alignment.bottomCenter,
                                                  height: MediaQuery.of(context).size.width * 0.2,
                                                  width: MediaQuery.of(context).size.width * 0.2,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white70),
                                                  child: CircleAvatar(
                                                    radius:
                                                    MediaQuery.of(context).size.width * 0.17,
                                                    child: widget.data[index].image!.isEmpty ?
                                                    Icon(Icons.person,color: Color(0xff383434),size: 30):
                                                    ClipOval(
                                                        child: Image.network(
                                                          api().uri + widget.data[index].image!,
                                                          fit: BoxFit.fill,
                                                          height: double.maxFinite,
                                                          width: double.maxFinite,
                                                        )),

                                                  )

                                              ),
                                              const SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const components().text(widget.data[index].name, FontWeight.w500, Colors.black, 16),
                                                  const components().text("Mode: "+widget.data[index].mode, FontWeight.w400, Color(0xff474747), 14),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.23,),
                                        InkWell(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: colors().logo_darkBlue
                                              ),
                                              padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                              child: const components().text("Join", FontWeight.normal, Colors.white, 16)
                                          ),
                                          onTap: () {
                                            if( widget.data[index].mode == "video"){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => videoCall(roomId: widget.data[index].link, role: "client", appointmentData: widget.data[index],)));
                                            }
                                            if(widget.data[index].mode == "audio"){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => audioCall(roomId: widget.data[index].link, role: "client", appointmentData: widget.data[index], patientProfile: widget.patientProfile ),));
                                            }
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => callScreen(roomId: "Ba4rv79RD5J6ACWHDHQc", role: "client"),));

                                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => audiCallScreen(roomId: "Ba4rv79RD5J6ACWHDHQc", role: "client"),));
                                          },
                                        )
                                        ,
                                        const SizedBox(width: 10,),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(5),
                                            color: const Color(0xffBDEAF8),
                                          ),
                                          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),

                                          child: Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: [
                                              Icon(Icons.remove_red_eye_outlined, color: colors().logo_darkBlue, size: 17),
                                              const components().text("View", FontWeight.normal, colors().logo_darkBlue, 14)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                                ],
                                              ),


                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                  onTap: () {

                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
