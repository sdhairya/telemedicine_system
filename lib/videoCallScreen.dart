import 'dart:async';

import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:telemedicine_system/apis/api.dart';
import 'package:telemedicine_system/signaling.dart';

import 'colors.dart';
import 'components.dart';
import 'dataClass/dataClass.dart';

class callScreen extends StatefulWidget {
  final String roomId;
  final String role;
  final appointment appointmentData;

  // final RTCVideoRenderer localRenderer;
  // final RTCVideoRenderer remoteRenderer;

  const callScreen({Key? key, required this.roomId, required this.role, required this.appointmentData})
      : super(key: key);

  @override
  State<callScreen> createState() => _callScreenState();
}

class _callScreenState extends State<callScreen> with SingleTickerProviderStateMixin {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool audio = true;
  bool video = true;

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
  bool timerStart = false;
  late TabController _tabController = TabController(length: 2, vsync: this);
  final _dialogFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {
        timerStart = true;
        _start();
      });
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
    await signaling.openUserMedia(_localRenderer, _remoteRenderer, true, true);
    print("opened");
    print(widget.role);

    if (widget.role == "host") {
      signaling.joinCaller(
        widget.roomId,
        _remoteRenderer,
        "Video"
      );
      print("=======================");
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
      await Future.delayed(Duration(milliseconds: 500));
      List<prescription> pres = await api().getPrescription(widget.appointmentData.id.toString());
      yield pres;
    }
  }

  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _result = '00:00:00';
  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {
        _result =
        '${_stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
    _stopwatch.start();
  }

  @override
  Widget build(BuildContext context) {
    // setState((){signaling.openUserMedia(_localRenderer, _remoteRenderer);});
    // signaling.joinRoom(
    //   widget.roomId,
    //   _remoteRenderer,
    // );
    print(_remoteRenderer.value);
    final dragController = DragController();
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.black),
              child: RTCVideoView(_remoteRenderer)),

          Align(
            alignment: Alignment.bottomCenter,
            child:  Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      components().text(widget.appointmentData.name!, FontWeight.w600, Colors.white, 24),
                      components().text(timerStart ? _result : "Wating" , FontWeight.w600, Colors.white, 24),
                    ],
                  ),
                  Divider(color: Colors.white38),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.white,
                              enableFeedback: true,
                              shape: CircleBorder()),
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
                            color: Colors.black,
                            size: 30,
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 18),
                              enableFeedback: true,
                              shape: CircleBorder()),
                          onPressed: () {
                            setState(() {
                              video = !video;

                              if(!video){
                                signaling.stopVideoOnly();
                              }
                              else{
                                // signaling.startVideoOnly();
                                signaling.startVideoOnly();
                              }
                            });


                          },
                          child: Icon(
                            video ? Icons.videocam : Icons.videocam_off,
                            color: Colors.black,
                            size: 30,
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Color(0xFFC90000),
                              textStyle: TextStyle(fontSize: 18),
                              enableFeedback: true,
                              shape: CircleBorder()),
                          onPressed: () {
                            showCupertinoModalBottomSheet(
                                expand: false,
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (context) => Material(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(height: MediaQuery.of(context).size.height * 0.3, color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AspectRatio(aspectRatio: 5/8, child: Container(child: RTCVideoView(_localRenderer)),),
                                              SizedBox(width: 10,),
                                              AspectRatio(aspectRatio: 5/8, child: Container(child: RTCVideoView(_remoteRenderer)),),
                                            ],
                                          )),
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
                                                color: Color(0xffE7F2FB),
                                                child: TabBarView(
                                                  controller: _tabController,
                                                  children: [
                                                    SingleChildScrollView(
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
                                                                const components().text("13-03-2023", FontWeight.w500, colors().logo_darkBlue, 17),
                                                                const SizedBox(width: 10,),
                                                                const components().text("1:00", FontWeight.w500, colors().logo_darkBlue, 17)
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
                                                                  const components().text("Normal Headache", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Diagnosis", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Viral", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Medicines", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Paracetamol 250mg * Tablet", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("When to take", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("After lunch", FontWeight.w600, Colors.black, 16)
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Test", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Not needed", FontWeight.w600, Colors.black, 16),

                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(height: 10,),
                                                          const Divider(),
                                                          Container(
                                                            decoration: UnderlineTabIndicator(borderSide: BorderSide(color: colors().logo_darkBlue), insets: const EdgeInsets.only(left: 0, right: -10)),
                                                            child:  Wrap(
                                                              crossAxisAlignment: WrapCrossAlignment.center,
                                                              children: [
                                                                Icon(Icons.access_time_outlined, color: colors().logo_darkBlue, size: 15),
                                                                const SizedBox(width: 5,),
                                                                const components().text("13-03-2023", FontWeight.w500, colors().logo_darkBlue, 17),
                                                                const SizedBox(width: 10,),
                                                                const components().text("1:00", FontWeight.w500, colors().logo_darkBlue, 17)
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
                                                                  const components().text("Normal Headache", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Diagnosis", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Viral", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Medicines", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Paracetamol 250mg * Tablet", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("When to take", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("After lunch", FontWeight.w600, Colors.black, 16)
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Test", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Not needed", FontWeight.w600, Colors.black, 16),

                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(height: 10,),
                                                          const Divider(),
                                                          Container(
                                                            decoration: UnderlineTabIndicator(borderSide: BorderSide(color: colors().logo_darkBlue), insets: const EdgeInsets.only(left: 0, right: -10)),
                                                            child:  Wrap(
                                                              crossAxisAlignment: WrapCrossAlignment.center,
                                                              children: [
                                                                Icon(Icons.access_time_outlined, color: colors().logo_darkBlue, size: 15),
                                                                const SizedBox(width: 5,),
                                                                const components().text("13-03-2023", FontWeight.w500, colors().logo_darkBlue, 17),
                                                                const SizedBox(width: 10,),
                                                                const components().text("1:00", FontWeight.w500, colors().logo_darkBlue, 17)
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
                                                                  const components().text("Normal Headache", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Diagnosis", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Viral", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Medicines", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Paracetamol 250mg * Tablet", FontWeight.w600, Colors.black, 16),
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("When to take", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("After lunch", FontWeight.w600, Colors.black, 16)
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const SizedBox(height: 10,),
                                                                  const components().text("Test", FontWeight.normal, Color(0xff7E7878), 16),
                                                                  const components().text("Not needed", FontWeight.w600, Colors.black, 16),

                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(height: 10,),
                                                          const Divider()
                                                        ],
                                                      ),
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
                                                                  components().text("Symptoms : "+snapshot.data![0].symptoms.toString(), FontWeight.w500, Colors.black, 18),
                                                                  components().text("Diagnosis : "+snapshot.data![0].diagnosis.toString(), FontWeight.w500, Colors.black, 18),
                                                                  components().text("Test : "+snapshot.data![0].test.toString(), FontWeight.w500, Colors.black, 18),
                                                                  ...snapshot.data![0].medicines!.map((e) {
                                                                    return Container(
                                                                      padding: EdgeInsets.all(10),
                                                                      margin: EdgeInsets.only(bottom: 5),
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
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
                                ));
                          },
                          child: Icon(
                            Icons.medication,
                            size: 30,
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Color(0xFFC90000),
                              textStyle: TextStyle(fontSize: 18),
                              enableFeedback: true,
                              shape: CircleBorder()),
                          onPressed: () {
                            dispose();
                            signaling.hangUp(_localRenderer);
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.call_end,
                            size: 30,
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
         ,
          DraggableWidget(
            bottomMargin: MediaQuery.of(context).size.height * 0.15,
            topMargin: 20,
            horizontalSpace: 20,
            intialVisibility: true,
            shadowBorderRadius: 50,
            child: Container(
              height: 213,
              width: 120,
              child: RTCVideoView(_localRenderer),
            ),
            initialPosition: AnchoringPosition.topRight,
            dragController: dragController,
          )
        ],
      ),
    ));
  }
}
