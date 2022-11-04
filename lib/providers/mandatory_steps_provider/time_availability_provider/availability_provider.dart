import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';
import '../../check_profile_completion_provider/check_profile_completion_provider.dart';

class AvailabilityProvider with ChangeNotifier {

  bool availabilityCompleted = false;

  Future<void> postAvailability (context,monday, tuesday, wednesday, thursday, friday, saturday, sunday,) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
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
      Provider.of<CheckProfileCompletionProvider>(context, listen: false)
          .getProfileCompletionData();
      debugPrint("time availability api is working");
      Navigator.pop(context);
      Navigator.of(context)
          .popUntil(ModalRoute.withName(MyRoutes.MANDATORYSTEPSSCREENROUTE));
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
      Navigator.pop(context);
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