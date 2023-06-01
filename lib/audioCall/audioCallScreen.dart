import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:telemedicine_system/signaling.dart';

import '../apis/api.dart';
import '../components.dart';
import '../colors.dart';
import '../dataClass/dataClass.dart';

class audioCallScreen extends StatefulWidget {

  final String roomId;
  final String role;
  final appointment appointmentData;
  final profile patientProfile;

  const audioCallScreen({Key? key, required this.roomId, required this.role, required this.appointmentData, required this.patientProfile}) : super(key: key);

  @override
  State<audioCallScreen> createState() => _audioCallScreenState();
}

class _audioCallScreenState extends State<audioCallScreen> with TickerProviderStateMixin {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool audio = true;
  bool speaker = false;

  int daytime = 0;
  List<medicine> medicines = [];
  TextEditingController pillName = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController symptoms = TextEditingController();
  TextEditingController diagnosis = TextEditingController();
  TextEditingController test = TextEditingController();
  String food = "";
  String dayTime = "";
  bool before = false;
  bool after = false;
  bool morning = false;
  bool afternoon = false;
  bool evening = false;
  bool foodInvalid = false;
  bool dayInvalid = false;
  late TabController _tabController = TabController(length: 4, vsync: this);
  final _dialogFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    // signaling.openUserMedia(_localRenderer, _remoteRenderer);

    // _stream = _reference.snapshots();
    super.initState();
    join();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  Future<String> join() async {
    await signaling.openUserMedia(_localRenderer, _remoteRenderer, false, true);
    print("opened");
    print(widget.role);

    if (widget.role == "host") {
      signaling.joinCaller(
          widget.roomId,
          _remoteRenderer,
          "Audio"
      );
      setState(() {});
    } else if (widget.role == "client") {
      signaling.joinRoom(
        widget.roomId,
        _remoteRenderer,
      );
    }

    return "Success";
  }

