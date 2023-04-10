import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemedicine_system/dataClass/dataClass.dart';

class api {
  String uri = 'http://192.168.1.9:5024/';

  Future<List<String>> login(String phone, String password) async {
    String url = uri + "api/users/login";
    var res = await http.post(Uri.parse(url),
        body: json.encode({"phone": phone, "password": password}),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        encoding: Encoding.getByName('utf-8'));
    print(res.statusCode);

    var ack = json.decode(res.body);
    var a = ack.toString().split(",");
    print(a);
    if (int.parse(a[1].toString()) is int) {

      SharedPreferences.getInstance().then(
            (prefs) {
          prefs.setString('patient_id', a[1].toString());
        },
      );

      return a;
    } else if (a[0] == "First time") {
      return a;
    } else {
      return a;
    }
  }

  Future<List<profile>> profiledetails(String id) async {

    String url = uri + "api/users/byid?id=" + id;
    var res = await http.get(Uri.parse(url));
    var responseData = json.decode(res.body);

    // print(responseData);
    List<profile> profileData = [];

    appointment? app;

    if(responseData[0]["getappointment"]["name"] == null){
      app = null;
    }
    else{
      app=  appointment(id: responseData[0]["getappointment"]["id"], image: responseData[0]["getappointment"]["image"],gender: responseData[0]["getappointment"]["gender"], name: responseData[0]["getappointment"]["name"], date: responseData[0]["getappointment"]["date"], time: responseData[0]["getappointment"]["time"], mode: responseData[0]["getappointment"]["mode"], address: responseData[0]["getappointment"]["address"], fees: responseData[0]["getappointment"]["fees"], status: "status", link: responseData[0]["getappointment"]["link"]);

    }

    profileData.add(profile(
        name: responseData[0]["name"],
        email: responseData[0]["email"],
        gender: responseData[0]["gender"],
        password: responseData[0]["password"],
        image: responseData[0]["image"],
      app: app
    )
    );
    // print(profileData);
    return profileData;
  }

  Future<List<String>> getTags() async {
    var url = "api/doctors/tags";
    var res = await http.get(Uri.parse(uri + url));
    var data = json.decode(res.body);
    List<String> d = [];
    for (var i = 0; i < data.length; i++) {
      data[i]["tags"].contains(",")
          ? d.addAll(data[i]["tags"].split(","))
          : d.add(data[i]["tags"]);
    }
    return d;
  }

  Future<String> addUser(String otp, createProfile data) async {
    String url = uri + "api/users";
    var res = await http.post(Uri.parse(url),
        body: json.encode({
          "name":data.name,
          "email":data.email,
          "phone": data.phone,
          "gender": data.gender,
          "dob":data.dob.substring(0,10),
          "password": data.password,
          "otp":otp
        }),
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
        encoding: Encoding.getByName('utf-8'));

    print(res.statusCode);
    print(res.body);
    return res.body;

  }

  Future<String> sendOtp(String phone) async {
    print(phone);
    var url = "api/users/send-sms?phone=" + phone;
    var res = await http.post(Uri.parse(uri + url),
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
        encoding: Encoding.getByName('utf-8'));

    print(res.statusCode);
    return res.body;
  }

  Future<String> forgotPassword(String phone, int otp, String password) async {
    var url = "api/users/forgot";
    var res = await http.put(Uri.parse(uri + url),
        body: json.encode({
          "phone":phone,
          "otp":otp,
          "password":password
        }),
        headers: {
          "Accept": "application/json",
          "content-type":"application/json"
        },
        encoding: Encoding.getByName('utf-8'));

    print(json.decode(res.body));
    return json.decode(res.body);
  }


  Future<List<doctorProfile>> getDoctorsTags(String tag) async {
    var url = "api/doctors/name?tag=" + tag;
    var res = await http.get(Uri.parse(uri + url));
    var data = json.decode(res.body);
    // print(data);
    List<doctorProfile> doctor = [];
    for (var i in data) {
      doctor.add(doctorProfile(
          id: i["user_id"].toString(),
          name: i["name"],
          phone: i["phone"],
          degree: i["degree"],
          facility: i["facility_name"].toString(),
          experience: i["experience"].toString(),
          image: i["image"],
          speciality: i["speciality"],
          description: i["description"],
          otherachivement: i["otherachivement"],
          fees: i["fees"].toString(),));
      // doctor.add(doctorProfile(name: data[i]["name"], degree: data[i]["degree"], facility: data[i]["facility_name"], experience: data[i]["experience"].toString(), image: data[i]["image"], ));
    }
    print(doctor);
    return doctor;
  }

