import 'dart:async';

import 'package:flutter/material.dart';

import '../apis/api.dart';
import '../colors.dart';
import '../components.dart';
import '../loginScreen/loginScreen.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  TextEditingController _otpController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();


  bool isLoading = false;
  bool _isobscurePassword = true;
  bool _isobscureConfirmPassword = true;


  bool timerStart = false;
  bool reSend = false;
  bool show = false;



  late Timer _timer;
  Duration myDuration = Duration(seconds: 30);
  void startTimer() {
    _timer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  void stopTimer() {
    setState(() => _timer!.cancel());
  }
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(seconds: 30));
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
        resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: ListTile(
                leading: components().backButton(context),
              ),
            ),

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),

                  components().text("Forgot Password", FontWeight.bold, Color(0xff101010), 38),


                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  components().text("   Phone", FontWeight.w500, Colors.black, 18),
                  components().textField("Enter Phone", TextInputType.phone, _phoneController),
                  // emailInvalid ? components().text(" Enter valid Name", FontWeight.normal, Colors.red, 15) : Container(),
                  SizedBox(
                    height: 15,
                  ),
                  components().text("   Otp", FontWeight.w500, Colors.black, 18),
                  components().textField("Enter Otp", TextInputType.phone, _otpController),
                  // emailInvalid ? components().text(" Enter valid Phone", FontWeight.normal, Colors.red, 15) : Container(),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: components().text("Resend OTP", FontWeight.w500, reSend ? colors().logo_darkBlue : Colors.grey, 18),
                          onTap: () async {
                            setState(() {
                              timerStart = true;
                              resetTimer();
                              startTimer();
                            });
                            await api().sendOtp(_phoneController.text);
                          },
                        ),
                        components().text("Seconds "+myDuration.inSeconds.remainder(60).toString(), FontWeight.w400 , Colors.grey, 18)
                      ],
                    ),
                  ),
                  show ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      components().text("   Password", FontWeight.w500, Colors.black, 18),
                      TextFormField(
                        obscureText: _isobscurePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff6f6f4),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Color(0xffd7d7d7))),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(15)),
                            hintText: 'Enter Password',
                            suffixIcon: IconButton(
                              icon: Icon(_isobscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off, ),
                              onPressed: () {
                                setState(() {
                                  _isobscurePassword = !_isobscurePassword;
                                });
                              },
                            )),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      components().text("   Confirm Password", FontWeight.w500, Colors.black, 18),
                      TextFormField(
                        obscureText: _isobscureConfirmPassword,
                        controller: _confirmController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff6f6f4),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Color(0xffd7d7d7))),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(15)),
                            hintText: 'Enter Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(_isobscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off, ),
                              onPressed: () {
                                setState(() {
                                  _isobscureConfirmPassword = !_isobscureConfirmPassword;
                                });
                              },
                            )),
                        keyboardType: TextInputType.visiblePassword,
                      ),                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  )
                   : Container()

                ],
              ),
            ),
          ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.center,
          child: ElevatedButton(
            child: components().text(timerStart ? "Change Password":"Send Otp", FontWeight.w500, Colors.white, 20),
            style: ElevatedButton.styleFrom(
                backgroundColor: colors().logo_darkBlue,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10)
            ),
            onPressed: () async {

              // print(_phoneController.text);

              if(timerStart){
                var res = await api().forgotPassword(_phoneController.text, int.parse(_otpController.text), _passwordController.text);
                print(res);
                if(res == "Password updated Successfully"){
                  print(res);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: components().text("Password Changed Successfully", FontWeight.w500, Colors.white, 18),));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginScreen()));
                }
                else if(res == "otp is invalid"){
                  print(res);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: components().text("Enter Valid Otp", FontWeight.w500, Colors.white, 18),));
                }
              }
              else{
                await api().sendOtp(_phoneController.text);
              }
              
              setState(() {
                timerStart = true;
                show = true;
                startTimer();
              });


            },
          ),
        ),
      ),
    );
  }
}