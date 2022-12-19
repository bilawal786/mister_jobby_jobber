import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:mister_jobby_jobber/providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';

class RulesProvider with ChangeNotifier{
  bool rulesCompleted = false;

  String rulesAnswer1 = "";
  String rulesAnswer2 = "";
  String rulesAnswer3 = "";

  int rulesQuestion1 = 0;
  int rulesQuestion2 = 0;
  int rulesQuestion3 = 0;

  void checkRules1Answer(int? value) {
    rulesQuestion1 = value!;
    if(rulesQuestion1 == 1){
      rulesAnswer1 = "I check that i am available on the date and at the time requested by the client.".tr();
    }else if(rulesQuestion1 == 2){
      rulesAnswer1 = "I apply regardless of my schedule. At worst I will be late or I will postpone the job.".tr();
    }
    notifyListeners();
  }

  void checkRules2Answer(int? value) {
    rulesQuestion2 = value!;
    if(rulesQuestion2 == 1){
      rulesAnswer2 = "I apply for the lowest hourly rate but I will ask for a supplement on the spot.".tr();
    }else if(rulesQuestion2 == 2){
      rulesAnswer2 = "I apply an hourly rate that corresponds to my skills and my equipment.".tr();
    }
    notifyListeners();
  }

  void checkRules3Answer(int? value) {
    rulesQuestion3 = value!;
    if(rulesQuestion3 == 1){
      rulesAnswer3 = "I ask my client to shift the job according to my schedule.".tr();
    }else if(rulesQuestion3 == 2){
      rulesAnswer3 = "I apply only to jobs for which I am available and competent.".tr();
    }
    notifyListeners();
  }

  bool reservedJobsMisterJobby = false;
  bool mustPerformServices = false;
  bool cashNotRequired = false;

  void checkStatusReserved(value) {
    reservedJobsMisterJobby = value;
    notifyListeners();
  }

  void checkMustPerformServices(value) {
    mustPerformServices = value;
    notifyListeners();
  }

  void checkCashRequiredStatus(value) {
    cashNotRequired = value;
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
      Provider.of<CheckProfileCompletionProvider>(context,listen: false).getProfileCompletionData(context);
      debugPrint(response.body);
      debugPrint("rules availability api is working");
      Navigator.pop(context);
      Navigator.of(context)
          .popUntil(ModalRoute.withName(MyRoutes.MANDATORYSTEPSSCREENROUTE));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Learn Rules Completed',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
      rulesCompleted = true;
      notifyListeners();
    } else if(response.statusCode == 401){
      debugPrint('error: 401');
      Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.LOGINSCREENROUTE, (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content:  Text(
            'Session Expired...  Please Log-In',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    } else{
      debugPrint(response.body);
      debugPrint("rules availability api not working ");
    }
    notifyListeners();
  }
}