  Future<List<List<doctorProfile>>> getDoctorsDegree(String degree) async {
    var url = "api/doctors/bydegree?degree=" + degree;
    var res = await http.get(Uri.parse(uri + url));
    var data = json.decode(res.body);
    print(data);
    List<List<doctorProfile>> d = [];
    List<doctorProfile> online = [];
    List<doctorProfile> offline = [];
    // d.add(doctorProfile(name: data[0]["name"], degree: data[0]["degree"], speciality: data[0]["speciality"], facility: data[0]["facility"], otherachivement: data[0]["otherachivement"], description: data[0]["description"], experience: data[0]["experience"], image: data[0]["image"]));

    for (var i in data) {
      if (i["mode"] == "both") {
        online.add(doctorProfile(
          id: i["id"].toString(),
            name: i["name"],
            phone: i["phone"],
            degree: i["degree"],
            facility: i["facility"],
            experience: i["experience"].toString(),
            image: i["image"],
            speciality: i["speciality"],
            description: i["description"],
            otherachivement: i["otherachivement"],
            fees: i["fees"].toString(),
            ));
        offline.add(doctorProfile(
            id: i["id"].toString(),
            name: i["name"],
            phone: i["phone"],
            degree: i["degree"],
            facility: i["facility"],
            experience: i["experience"].toString(),
            image: i["image"],
            speciality: i["speciality"],
            description: i["description"],
            otherachivement: i["otherachivement"],
            fees: i["fees"].toString(),
           ));
      } else if (i["mode"] == "online") {
        online.add(doctorProfile(
            id: i["id"].toString(),
            name: i["name"],
            phone: i["phone"],
            degree: i["degree"],
            facility: i["facility"],
            experience: i["experience"].toString(),
            image: i["image"],
            speciality: i["speciality"],
            description: i["description"],
            otherachivement: i["otherachivement"],
            fees: i["fees"].toString(),
           ));
      } else if (i["mode"] == "offline") {
        offline.add(doctorProfile(
            id: i["id"].toString(),
            name: i["name"],
            phone: i["phone"],
            degree: i["degree"],
            facility: i["facility"],
            experience: i["experience"].toString(),
            image: i["image"],
            speciality: i["speciality"],
            description: i["description"],
            otherachivement: i["otherachivement"],
            fees: i["fees"].toString(),
            ));
      }
      // d.add(doctorProfile(name: i["name"], degree: i["degree"],facility: i["facility"],experience: i["experience"].toString(), image: i["image"], speciality: i["speciality"], description: i["description"], otherachivement:  i["otherachivement"], fees: i["fees"].toString(), mode: i["mode"]));
    }
    d.add(online);
    d.add(offline);
    print(d);
    return d;
  }

  Future<List<String>> getDoctorCategories() async {
    var url = "api/doctors/degree";
    var res = await http.get(Uri.parse(uri + url));
    var data = json.decode(res.body);
    // print(data);
    List<String> d = [];
    for (var i = 0; i < data.length; i++) {
      d.add(data[i]["degree"]);
    }
    final categories = {...d}.toList();
    return categories;
  }

  Future<String> updateProfile(profile data, String id) async {
    var url = "api/users?id=" + id;
    var request = http.MultipartRequest('PUT', Uri.parse(uri + url));

    request.fields.addAll({
      "name": data.name,
      "email": data.email,
      "gender": data.gender,
      "password": data.password,
      // "image":Image
    });
    if (data.image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', data.image!));
    }
    var response = await request.send();

    print(response.statusCode);
    // print(response.body);
    return "Success";
  }

