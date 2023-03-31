import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_system/loginScreen/loginScreen.dart';

import 'package:intl/intl.dart';
import 'package:telemedicine_system/signUpScreen/body_mobileNumber.dart';

import '../components.dart';
import '../utils.dart';
import 'body1.dart';

class body2 extends StatefulWidget {

  final List<String> data;

  const body2({Key? key, required this.data}) : super(key: key);

  @override
  State<body2> createState() => _body2State();
}

class _body2State extends State<body2> {
  bool _isobscure = true;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  bool _passwordNotSame = false;
  DateTime dateTime = DateTime.now();

  void _toggle() {
    setState(() {
      _isobscure = !_isobscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png",),fit: BoxFit.fill,
                    alignment: Alignment.bottomCenter)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
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

                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) => body1()));

                                        },
                                      ),
                                    )
                                    ,
                                    Align(
                                      alignment: Alignment.center,
                                      child: Image(
                                          image: AssetImage("assets/images/logo.png"),
                                          width: MediaQuery.of(context).size.width * 0.6),
                                    )

                                  ],
                                ),
                              )

                              ,
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.black12),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: components().text("Sign Up",
                                          FontWeight.bold, Color(0xff114c81), 35),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    components().text("   Date of Birth", FontWeight.w700,
                                        Color(0xff292929), 16),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),

                                    InkWell(
                                      onTap: () => showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) => CupertinoActionSheet(
                                          actions: [
                                            buildDatePicker(),
                                          ],
                                          cancelButton: CupertinoActionSheetAction(
                                            child: Text('Done'),
                                            onPressed: () {
                                              final value = dateTime;
                                              print(value);
                                              setState(() {
                                                dateTime = value;
                                                Navigator.of(context).pop();
                                              });


                                            },
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.06,
                                        width: double.maxFinite,
                                        padding: EdgeInsets.only(left: 15),
                                        decoration: BoxDecoration(
                                            color: Color(0xfff6f4f4),
                                            border: Border.all(color: Color(0xffd7d7d7)),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          children: [
                                            components().text(dateTime.toString().substring(0,10), FontWeight.normal, Colors.black, 18),
                                            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.03,
                                    ),
                                    components().text("   Password", FontWeight.w700,
                                        Color(0xff292929), 16),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    components().textField("Enter Password",
                                        TextInputType.text, _passwordController),
                                    // _nameInvalid
                                    //     ? components().text(
                                    //     " Name Field cannot be empty",
                                    //     FontWeight.normal,
                                    //     Colors.red,
                                    //     15)
                                    //     : Container(),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.03,
                                    ),
                                    components().text("   Confirm Password",
                                        FontWeight.w700, Color(0xff292929), 16),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    components().textField("Enter Confirm Password",
                                        TextInputType.emailAddress, _confirmpasswordController),
                                    _passwordNotSame
                                        ? components().text(" Passwords don't match",
                                        FontWeight.normal, Colors.red, 15)
                                        : Container(),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.025,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.05,
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
                                        child: components().text("Next",
                                            FontWeight.bold, Colors.white, 22),
                                        onPressed: () {

                                          widget.data.add(dateTime.toString());
                                          widget.data.add(_passwordController.text);

                                          print(widget.data);

                                          validate()
                                              ?
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      body_mobileNumber(data: widget.data,)))
                                              : Null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Align(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Wrap(
                            children: [
                              components().text("Already have an account? ",
                                  FontWeight.normal, Colors.white, 16),
                              InkWell(
                                child: components().text(
                                    "Login", FontWeight.bold, Colors.white, 18),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => loginScreen()));
                                },
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ))
    );
  }

  bool validate() {

    if(_passwordController.text != _confirmpasswordController.text){
      setState(() {
        _passwordNotSame = true;

      });
      return false;
    }
    return true;


  }

  Widget buildDatePicker() => SizedBox(
    height: 180,
    child: CupertinoDatePicker(
      minimumYear: 2015,
      maximumYear: DateTime.now().year,
      initialDateTime: dateTime,
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime) =>
          setState(() => this.dateTime = dateTime),
    ),
  );
}
