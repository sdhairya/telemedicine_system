import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../components.dart';

class otpVerificationScreen extends StatefulWidget {
  const otpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<otpVerificationScreen> createState() => _otpVerificationScreenState();
}

class _otpVerificationScreenState extends State<otpVerificationScreen> {
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
                                  child: ElevatedButton(
                                    child: Icon(Icons.arrow_back_ios_new, size: 30, color: Color(0xff383434)),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xfff6f6f4),
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(10)
                                    ),
                                    onPressed: () {
                                    },
                                  ),
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
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldWidth: 40,
                                fieldStyle: FieldStyle.underline,
                                style: TextStyle(fontSize: 17),
                                onChanged: (pin) {
                                  print("Changed: " + pin);
                                },
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                }),
                          )
                          ,
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
                              onPressed: () {

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            otpVerificationScreen()));
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