  Future<List<appointmentSlots>> getSlots(String id, String day, String mode) async {
    var url =
        "api/scheduler/slots?id=" + id + "&day=" + day + "&mode=" + mode;
    var res = await http.get(Uri.parse(uri + url));
    var data = json.decode(res.body);
    print(data);
    List<appointmentSlots> d = [];

    print(data[0]["afternoonFacility"]["name"].toString());
    d.add(appointmentSlots(
      morningSlots: data[0]["morning"].toString().split(","),
      afternoonSlots: data[0]["afternoon"].toString().split(","),
      eveningSlots: data[0]["evening"].toString().split(","),
      // morningFacility: facility(id: 0, name: "name", address: "address", phone: "phone"),
      // afternoonFacility: facility(id: 0, name: "name", address: "address", phone: "phone"),
      // eveningFacility: facility(id: 0, name: "name", address: "address", phone: "phone")
      morningFacility: facility(
          id: int.parse(data[0]["morningFacility"]["id"].toString()),
          name: data[0]["morningFacility"]["name"].toString(),
          address: data[0]["morningFacility"]["address"].toString(),
          phone: data[0]["morningFacility"]["phone"].toString()),
      afternoonFacility: facility(
          id: int.parse(data[0]["afternoonFacility"]["id"].toString()),
          name: data[0]["afternoonFacility"]["name"].toString(),
          address: data[0]["afternoonFacility"]["address"].toString(),
          phone: data[0]["afternoonFacility"]["phone"].toString()),
      eveningFacility: facility(
          id: int.parse(data[0]["eveningFacility"]["id"].toString()),
          name: data[0]["eveningFacility"]["name"].toString(),
          address: data[0]["eveningFacility"]["address"].toString(),
          phone: data[0]["eveningFacility"]["phone"].toString()),
    ));

    // print(d);
    return d;
  }

  Future<int> scheduleAppointment(List<profile> data, doctorProfile doctorData, appointmentData appointment_data) async {
    var url = "api/Appointment?id=" +
        appointment_data.patient_id +
        "&drid=" +
        appointment_data.doctor_id +
        "&c_mode="+appointment_data.consultationMode;
        // + appointment_data[0].consultationMode;
    var request = await http.post(Uri.parse(uri + url),
        body: json.encode({
          "facilities_id": appointment_data.facility_id,
          "date": appointment_data.date,
          "time": appointment_data.time,
          "fees": appointment_data.fees,
          "link": appointment_data.link,
          "status": "Pending"
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        encoding: Encoding.getByName('utf-8'));
    print(request.statusCode);
    print(request.body);

    return request.statusCode;
  }

  Future<List<appointment>> getAppointments(String id) async {
    var url = "api/users/getappointment?id=" + id;
    var res = await http.get(Uri.parse(uri + url));
    var data = json.decode(res.body);
    print(id);
    List<appointment> appointments = [];
    for (var i in data) {
      appointments.add(
          appointment(id: i["id"],image: i["image"], name: i["name"], date: i["date"].toString(),gender: i["gender"], time: i["time"].toString(), mode: i["mode"], address: i["address"], fees: int.parse(i["fees"].toString()), status: i["status"], link: i["link"])
      );
    }
    print(appointments);
    return appointments;
  }

  Future<List<prescription>> getPrescription(String id) async {
    // print(id);
    var url = "api/prescription/byid?id=" + id;
    var res = await http.get(Uri.parse(uri + url));
    var data = json.decode(res.body);
    // print(data);
    List<prescription> pre = [];
    for (var i in data) {
      // getMedicines(i["medicines"]);
      if(i["medicines"] == null){
        pre.add(prescription(symptoms: i["symptoms"], test: i["test"], diagnosis: i["diagnosis"], medicines: []));
      }
      else{
        pre.add(prescription(symptoms: i["symptoms"], test: i["test"], diagnosis: i["diagnosis"], medicines: getMedicines(i["medicines"])));

      }
      // pre[i].medicines = getMedicines(i["medicines"]);

    }
    // print(pre);
    return pre;
  }

  List<medicine> getMedicines(data) {

    List<medicine> m = [];
    for(var i in data){
      m.add(medicine(name: i["name"], quantity: int.parse(i["quantity"].toString()), duration: int.parse(i["duration"].toString()), food: (i['food'] as List).map((item) => item as String?).toList(), daytime: (i['daytime'] as List).map((item) => item as String?).toList()));
    }
    return m;

  }

  Future<List<String>> getDocData(String id) async {
    var url = "api/doctors/drview?id=" + id;
    var res = await http.get(Uri.parse(uri + url));
    var response = json.decode(res.body);
    List<String> data = [];
    data.add(response[0]["totalpatients"].toString());
    data.add(response[0]["review"].toString());
    return data;
  }

}
