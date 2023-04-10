import 'package:flutter/material.dart';
import 'package:telemedicine_system/dataClass/dataClass.dart';
import 'package:telemedicine_system/loginScreen/loginScreen.dart';

import '../components.dart';
import 'body2.dart';

class body1 extends StatefulWidget {
  const body1({Key? key}) : super(key: key);

  @override
  State<body1> createState() => _body1State();
}

class _body1State extends State<body1> {
  bool _isobscure = true;

  bool _nameInvalid = false;
  bool _emailInvalid = false;
  bool _genderInvalid = false;
  String? gender;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // TextEditingController _genderController = TextEditingController();



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
                              Image(
                                  image: AssetImage("assets/images/logo.png"),
                                  width: MediaQuery.of(context).size.width * 0.6),
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
                                    components().text("   Name", FontWeight.w700,
                                        Color(0xff292929), 16),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    components().textField("Enter Your Name",
                                        TextInputType.text, _nameController),
                                    _nameInvalid
                                        ? components().text(
                                        " Name Field cannot be empty",
                                        FontWeight.normal,
                                        Colors.red,
                                        15)
                                        : Container(),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.03,
                                    ),
                                    components().text("   Email",
                                        FontWeight.w700, Color(0xff292929), 16),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    components().textField("Enter Your email",
                                        TextInputType.emailAddress, _emailController),
                                    _emailInvalid
                                        ? components().text(" Email not valid",
                                        FontWeight.normal, Colors.red, 15)
                                        : Container(),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.025,
                                    ),

                                    components().text("   Gender",
                                        FontWeight.w700, Color(0xff292929), 16),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff6f4f4),
                                        border: Border.all(color: Color(0xffd7d7d7)),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Radio(
                                            value: "male",
                                            groupValue: gender,
                                            onChanged: (value){
                                              setState(() {
                                                gender = "male";
                                                _genderInvalid = false;
                                              });
                                            },
                                          ),
                                          components().text("Male",
                                              FontWeight.w500, Color(0xff292929), 16),

                                          Radio(
                                            value: "female",
                                            groupValue: gender,
                                            onChanged: (value){
                                              setState(() {
                                                gender = "female";
                                                _genderInvalid = false;
                                              });
                                            },
                                          ),
                                          components().text("Female",
                                              FontWeight.w500, Color(0xff292929), 16),

                                          Radio(
                                            value: "other",
                                            groupValue: gender,
                                            onChanged: (value){
                                              setState(() {
                                                gender = "other";
                                                _genderInvalid = false;
                                              });
                                            },
                                          ),
                                          components().text("Other",
                                              FontWeight.w500, Color(0xff292929), 16),
                                        ],
                                      ),
                                    ),
                                    _genderInvalid
                                        ? components().text(" Please select Gender",
                                        FontWeight.normal, Colors.red, 15)
                                        : Container(),
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

                                          setState(() {
                                            _nameInvalid = false;
                                            _emailInvalid = false;
                                            _genderInvalid = false;
                                          });
                                          print(gender);
                                          validate()
                                              ?
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      body2(data: createProfile(name: _nameController.text, email: _emailController.text, gender: gender.toString(), password: "password", dob: "dob", phone: "phone")
                                                        ,)))
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

  bool validate(){

    print(gender);
    bool nameInvalid = false;
    bool emailInvalid = false;
    // bool genderInvalid = false;
    _nameController.text.isEmpty ? nameInvalid = true : nameInvalid = false;
    _emailController.text.isEmpty ? emailInvalid = true : emailInvalid = false;
    // _genderController.text.isEmpty ? genderInvalid = true : genderInvalid = false;

    List<String> g = ["male", "female", "other"];

    if(gender != "female"){
      setState(() {
        _genderInvalid = true;
      });
    }
    if(gender != "male"){
      setState(() {
        _genderInvalid = true;
      });
    }
    if(gender != "other"){
      setState(() {
        _genderInvalid = true;
      });
    }

    if(nameInvalid){
      setState(() {
        _nameInvalid = true;
      });
    }

    if(emailInvalid){
      setState(() {
        _emailInvalid = true;
      });
    }

    // if(genderInvalid){
    //   setState(() {
    //     _genderInvalid = true;
    //   });
    // }

    if(_nameInvalid || _emailInvalid ){
      return false;
    }
    else{
      return true;
    }

  }

}
