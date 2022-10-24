import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';

class InsuranceProvider with ChangeNotifier {

  bool insuranceCompleted = false;

  int insuranceQuestion1 = 0;
  int insuranceQuestion2 = 0;
  int insuranceQuestion3 = 0;

  void checkInsurance1Answer(int? value) {
    insuranceQuestion1 = value!;
    notifyListeners();
  }

  void checkInsurance2Answer(int? value) {
    insuranceQuestion2 = value!;
    notifyListeners();
  }

  void checkInsurance3Answer(int? value) {
    insuranceQuestion3 = value!;
    notifyListeners();
  }

  bool reservedJobsMisterJobby = false;
  bool mustPerformServices = false;

  void checkStatusReserved(value) {
    reservedJobsMisterJobby = value;
    notifyListeners();
  }

  void checkMustPerformServices(value) {
    mustPerformServices = value;
    notifyListeners();
  }

  Future<void> postInsurance (context, insurance1, insurance2, insurance3, insurance4,) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/insurance'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': "Bearer $userToken",
      },
      body: jsonEncode(<String, String>{
        'insurance1': insurance1.toString(),
        'insurance2': insurance2.toString(),
        'insurance3': insurance3.toString(),
        'insurance4': insurance4.toString(),
      }),
    );

    if(response.statusCode == 200) {
      print(response.body);
      print("Insurance availability api is working");
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed(MyRoutes.MANDATORYSTEPSSCREENROUTE);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Insurance Completed',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      insuranceCompleted = true;
      notifyListeners();
    }else{
      Navigator.pop(context);
      print(response.body);
      print("Insurance availability api not working ");
    }
    notifyListeners();
  }
}