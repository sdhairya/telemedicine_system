import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:telemedicine_system/apis/api.dart';
import 'package:telemedicine_system/dashboardScreen/dashboardScreen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../colors.dart';
import '../components.dart';
import '../dataClass/dataClass.dart';
import '../signaling.dart';

class body extends StatefulWidget {

  final List<profile> data;
  final doctorProfile doctorData;
  final appointmentData appointment_data;
  const body({Key? key, required this.data, required this.doctorData, required this.appointment_data}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  Razorpay _razorpay = Razorpay();



  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print(response.orderId.toString()+"\n"+response.paymentId.toString()+"\n"+response.signature.toString());
    print("Payment Success");
    var roomId = await signaling.createRoom(widget.doctorData.name, widget.doctorData.phone,widget.appointment_data.consultationMode);
    widget.appointment_data.link = roomId;
    print(widget.appointment_data.link);
    var res = await api().scheduleAppointment(widget.data, widget.doctorData, widget.appointment_data);
    if(res == 200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: components().text("Appointment Applied", FontWeight.w500, Colors.white, 18),));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => dashboardScreen(id: widget.appointment_data.patient_id),));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: components().text("Appointment not scheduled", FontWeight.w500, Colors.white, 18),));
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print("Payment Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 0),
            child: ListTile(
              leading: components().backButton(context),
              title: components().text(
                  "Confirm Booking Details", FontWeight.w500, Colors.black, 24),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.black,
                ),
                components().text("Patient Name", FontWeight.normal, Colors.black54, 21),
                components().text(widget.data[0].name, FontWeight.w500, Colors.black, 22),
                SizedBox(height: 20,),
                components().text("Patient Mobile No.", FontWeight.normal, Colors.black54, 21),
                components().text(widget.appointment_data.patient_phone, FontWeight.w500, Colors.black, 22),
                SizedBox(height: 10,),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(height: 10,),
                components().text("Doctor Name", FontWeight.normal, Colors.black54, 21),
                components().text(widget.doctorData.name, FontWeight.w500, Colors.black, 22),
                SizedBox(height: 20,),
                components().text("Hospital Name", FontWeight.normal, Colors.black54, 21),
                components().text(widget.doctorData.facility, FontWeight.w500, Colors.black, 22),
                SizedBox(height: 10,),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(height: 10,),
                components().text("Appointment Date & Time", FontWeight.normal, Colors.black54, 21),
                Wrap(
                  children: [
                    components().text(widget.appointment_data.date, FontWeight.w500, Colors.black, 20),
                    SizedBox(width: 20,),
                    components().text(widget.appointment_data.time, FontWeight.w500, Colors.black, 20),
                  ],
                ),
                SizedBox(height: 20,),
                components().text("Mode of Consultancy", FontWeight.normal, Colors.black54, 21),
                components().text(widget.appointment_data.consultationMode, FontWeight.w500, Colors.black, 22),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colors().logo_darkBlue,
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: components().text("Save", FontWeight.w500, Colors.white, 22),
            onPressed: () async {
              // print(widget.appointment_data);

              var options = {
                'key': 'rzp_test_E9IoanWYW4rL1k',
                'amount': (int.parse(widget.appointment_data.fees) * 100).toString(), //in the smallest currency sub-unit.
                'name': widget.data[0].name,// Generate order_id using Orders API
                'description': 'Appointment',
                'timeout': 300, // in seconds
                'prefill': {
                  'contact': '9123456789',
                  'email': 'telemedicine@xyz.com'
                }
              };
              _razorpay.open(options);

            }
          ),
        ),
      ),
    );
  }
}
