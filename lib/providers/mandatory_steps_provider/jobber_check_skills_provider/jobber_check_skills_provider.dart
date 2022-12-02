import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../models/mandatory_steps_model/indicate_skills_model/jobber_check_skills_model.dart';

class JobberCheckSkillsProvider with ChangeNotifier {
  JobberCheckSkillModel? jobberCheckSkills;

  var checkApi = false;

  Future<void> getCheckSkills(context) async{
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(
      Uri.parse('${MyRoutes.BASEURL}/jobber/check/skills'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': 'Bearer $userToken',
      },
    );
    if(response.statusCode == 200) {
      debugPrint("check Skills api is working");
      jobberCheckSkills = jobberCheckSkillModelFromJson(response.body);
      checkApi = true;
      notifyListeners();
    }
    else if(response.statusCode == 401){
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
    }else{
      debugPrint("check Skills api is not working");
      checkApi = true;
      notifyListeners();
    }
  }
}