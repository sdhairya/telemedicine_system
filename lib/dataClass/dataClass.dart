import 'dart:core';

import 'dataClass.dart';
import 'dataClass.dart';

class profile{

  String name = "";
  String email = "";
  String gender = "";
  String password = "";
  String? image = "";

  profile(
      {required this.name, required this.email, required this.gender, required this.password, required this.image});

  @override
  String toString() {
    return "$name\n$email\n$gender\n$password\n$image";
  }

}

class doctorProfile{

  String id = "";
  String name = "";
  String phone = "";
  String degree = "";
  String speciality = "";
  String facility = "";
  String otherachivement = "";
  String description = "";
  String experience = "";
  String image = "";
  String fees = "";
  String mode = "";

  doctorProfile(
      {required this.id, required this.name, required this.phone, required this.degree, required this.speciality, required this.facility, required this.otherachivement, required this.description,required this.experience, required this.image, required this.fees, required this.mode});

  @override
  String toString() {
    return "$id\n$name\n$degree\n$phone\n$facility\n$experience\n$image";
  }

}

class bookDoctor{

  String name = "";
  String degree = "";
  String facility = "";
  String experience = "";
  String image = "";

  bookDoctor(
      {required this.name, required this.degree, required this.facility, required this.experience, required this.image});

  @override
  String toString() {
    return "$name\n$degree\n$facility\n$experience\n$image";
  }

}

class appointmentSlots{

  List<String> morningSlots = [];
  List<String> afternoonSlots = [];
  List<String> eveningSlots = [];
  facility morningFacility = facility(id: 0, name: "name", address: "address", phone: "phone");
  facility afternoonFacility = facility(id: 0, name: "name", address: "address", phone: "phone");
  facility eveningFacility = facility(id: 0, name: "name", address: "address", phone: "phone");


  appointmentSlots(
      {required this.morningSlots, required this.afternoonSlots, required this.eveningSlots, required this.morningFacility, required this.afternoonFacility, required this.eveningFacility});

  @override
  String toString() {
    return "$morningSlots\n$afternoonSlots\n$eveningSlots\n$morningFacility\n$afternoonFacility\n$eveningFacility";
  }

}

class facility{

  int id = 0;
  String name = "";
  String address = "";
  String phone = "";

  facility(
      {required this.id, required this.name, required this.address, required this.phone});

  @override
  String toString() {
    return "$id\n$name\n$address\n$phone";
  }

}
class appointment{

  String id = "";
  String image = "";
  String name = "";
  String date = "";
  String time = "";
  String mode = "";
  String address = "";
  int fees = 0;
  String status = "";
  String link = "";

  appointment({
    required this.id, required this.image, required this.name, required this.date, required this.time, required this.mode, required this.address, required this.fees, required this.status, required this.link
  });

  @override
  String toString() {
    return "$id\n$name\n$date\n$time\n$mode";
  }
}
class appointmentData{

  String patient_id = "";
  String doctor_id = "";
  String patient_phone = "";
  String doctor_phone = "";
  int facility_id = 0;
  String date = "";
  String time = "";
  String consultationMode = "";
  String fees = "";
  String link = "";

  appointmentData(
      {required this.patient_id, required this.doctor_id, required this.patient_phone, required this.doctor_phone, required this.facility_id, required this.date, required this.time, required this.consultationMode, required this.fees, required this.link});

  @override
  String toString() {
    return "$patient_id\n$doctor_phone\n$facility_id\n$date\n$time\n$consultationMode\n$fees";
  }


}

class medicine{

  String? name = "";
  int? quantity = 0;
  int? duration = 0;
  List<String?> food = [];
  List<String?> daytime = [];

  medicine(
      {required this.name, required this.quantity, required this.duration, required this.food, required this.daytime});

  @override
  String toString() {
    return "$name\n$quantity\n$duration\n$food\n$daytime";
  }

  Map toJson() {
    return {'name': name, 'quantity': quantity, 'duration': duration, 'food': food, 'daytime': daytime};
  }

}

class prescription{

  String? symptoms = "";
  String? test = "";
  String? diagnosis = "";
  List<medicine>? medicines = [];

  prescription(
      {required this.symptoms, required this.test, required this.diagnosis, required this.medicines});

  @override
  String toString() {
    return "$symptoms\n$test\n$diagnosis\n$medicines";
  }

}

