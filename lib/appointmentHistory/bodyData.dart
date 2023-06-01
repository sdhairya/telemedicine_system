import 'package:flutter/material.dart';
import 'package:telemedicine_system/colors.dart';
import 'package:telemedicine_system/dataClass/dataClass.dart';

import '../apis/api.dart';
import '../components.dart';

class bodyData extends StatefulWidget {

  final appointmentHistory data;
  const bodyData({Key? key, required this.data}) : super(key: key);

  @override
  State<bodyData> createState() => _bodyDataState();
}

class _bodyDataState extends State<bodyData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height),
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 0),
            child: ListTile(
              leading: components().backButton(context),
              title: components().text("Appointment", FontWeight.bold, Colors.black, 25),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 10, top: 20, left: 15, right: 15),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, blurStyle: BlurStyle.outer)],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 15,
                  children: [
                    ClipOval(
                      child: CircleAvatar(
                          backgroundColor: Colors.black12,
                          radius: MediaQuery.of(context).size.width * 0.11,
                          child: Image(image: NetworkImage(api().uri+widget.data.doctor.image),)

                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        components().text(widget.data.doctor.name, FontWeight.w700, Colors.black, 16),
                        SizedBox(height: 5,),
                        components().text(widget.data.doctor.degree, FontWeight.w500, Colors.grey, 15),
                        SizedBox(height: 5,),
                        components().text(widget.data.doctor.facility, FontWeight.w500, Colors.grey, 15),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      components().text("Appointment", FontWeight.w500, Colors.black, 16),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colors().logo_darkBlue)
                        ),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      components().text("Date", FontWeight.w500, Colors.grey, 18),
                                      components().text(widget.data.date.toString().substring(0,10), FontWeight.w500, Colors.black, 18),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      components().text("Time", FontWeight.w500, Colors.grey, 18),
                                      components().text(widget.data.time.toString(), FontWeight.w500, Colors.black, 18),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      components().text("Fees", FontWeight.w500, Colors.grey, 18),
                                      components().text(widget.data.fees.toString(), FontWeight.w500, Colors.black, 18),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      components().text("Encounter ID", FontWeight.w500, Colors.grey, 18),
                                      components().text(widget.data.encounter_id.toString(), FontWeight.w500, Colors.black, 18),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      components().text("Location", FontWeight.w500, Colors.grey, 18),
                                      components().text(widget.data.doctor.facility.toString(), FontWeight.w500, Colors.black, 18),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      components().text("Mode", FontWeight.w500, Colors.grey, 18),
                                      components().text(widget.data.consultationMode.toString(), FontWeight.w500, Colors.black, 18),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    components().text("Prescription", FontWeight.w500, Colors.black, 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colors().logo_darkBlue)
                      ),
                      child: Expanded(
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              components().text("Symptoms : "+widget.data.pres!.symptoms.toString(), FontWeight.w500, Colors.black, 18),
                              components().text("Diagnosis : "+widget.data.pres!.diagnosis.toString(), FontWeight.w500, Colors.black, 18),
                              components().text("Test : "+widget.data.pres!.test.toString(), FontWeight.w500, Colors.black, 18),
                              ...widget.data.pres!.medicines!.map((e) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      components().text(e.name.toString(), FontWeight.w600, colors().logo_darkBlue, 18),

                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          components().text("Quantity: "+e.quantity.toString(), FontWeight.normal, colors().logo_darkBlue, 16),
                                          SizedBox(width: 30,),
                                          components().text("Days: "+e.duration.toString(), FontWeight.normal, colors().logo_darkBlue, 16),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Wrap(
                                        children: [
                                          components().text(e.food.join(" "), FontWeight.w500, colors().logo_darkBlue, 16),
                                          SizedBox(width: 30,),
                                          components().text(e.daytime.join(" "), FontWeight.w500, colors().logo_darkBlue, 16),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },)
                            ],
                          ),
                        )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
