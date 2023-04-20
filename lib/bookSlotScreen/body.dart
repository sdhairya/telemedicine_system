import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemedicine_system/apis/api.dart';
import 'package:telemedicine_system/colors.dart';
import 'package:telemedicine_system/confirmBookingScreen/confirmBookingScreen.dart';
import 'package:telemedicine_system/doctorProfile/doctorProfile.dart';
import 'package:telemedicine_system/doctorsScreen/doctorsScreen.dart';
import 'package:telemedicine_system/cupertinoExtended.dart' as cupertino_extended;


import '../components.dart';
import '../dataClass/dataClass.dart';

class body extends StatefulWidget {
  final doctorProfile data;
  final String format;

  const body({Key? key, required this.data, required this.format,})
      : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  int selectedIndex = 0;
  int selIndex = 9999;
  var daytime = "morning";
  bool bookSlot = false;
  List<String> times = ["morning", "afternoon", "evening"];
  var day = DateFormat('EEEE').format(DateTime.now());
  late DateTime _selectedDate;
  String selectedSlot = "";
  List<String> facility_name = [" "," "," "];
  int facility_id = 0;
  String facility_address = "";



  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    String assetURL = "http://192.168.1.170:5024/";
    List<appointmentData> appointmentDetails = [];
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: ListTile(
              leading: components().backButton(context),
              trailing:
              Image(image: AssetImage("assets/images/logo_symbol.png")),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: Column(
                    children: [
                      Row(
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.13,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Image(
                                image:
                                    NetworkImage(api().uri + widget.data.image)),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                components().text(widget.data.name,
                                    FontWeight.bold, Colors.black, 20),
                                SizedBox(
                                  height: 10,
                                ),
                                components().text(widget.data.degree,
                                    FontWeight.normal, Colors.black, 18),
                                components().text(
                                    "Experience: " + widget.data.experience,
                                    FontWeight.normal,
                                    Colors.black,
                                    18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    components().text("Fees: " + widget.data.fees, FontWeight.normal, Colors.black, 18),
                                    InkWell(
                                      child: Wrap(
                                        children: [
                                          Icon(Icons.remove_red_eye, color: colors().logo_lightBlue,),
                                          components().text("View Profile", FontWeight.normal, colors().logo_lightBlue, 18),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => doctorProfie(profile: widget.data),));
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                buildFormatCard(widget.format),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CalendarTimeline(
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year, 12, 31),
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                      print(_selectedDate);
                      day = DateFormat('EEEE').format(_selectedDate);
                    });
                  },
                  leftMargin: 20,
                  monthColor: Colors.black54,
                  dayColor: Colors.black54,
                  showYears: true,
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: colors().logo_darkBlue,
                  dotsColor: colors().logo_darkBlue,
                  locale: 'en_ISO',
                ),
                Container(
                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            blurStyle: BlurStyle.outer),
                      ]),
                  child: DefaultTabController(
                      length: 3,
                      child: TabBar(
                        labelColor: Color(0xff32ae27),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                        unselectedLabelColor: Colors.black,
                        unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 17),
                        indicator: BoxDecoration(),
                        labelPadding:
                        EdgeInsets.only(top: 8, bottom: 8),
                        onTap: (value) {

                          print(times[value]);
                          setState(() {
                            daytime = times[value];
                            selectedSlot = "";
                          });
                        },
                        tabs: [
                          Wrap(
                            crossAxisAlignment:
                            WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.sunny),
                              Text(
                                "Morning",
                              ),
                            ],
                          ),
                          Wrap(
                            crossAxisAlignment:
                            WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.wb_twighlight),
                              Text(
                                "Afternoon",
                              ),
                            ],
                          ),
                          Wrap(
                            crossAxisAlignment:
                            WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.nights_stay),
                              Text(
                                "Evening",
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurStyle: BlurStyle.outer,blurRadius: 5)
                    ]
                  ),
                  alignment: Alignment.center,
                  child: FutureBuilder(
                    future: api().getSlots(widget.data.id, day, widget.format == "message" || widget.format == "video" || widget.format == "audio" ? "online" : "offline"),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        facility_name[0] = snapshot.data![0].morningFacility.name;
                        facility_name[1] = snapshot.data![0].afternoonFacility.name;
                        facility_name[2] = snapshot.data![0].eveningFacility.name;
                        if(daytime == "morning"){
                          facility_id = snapshot.data![0].morningFacility.id;
                          return timeSlots(snapshot.data![0].morningSlots,);
                        }
                        if(daytime == "afternoon"){
                          facility_id = snapshot.data![0].afternoonFacility.id;
                          return timeSlots(snapshot.data![0].afternoonSlots,);

                        }
                        if(daytime == "evening"){
                          facility_id = snapshot.data![0].eveningFacility.id;
                          return timeSlots(snapshot.data![0].eveningSlots,);
                        }

                      }

                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colors().logo_darkBlue,
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: MediaQuery.of(context).size.width * 0.12,
                    right: MediaQuery.of(context).size.width * 0.12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: components().text("Book Slot", FontWeight.w500, Colors.white, 22),
            onPressed: selectedSlot != "" ?  () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              var _id = _prefs.getString("patient_id") ?? "";
              var _phone = _prefs.getString("phone") ?? "";
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => confirmBookingScreen(data: widget.data, appointment_data: appointmentData(patient_id: _id,doctor_id: widget.data.id, patient_phone: _phone ,doctor_phone: widget.data.phone, facility_id: facility_id, date: _selectedDate.toString().substring(0,10), time: selectedSlot, consultationMode: widget.format, fees: widget.data.fees, link: ' ')),));
            } : null
          ),
        ),
      ),
    );
  }

  Widget timeSlots(List<String> slot){

    return slot.length == 1 ? Text("No Slots available") : Wrap(
      children: slot.map((e) {
        return InkWell(
          onTap: () {
            print(selIndex);
            setState(() {
              selIndex = slot.indexOf(e);
              selectedSlot = e;
              print(selectedSlot);
              bookSlot = true;
            });
          },
            child: Container(
              margin: EdgeInsets.all(5),
              child: components().text(
                  e, FontWeight.normal, selIndex == slot.indexOf(e) ? Colors.white : Colors.black, 18),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selIndex == slot.indexOf(e) ? colors().logo_darkBlue : Colors.white,
                  boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 5)
              ],
                  borderRadius: BorderRadius.circular(10),),
            ),

          );
      }).toList(),
    );
  }

  Widget buildFormatCard(String format) {
    var f;
    if(daytime == "morning" ){
      f = facility_name[0];
    }
    if(daytime == "afternoon" ){
      f = facility_name[1];
    }
    if(daytime == "evening" ){
      f = facility_name[2];
    }
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color(0xfff6f6f4),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.055,
                  margin: EdgeInsets.only(right: 10),
                  child: Image(
                      image: AssetImage(
                          "assets/images/" + format + "Consult.png")),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: format == "visit"
                        ? components().text(f, FontWeight.w500, Colors.black, 20)
                          : components().text(format + " consult", FontWeight.w500, Colors.black, 20),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_down_sharp, size: 35,),
          ],
        ));
  }

  Widget buildDatePicker() => SizedBox(
    height: 180,
    child: CupertinoDatePicker(
      minimumYear: DateTime.now().year,
      maximumYear: DateTime.now().year,
      initialDateTime: now,
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime) {
        setState(() {
          this.now = dateTime;
          lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
        },);
        print(lastDayOfMonth);


      }
    ),
  );

}
