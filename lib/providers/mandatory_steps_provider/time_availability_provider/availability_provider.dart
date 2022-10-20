import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';

class AvailabilityProvider with ChangeNotifier {

  bool availabilityCompleted = false;

  Future<void> postAvailability (context,monday, tuesday, wednesday, thursday, friday, saturday, sunday,) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/timing'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': "Bearer $userToken",
      },
      body: jsonEncode(<String, String>{
        'monday' : monday,
        'tuesday' : tuesday,
        'wednesday': wednesday,
        'thersday': thursday,
        'friday' : friday,
        'saturday': saturday,
        'sunday' : sunday,
      }),
    );
    if(response.statusCode == 200) {
      debugPrint(response.body);
      debugPrint("time availability api is working");
      Navigator.of(context).pushReplacementNamed(MyRoutes.SPLASHSCREENROUTE);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Time Availability Completed',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      availabilityCompleted = true;
      notifyListeners();
    }else{
      debugPrint(response.body);
      debugPrint("Time availability api not working ");
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Time Availability Failed',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
    }
    notifyListeners();
  }
}