import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:telemedicine_system/components.dart';
import 'package:http/http.dart' as http;
import 'package:telemedicine_system/signUpScreen/otpVerificationScreen.dart';

class body_mobileNumber extends StatefulWidget {

  final List<String> data;

  const body_mobileNumber({Key? key, required this.data}) : super(key: key);

  @override
  State<body_mobileNumber> createState() => _body_mobileNumberState();
}

class _body_mobileNumberState extends State<body_mobileNumber> {

  TextEditingController _phoneController = TextEditingController();


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
                                      Navigator.of(context).pop();
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
                          components().text("We wil send you a one time password.", FontWeight.w300, Color(0xff3a3a3a), 18),
                          SizedBox(
                            height: 30,
                          ),
                          components().text("Enter your Mobile Number", FontWeight.w500, Color(0xff3a3a3a), 18),

                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.04,
                                bottom: MediaQuery.of(context).size.height * 0.04,
                                left: MediaQuery.of(context).size.width * 0.15,
                                right: MediaQuery.of(context).size.width * 0.15),
                            child: components().textField_underline("Enter Mobile Number", TextInputType.phone, _phoneController),
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
                              child: components().text("Get Otp",
                                  FontWeight.w500, Colors.white, 22),
                              onPressed: () async {
                                print(widget.data);
                                String uri = 'http://192.168.1.170:5024/api/users';
                                var res = await http.post(Uri.parse(uri),
                                    body: json.encode({
                                      "name":widget.data[0].toString(),
                                      "email":widget.data[1].toString(),
                                      "phone": _phoneController.text.toString(),
                                      "gender": widget.data[2].toString(),
                                      "dob":widget.data[3].toString().substring(0,10),
                                      "password": widget.data[4].toString()
                                    }),
                                    headers: {
                                      "Accept": "application/json",
                                      "content-type":"application/json"
                                    },
                                    encoding: Encoding.getByName('utf-8'));
                                print(res.statusCode);
                                print(jsonDecode(res.body));

                                if(json.decode(res.body) == "User Added Successfully"){



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
