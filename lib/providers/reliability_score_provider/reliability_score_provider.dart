import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';

class ReliabilityScoreProvider  with ChangeNotifier{

  Future<void> reliabilityScore(int score) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/score'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': "Bearer $userToken",
      },
      body: jsonEncode(<String, int>{
        'score': score,
      }),
    );
    if(response.statusCode == 200){
      debugPrint("reliability score api is working");
    }else{
      debugPrint("reliability score api is not working");
    }

    notifyListeners();
  }

}