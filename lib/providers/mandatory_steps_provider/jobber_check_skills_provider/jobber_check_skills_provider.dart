import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../models/mandatory_steps_model/indicate_skills_model/jobber_check_skills_model.dart';

class JobberCheckSkillsProvider with ChangeNotifier {
  JobberCheckSkillModel? jobberCheckSkills;

  Future<void> getCheckSkills() async{
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
    }else{
      debugPrint("check Skills api is not working");
    }
  }
}