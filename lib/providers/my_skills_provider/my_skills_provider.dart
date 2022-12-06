import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../models/my_skills_model/my_skills_model.dart';

class MySkillsProvider with ChangeNotifier {

  List<MySkillsModel>? mySkills;

  Future<void> getMySkill(context) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(
      Uri.parse('${MyRoutes.BASEURL}/jobber/my/skills'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': 'Bearer ${userToken!}',
      },
    );
    if(response.statusCode == 200) {
      debugPrint("My Skills api is working");
      mySkills = mySkillsModelFromJson(response.body);
      notifyListeners();
    }else if(response.statusCode == 401){
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
    }
    else{
      Navigator.of(context).pushNamed(MyRoutes.ERRORSCREENROUTE);
      debugPrint("My Skills api is not working");
    }
    notifyListeners();
  }
}