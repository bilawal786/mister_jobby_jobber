import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';


class ServicesProvider with ChangeNotifier {

  bool servicesCompleted = false;

  Future<void> postProgressServices (context,answer1,answer2, answer3, answer4,) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/progress/service'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': "Bearer $userToken",
      },
      body: jsonEncode(<String, String>{
        'answer1': answer1.toString(),
        'answer2': answer2.toString(),
        'answer3': answer3.toString(),
        'answer4': answer4.toString(),
      }),
    );

    if(response.statusCode == 200) {
      print(response.body);
      print("services availability api is working");
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed(MyRoutes.MANDATORYSTEPSSCREENROUTE);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Services Completed',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      servicesCompleted = true;
      notifyListeners();
    }else{
      Navigator.pop(context);
      print(response.body);
      print("services availability api not working ");
    }
    notifyListeners();
  }
}