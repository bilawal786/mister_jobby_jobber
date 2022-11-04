import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:mister_jobby_jobber/providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';

class RulesProvider with ChangeNotifier{
  bool rulesCompleted = false;
  int rulesQuestion1 = 0;
  int rulesQuestion2 = 0;
  int rulesQuestion3 = 0;

  void checkRules1Answer(int? value) {
    rulesQuestion1 = value!;
    notifyListeners();
  }

  void checkRules2Answer(int? value) {
    rulesQuestion2 = value!;
    notifyListeners();
  }

  void checkRules3Answer(int? value) {
    rulesQuestion3 = value!;
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

  Future<void> postRules (context, rule1, rule2, rule3, rule4,) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/rules'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': "Bearer $userToken",
      },
      body: jsonEncode(<String, String>{
        'rules1': rule1.toString(),
        'rules2': rule2.toString(),
        'rules3': rule3.toString(),
        'rules4': rule4.toString(),
      }),
    );

    if(response.statusCode == 200) {
      Provider.of<CheckProfileCompletionProvider>(context,listen: false).getProfileCompletionData();
      debugPrint(response.body);
      debugPrint("rules availability api is working");
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed(MyRoutes.SPLASHSCREENROUTE);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Learn Rules Completed',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      rulesCompleted = true;
      notifyListeners();
    }else{
      debugPrint(response.body);
      debugPrint("rules availability api not working ");
    }
    notifyListeners();
  }
}