import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:telemedicine_system/signaling.dart';

import 'components.dart';

class audiCallScreen extends StatefulWidget {

  final String roomId;
  final String role;

  const audiCallScreen({Key? key, required this.roomId, required this.role}) : super(key: key);

  @override
  State<audiCallScreen> createState() => _audiCallScreenState();
}

class _audiCallScreenState extends State<audiCallScreen> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool audio = true;
  bool speaker = false;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration:BoxDecoration(
              image:DecorationImage(image:AssetImage("assets/images/gradient.png"), fit:BoxFit.fill)
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 100),child: components().text("Name", FontWeight.normal, Colors.white, 35),),
              Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 7,
                child: Wrap(
                  spacing: 20,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.transparent,
                            elevation: 0.1,
                            enableFeedback: true,
                            side: BorderSide(
                                width: 1,
                                color: Colors.white
                            ),
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
                          color: Colors.white,
                          size: 35,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: speaker? Colors.white : Colors.transparent,
                            elevation: 0.1,
                            enableFeedback: true,
                            side: BorderSide(
                                width: 1,
                                color: Colors.white
                            ),
                            shape: CircleBorder()),
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
                          Icons.speaker_phone,
                          color: speaker? Colors.black : Colors.white,
                          size: 35,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
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
                        ))
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