  Stream<List<prescription>> pre() async*{
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      List<prescription> pres = await api().getPrescription(widget.appointmentData.id.toString());
      yield pres;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffE7F2FB),
        body: Container(
          width: double.maxFinite,
          decoration:const BoxDecoration(
              image:DecorationImage(image:AssetImage("assets/images/gradient.png"), fit:BoxFit.fill)
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height  * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.phone_in_talk, color: Colors.white, size: 18),
                        const SizedBox(width: 5,),
                        const components().text("00:00:00", FontWeight.normal, Colors.white, 18)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            ClipOval(
                              child: CircleAvatar(
                                  radius: MediaQuery.of(context).size.width * 0.15,
                                  backgroundColor: Colors.white,
                                  child: widget.appointmentData.image!.isEmpty
                                      ? const Image(image: AssetImage("assets/images/feamleAvatar.png"))
                                      : Image(image: NetworkImage(api().uri + widget.appointmentData.image!))
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const components().text(widget.appointmentData.name!, FontWeight.w400, Colors.white, 22)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CircleAvatar(
                                  radius: MediaQuery.of(context).size.width * 0.15,
                                  backgroundColor: Colors.white,
                                  child: widget.patientProfile.image!.isEmpty
                                      ? const Image(image: AssetImage("assets/images/feamleAvatar.png"))
                                      : Image(image: NetworkImage(api().uri + widget.patientProfile.image!))
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const components().text(widget.patientProfile.name, FontWeight.w400, Colors.white, 22)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Material(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: TabBar(
                          controller: _tabController,
                          labelPadding: const EdgeInsets.only(top: 10, bottom: 5),
                          indicator: UnderlineTabIndicator(borderSide: BorderSide(color: colors().logo_darkBlue, width: 2)),
                          onTap: (value) {
                          },
                          tabs: [
                            const components().text("History", FontWeight.bold, colors().logo_darkBlue, 16),
                            const components().text("Prescription", FontWeight.bold, colors().logo_darkBlue, 16),

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.all(15),
                        color: const Color(0xffE7F2FB),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            FutureBuilder(
                              future: api().getHistory(widget.appointmentData.id.toString()),
                              builder: (context, snapshot) {
                                print(snapshot.data);
                                if(snapshot.hasData){
                                  return ListView.separated(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return buildHistory(snapshot.data![index]);
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                  );
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                            StreamBuilder(
                              stream: pre(),
                              builder: (context, snapshot) {
                                print(snapshot.data);
                                if(snapshot.hasData){
                                  return Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body:  Container(
                                      width: double.infinity,
                                      color: const Color(0xffE7F2FB),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const components().text("Symptoms : "+snapshot.data![0].symptoms.toString(), FontWeight.w500, Colors.black, 18),
                                          const components().text("Diagnosis : "+snapshot.data![0].diagnosis.toString(), FontWeight.w500, Colors.black, 18),
                                          const components().text("Test : "+snapshot.data![0].test.toString(), FontWeight.w500, Colors.black, 18),
                                          ...snapshot.data![0].medicines!.map((e) {
                                            return Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.only(bottom: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const components().text(e.name.toString(), FontWeight.w600, colors().logo_darkBlue, 18),

                                                  const SizedBox(height: 5,),
                                                  Row(
                                                    children: [
                                                      const components().text("Quantity: "+e.quantity.toString(), FontWeight.normal, colors().logo_darkBlue, 16),
                                                      const SizedBox(width: 30,),
                                                      const components().text("Days: "+e.duration.toString(), FontWeight.normal, colors().logo_darkBlue, 16),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5,),
                                                  Wrap(
                                                    children: [
                                                      const components().text(e.food.join(" "), FontWeight.w500, colors().logo_darkBlue, 16),
                                                      const SizedBox(width: 30,),
                                                      const components().text(e.daytime.join(" "), FontWeight.w500, colors().logo_darkBlue, 16),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          },)
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Scaffold(
                                  body: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                              },
                            )



                          ],
                        ),
                      ),
                    ),
                  ],
                ),)



            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10)
          ),
          alignment: Alignment.center,
          child: Wrap(
            spacing: 20,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.transparent,
                      elevation: 0.1,
                      enableFeedback: true,
                      side: const BorderSide(
                          width: 1,
                          color: Colors.white
                      ),
                      shape: const CircleBorder()),
                  onPressed: () {
                    setState(() {
                      audio = !audio;
                      if(!audio){
                        signaling.stopAudioOnly();
                      }
                      else{
                        // signaling.startVideoOnly();
                        signaling.startAudioOnly();
                      }
                    });
                  },
                  child: Icon(
                    audio ? Icons.mic : Icons.mic_off_rounded,
                    color: Colors.white,
                    size: 30,
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: speaker? Colors.white : Colors.transparent,
                      elevation: 0.1,
                      enableFeedback: true,
                      side: const BorderSide(
                          width: 1,
                          color: Colors.white
                      ),
                      shape: const CircleBorder()),
                  onPressed: () {
                    setState(() {
                      speaker = !speaker;
                      signaling.speakerPhone();
                      if(speaker){
                        signaling.speakerPhone();
                      }
                      else{
                        signaling.stopSpeakerPhone();
                      }
                    });
                  },
                  child: Icon(
                    Icons.volume_up,
                    color: speaker? Colors.black : Colors.white,
                    size: 30,
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: const Color(0xFFC90000),
                      textStyle: const TextStyle(fontSize: 18),
                      enableFeedback: true,
                      shape: const CircleBorder()),
                  onPressed: () {
                    dispose();
                    signaling.hangUp(_localRenderer);
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.call_end,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget dialog(){

    return StatefulBuilder(
        builder: (context, setState) => Form(
          key: _dialogFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const components().text("Pill Name", FontWeight.w600, Colors.black, 17),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: pillName,
                  validator: (value) {
                    if(value == null || value.isEmpty ){
                      return "";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Color(
                        0x52003879))),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Enter Pill Name",
                    hintStyle: const TextStyle(color: Color(0xff959595)),
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const components().text("Quantity", FontWeight.w600, Colors.black, 17),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: quantity,
                            validator: (value) {
                              if(value == null || value.isEmpty ){
                                return "";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Color(
                                    0x52003879))),
                                enabled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: "Enter Quantity",
                                hintStyle: const TextStyle(color: Color(0xff959595))
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const components().text("How Long", FontWeight.w600, Colors.black, 17),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: duration,
                            validator: (value) {
                              if(value == null || value.isEmpty ){
                                return "";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Color(
                                    0x52003879))),
                                enabled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: "Enter Days",
                                hintStyle: const TextStyle(color: Color(0xff959595))
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 15,),
                const components().text("When to take", FontWeight.w600, Colors.black, 17),
                Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: UnderlineTabIndicator(
                      borderSide: BorderSide(color: foodInvalid ? Colors.red : Colors.transparent )
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        child:  AnimatedContainer(
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: before ? colors().logo_darkBlue : Colors.white
                          ),
                          duration: const Duration(milliseconds: 400),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.fastfood_outlined, color: before ? Colors.white : colors().logo_darkBlue),
                              const SizedBox(height: 5,),
                              Text("Before Food", style: TextStyle(color: before ? Colors.white : colors().logo_darkBlue)),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            before = !before;
                          });
                          print(before);
                        },
                      ),
                      const SizedBox(width: 10,),
                      InkWell(
                        child:  AnimatedContainer(
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: after ? colors().logo_darkBlue : Colors.white
                          ),
                          duration: const Duration(milliseconds: 400),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.fastfood_outlined, color: after ? Colors.white : colors().logo_darkBlue),
                              const SizedBox(height: 5,),
                              Text("After Food", style: TextStyle(color: after ? Colors.white : colors().logo_darkBlue)),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            after = !after;
                          });
                          print(before);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: UnderlineTabIndicator(
                      borderSide: BorderSide(color: dayInvalid ? Colors.red : Colors.transparent )
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        child:  AnimatedContainer(
                          width: MediaQuery.of(context).size.width * 0.22,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: morning ? colors().logo_darkBlue : Colors.white
                          ),
                          duration: const Duration(milliseconds: 400),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sunny, color: morning ? Colors.white : colors().logo_darkBlue),
                              const SizedBox(height: 5,),
                              Text("Morning", style: TextStyle(color: morning ? Colors.white : colors().logo_darkBlue)),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            morning = !morning;
                          });
                          print(before);
                        },
                      ),
                      const SizedBox(width: 5,),
                      InkWell(
                        child:  AnimatedContainer(
                          width: MediaQuery.of(context).size.width * 0.22,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: afternoon ? colors().logo_darkBlue : Colors.white
                          ),
                          duration: const Duration(milliseconds: 400),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.wb_twighlight, color: afternoon ? Colors.white : colors().logo_darkBlue),
                              const SizedBox(height: 5,),
                              Text("Afternoon", style: TextStyle(color: afternoon ? Colors.white : colors().logo_darkBlue)),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            afternoon = !afternoon;
                          });
                          print(before);
                        },
                      ),
                      const SizedBox(width: 5,),
                      InkWell(
                        child:  AnimatedContainer(
                          width: MediaQuery.of(context).size.width * 0.22,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: evening ? colors().logo_darkBlue : Colors.white
                          ),
                          duration: const Duration(milliseconds: 400),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.nights_stay, color: evening ? Colors.white : colors().logo_darkBlue),
                              const SizedBox(height: 5,),
                              Text("Evening", style: TextStyle(color: evening ? Colors.white : colors().logo_darkBlue)),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            evening = !evening;
                          });
                          print(before);
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        )

    );
  }

  Widget buildHistory(history h){
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: UnderlineTabIndicator(borderSide: BorderSide(color: colors().logo_darkBlue), insets: const EdgeInsets.only(left: 0, right: -10)),
            child:  Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.access_time_outlined, color: colors().logo_darkBlue, size: 15),
                const SizedBox(width: 5,),
                const components().text(h.date.toString(), FontWeight.w500, colors().logo_darkBlue, 17),
                const SizedBox(width: 10,),
                const components().text(h.time.toString(), FontWeight.w500, colors().logo_darkBlue, 17)
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  const components().text("Symptoms", FontWeight.normal, Color(0xff7E7878), 16),
                  const components().text(h.symptoms.toString(), FontWeight.w600, Colors.black, 16),
                  const SizedBox(height: 10,),
                  const components().text("Diagnosis", FontWeight.normal, Color(0xff7E7878), 16),
                  const components().text(h.diagnosis.toString(), FontWeight.w600, Colors.black, 16),
                  const SizedBox(height: 10,),
                  const components().text("Medicines", FontWeight.normal, Color(0xff7E7878), 16),
                  ...h.medicines!.map((e) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          components().text(e.name.toString(), FontWeight.w600, colors().logo_darkBlue, 18),

                          SizedBox(height: 5,),
                          Row(
                            children: [
                              components().text("Quantity: "+e.quantity.toString(), FontWeight.normal, colors().logo_darkBlue, 16),
                              SizedBox(width: 30,),
                              components().text("Days: "+e.duration.toString(), FontWeight.normal, colors().logo_darkBlue, 16),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Wrap(
                            children: [
                              components().text(e.food.join(" "), FontWeight.w500, colors().logo_darkBlue, 16),
                              SizedBox(width: 30,),
                              components().text(e.daytime.join(" "), FontWeight.w500, colors().logo_darkBlue, 16),
                            ],
                          )
                        ],
                      ),
                    );
                  },)
                  // const components().text(h.medicines.toString(), FontWeight.w600, Colors.black, 16),
                  // const SizedBox(height: 10,),
                  // const components().text("When to take", FontWeight.normal, Color(0xff7E7878), 16),
                  // const components().text("After lunch", FontWeight.w600, Colors.black, 16)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  const components().text("Test", FontWeight.normal, Color(0xff7E7878), 16),
                  const components().text(h.test.toString(), FontWeight.w600, Colors.black, 16),

                ],
              )
            ],
          ),
        ],
      ),
    );
  }

}