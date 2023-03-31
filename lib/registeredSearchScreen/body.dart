import 'package:flutter/material.dart';
import 'package:telemedicine_system/bookSlotScreen/bookSlotScreen.dart';
import 'package:telemedicine_system/dataClass/dataClass.dart';
import '../apis/api.dart';
import '../components.dart';
import '../consultationModeScreen/consultationFormatScreen.dart';

class body extends StatefulWidget {

  final List<String> categories;

  const body({Key? key, required this.categories}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {

  String filter = "";
  TextEditingController _searchController = new TextEditingController();
  List<doctorProfile> d = [];
  bool searchClicked = false;
  String assetURL = "http://192.168.1.170:5024/";

  @override
  void initState() {

    // getTags();

    _searchController.addListener(() {
      print(_searchController.text);
      filter = _searchController.text;
      setState(() {});
    });
  }

  // getTags() async {
  //
  //   d = await api().getTags();
  //
  // }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ListTile(
              leading: components().backButton(context),
              trailing: Image(image: AssetImage("assets/images/logo_symbol.png")),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: MediaQuery.of(context).size.height * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  components().text("Find Your Desired \nDoctor",
                      FontWeight.bold, Colors.black, 26),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      fillColor: Color(0xfff6f6f4),
                      hintText: "Search",
                        hintStyle: TextStyle(fontSize: 20),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) async {
                      print(value);
                      if(value == null){
                        setState(() {
                          searchClicked = false;
                        });
                      }
                      else{
                        var dd = await api().getDoctorsTags(value);
                        setState(() {
                          searchClicked = true;
                          d = dd;
                        });
                      }

                    },

                    onTap: () {},
                  ),
                  Row(
                    children: [
                      Spacer(),
                    ],
                  ),


                  searchClicked ? Container() : Column(
                    children: [
                      ...widget.categories.map((e) {
                        return searchCard(e);
                      },).toList()
                    ],
                  ),
                  searchClicked ? Column(
                    children: [
                      ...d.map((e) {
                        // print(e);
                        return doctorCard(e);
                      },).toList(),
                    ],
                  )  : Container()


                ],
              ),
            )
          ],
        ),
      )),
    );
  }
  
  searchCard(String data){
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: Color(0xfff6f6f4)
        ),
        child: ListTile(
          horizontalTitleGap: 0,
          leading: Icon(Icons.search),
          title: components().text(data, FontWeight.normal, Colors.black, 18),
        ),
      ),
      onTap: () {
        print(data);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => consultationModeScreen(category: data, data: doctorProfile(id:"id", name: "name",phone: "", degree: "degree", facility: "facility", experience: "experience", image: "image", speciality: '', mode: "", fees: "", otherachivement: "", description: "")),));
      },
    );
  }

  doctorCard(doctorProfile data){
    return InkWell(
      child: Container(
          padding: EdgeInsets.only(top: 10,bottom: 10, left: 15, right: 15),
          margin: EdgeInsets.only(top: 5,bottom: 5, left: 10, right: 10),
          decoration: BoxDecoration(
              color: Color(0xfff6f6f4),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.17,
                    height: MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Image(image: NetworkImage(api().uri+data.image)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      components().text(data.name, FontWeight.w500, Colors.black, 20),
                      components().text(data.degree, FontWeight.normal, Colors.black, 20),
                    ],
                  ),
                ],
              ),

              Icon(Icons.arrow_forward_ios),
            ],
          )


      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => consultationModeScreen(category: "", data: data),));
        },
    );
  }
  
}
