import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telemedicine_system/apis/api.dart';
import 'package:telemedicine_system/colors.dart';
import 'package:telemedicine_system/doctorsScreen/doctorsScreen.dart';
import 'package:telemedicine_system/editProfile/editProfile.dart';

import '../components.dart';
import '../dataClass/dataClass.dart';

class body extends StatefulWidget {
  final List<profile> data;
  final String id;

  const body({Key? key, required this.data, required this.id})
      : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  List<profile> updatedData = [];
  File? _pickedimage;
  Uint8List webImage = Uint8List(8);
  var f;
  var imgPath;
  String? path;
  String assetURL = "http://192.168.1.170:5024/";

  bool _genderInvalid = false;
  bool _isobscure = false;
  String? gender;

  void _toggle() {
    setState(() {
      _isobscure = !_isobscure;
    });
  }

  @override
  void initState() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: api().profiledetails(""),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                              radius: 2,
                              center: Alignment.bottomLeft,
                              colors: [
                            colors().logo_lightBlue,
                            colors().logo_darkBlue
                          ])),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          ListTile(
                            horizontalTitleGap: 80,
                            leading: components().backButton(context),
                            title: components().text(
                                "Account", FontWeight.w500, Colors.white, 26),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: MediaQuery.of(context).size.width * 0.35,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: colors().logo_darkBlue),
                                shape: BoxShape.circle,
                                color: Colors.white70),
                            child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.17,
                                child: _pickedimage == null
                                    ? path!.isEmpty
                                        ? InkWell(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.camera_alt,
                                                    size: 50,
                                                    color: Colors.white),
                                                Text(
                                                  "Choose Image",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                            onTap: () {
                                              _getFromGallery();
                                            },
                                          )
                                        : ClipOval(
                                            child: Image.network(
                                              api().uri + path!,
                                            fit: BoxFit.fill,
                                            height: double.maxFinite,
                                            width: double.maxFinite,
                                          ))
                                    : ClipOval(
                                        child: Image.memory(
                                        width: double.maxFinite,
                                        height: double.maxFinite,
                                        webImage,
                                        fit: BoxFit.fill,
                                      ))),
                          ),
                          Visibility(
                              child: Container(
                                alignment: Alignment.center,
                                child: TextButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.edit),
                                        Text("Edit"),
                                      ],
                                    ),
                                    onPressed: () => _getFromGallery()),
                              ),
                              visible: true),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.06,
                                right:
                                    MediaQuery.of(context).size.width * 0.06),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                components().text("\t\tName", FontWeight.w500,
                                    Colors.black, 18),
                                components().textField("Enter Name",
                                    TextInputType.text, _nameController),
                                SizedBox(
                                  height: 15,
                                ),
                                components().text("\t\tEmail", FontWeight.w500,
                                    Colors.black, 18),
                                components().textField("Enter email",
                                    TextInputType.text, _emailController),
                                SizedBox(
                                  height: 15,
                                ),
                                components().text("\t\tGender", FontWeight.w500,
                                    Colors.black, 18),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width: double.maxFinite,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff6f4f4),
                                      border:
                                          Border.all(color: Color(0xffd7d7d7)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio(
                                        value: "male",
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = "male";
                                            _genderInvalid = false;
                                          });
                                        },
                                      ),
                                      components().text("Male", FontWeight.w500,
                                          Color(0xff292929), 16),
                                      Radio(
                                        value: "female",
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = "female";
                                            _genderInvalid = false;
                                          });
                                        },
                                      ),
                                      components().text(
                                          "Female",
                                          FontWeight.w500,
                                          Color(0xff292929),
                                          16),
                                      Radio(
                                        value: "other",
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = "other";
                                            _genderInvalid = false;
                                          });
                                        },
                                      ),
                                      components().text(
                                          "Other",
                                          FontWeight.w500,
                                          Color(0xff292929),
                                          16),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                components().text("\t\tPassword",
                                    FontWeight.w500, Colors.black, 18),
                                TextFormField(
                                  obscureText: _isobscure,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      hintText: 'Enter Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isobscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: _toggle,
                                      )),
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: colors().logo_darkBlue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        padding: EdgeInsets.fromLTRB(
                                            55, 10, 55, 10)
                                    ),
                                      onPressed: () {
                                        api().updateProfile(
                                            profile(
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                gender: gender.toString(),
                                                password:
                                                _passwordController.text,
                                                image: imgPath),
                                            widget.id,);
                                      },
                                      child: components().text("Update",
                                          FontWeight.bold, Colors.white, 20)),
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }

  _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() async {
        f = await image.readAsBytes();
        webImage = f;
        _pickedimage = File("a");
        imgPath = image.path;
        // imgPath = File(image!.path);
      });
      print(webImage);
    }

    //imgPath = image!.path;
    print("print $imgPath");
  }

  _loadData() {
    print(widget.data);
    _nameController.text = widget.data[0].name;
    _emailController.text = widget.data[0].email;
    setState(() {
      gender = widget.data[0].gender;
    });
    _passwordController.text = widget.data[0].password;
    path = widget.data[0].image;
    print(assetURL + path!);
  }
}
