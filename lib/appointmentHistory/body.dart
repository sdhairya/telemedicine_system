import 'package:flutter/material.dart';
import 'package:telemedicine_system/apis/api.dart';
import 'package:telemedicine_system/appointmentHistory/bodyData.dart';
import 'package:telemedicine_system/dataClass/dataClass.dart';

import '../components.dart';

class body extends StatefulWidget {

  final List<appointmentHistory> data;
  const body({Key? key, required this.data}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height),
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 0, bottom: 20),
            child: ListTile(
              leading: components().backButton(context),
              title: components().text("Appointment", FontWeight.bold, Colors.black, 25),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1, blurStyle: BlurStyle.outer)],
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff6f6f4)
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.1,
                            backgroundColor: Colors.blue[400],
                            child: Image(
                              image: NetworkImage(api().uri + widget.data[0].doctor.image),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            components().text(widget.data[index].doctor.name, FontWeight.w500, Colors.black, 23),
                            components().text(widget.data[index].date.toString().substring(0,10), FontWeight.normal, Colors.black, 14),
                            components().text(widget.data[index].time.toString(), FontWeight.normal, Colors.black, 14),
                          ],
                        ),

                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => bodyData(data: widget.data[index]),));
              },
            );
          },
        ),
      ),
    );
  }
}
