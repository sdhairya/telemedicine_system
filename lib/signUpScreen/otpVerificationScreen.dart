import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:telemedicine_system/colors.dart';
import 'package:telemedicine_system/dataClass/dataClass.dart';
import 'package:telemedicine_system/loginScreen/loginScreen.dart';

import '../apis/api.dart';
import '../components.dart';
import '../dashboardScreen/dashboardScreen.dart';

class otpVerificationScreen extends StatefulWidget {

  final createProfile data;
  const otpVerificationScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<otpVerificationScreen> createState() => _otpVerificationScreenState();
}

class _otpVerificationScreenState extends State<otpVerificationScreen> {

  OtpFieldController otp = OtpFieldController();
  String value = "";
  bool timerStart = false;
  bool reSend = false;


  @override
  void initState() {
    super.initState();
    timerStart = true;
    startTimer();
  }

  late Timer _timer;
  Duration myDuration = Duration(seconds: 30);
  void startTimer() {
    _timer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        _timer.cancel();
        setState(() {
          reSend = true;
        });
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(

            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Column(
                        children: [

                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: EdgeInsets.only(top: 30,left: 15),
                                  child: components().backButton(context)
                                )
                                ,
                                Align(
                                  alignment: Alignment.center,
                                  heightFactor: 2,
                                  child: Image(
                                      image: AssetImage("assets/images/otp.png"),
                                      width: MediaQuery.of(context).size.width * 0.6),
                                )

                              ],
                            ),
                          ),

                          components().text("OTP Verification", FontWeight.bold, Colors.black, 26),
                          SizedBox(
                            height: 2,
                          ),
                          components().text("Enter Otp sent to ", FontWeight.w300, Color(0xff3a3a3a), 18),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: OTPTextField(
                                length: 4,
                                controller: otp,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldWidth: 40,
                                fieldStyle: FieldStyle.underline,
                                style: TextStyle(fontSize: 17),
                                onChanged: (pin) {
                                  print("Changed: " + pin);
                                },
                                onCompleted: (pin) {
                                  setState(() {
                                    value = pin;
                                  });
                                  print("Completed: " + pin);
                                }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: components().text("Resend OTP", FontWeight.w500, reSend ? colors().logo_darkBlue : Colors.grey, 18),
                                  onTap: () async {
                                    await api().sendOtp(widget.data.phone);
                                  },
                                ),
                                components().text("Seconds "+myDuration.inSeconds.remainder(60).toString(), FontWeight.w400 , Colors.grey, 18)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff1f5c92),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15)),
                                  padding: EdgeInsets.fromLTRB(
                                      55, 10, 55, 10)),
                              child: components().text("Verify Otp",
                                  FontWeight.w500, Colors.white, 22),
                              onPressed: () async {
                                print(value);
                                var result = await api().addUser(value, widget.data);

                                if(result == "otp is invalid"){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: components().text("Please enter valid OTP", FontWeight.w500, Colors.white, 18),));
                                }
                                else{
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginScreen()));
                                }

                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             otpVerificationScreen()));
                              },
                            ),
                          )


                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
