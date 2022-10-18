import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';

class AvailabilityProvider with ChangeNotifier {

  Future<void> postAvailability (monday, tuesday, wednesday, thursday, friday, saturday, sunday,) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/skills/one'),
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
      print(response.body);
      print("time availability api is working");
    }else{
      print(response.body);
      print("time availability api not working ");
    }
  }
}