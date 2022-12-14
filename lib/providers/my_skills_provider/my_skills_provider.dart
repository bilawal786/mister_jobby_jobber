import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../models/my_skills_model/my_skills_model.dart';
import '../../widgets/const_widgets/login_progress_indicator.dart';
import '../check_profile_completion_provider/check_profile_completion_provider.dart';
import '../mandatory_steps_provider/jobber_check_skills_provider/jobber_check_skills_provider.dart';
import '../mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';

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


  List<String> temp = [];

  void addTempData (index) {
    var check = mySkills![index].skills.split(',');
    temp = check;
  }

  void isAdded(String value) {
    if (temp.contains(value)) {
      temp.remove(value);
    } else {
      temp.add(value);
    }
    notifyListeners();
  }

  List<String> equipmentList = [
    "Hammer".tr(),
    "screwdriver".tr(),
    "Plane".tr(),
    "Drill Perforator".tr(),
    "Wrench".tr(),
    "Sander".tr(),
    "Saw".tr(),
    "Circular saw".tr(),
    "Screwdriver set".tr(),
    "Level".tr(),
  ];

  List<String> tempEquipment = [];

  void addTempEquipmentData (index) {
    var check = mySkills![index].equipments.split(',');
    tempEquipment = check;

  }

  void isAddedEquipments(String value) {
    if (tempEquipment.contains(value)) {
      tempEquipment.remove(value);
    } else {
      tempEquipment.add(value);
    }
    notifyListeners();
  }

  List<String> engagementList = [
    "Respect for places".tr(),
    "Impeccable result".tr(),
    "Neat work".tr(),
    "expert work".tr(),
    "passionate work".tr(),
    "Organized and methodical".tr(),
    "Safe work".tr(),
    "Effective and discreet".tr(),
    "Friendliness".tr(),
    "Quality before speed".tr(),
    "Speed and reliability".tr(),
    "Dynamic and smiling".tr(),
    "Guaranteed result".tr(),
    "Satisfied or redone".tr(),
    "Responsive and flexible".tr(),
    "Clean site".tr(),
  ];

  List<String> tempEngagement = [];

  void addTempEngagementData (index) {
    var check = mySkills![index].engagments.split(',');
    tempEngagement = check;

  }

  void isAddedEngagements(String value) {
    if (tempEngagement.contains(value)) {
      tempEngagement.remove(value);
    } else {
      tempEngagement.add(value);
    }
    notifyListeners();
  }

  List<String> jardinageEquipmentList = [
    "Arm mower".tr(),
    "Ride-on mower".tr(),
    "Chopped".tr(),
    "Saw".tr(),
    "Small gardening equipment (secateurs, hoe, etc.)".tr(),
    "Large gardening equipment (shovel, rake, etc.)".tr(),
    "Wheelbarrow".tr(),
  ];

  List<String> livraisonEquipmentList = [
    "Pick-up (2 to 3 m??)".tr(),
    "Van (3 to 6 m??)".tr(),
    "Small van (7 to 9 m??)".tr(),
    "Big van (10 to 12 m??)".tr(),
    "Small truck (20 to 22 m??)".tr(),
    "Big truck (+30 m??)".tr(),
    "Straps".tr(),
    "Blankets".tr(),
    "Boxes".tr(),
    "Vacuum".tr(),
    "Household products".tr(),
    "Karcher".tr(),
    "Steam plant".tr(),
    "Iron".tr(),
  ];

  List<String> animalEquipmentList = [
    "Kennel".tr(),
    "Garden".tr(),
    "Cage".tr(),
    "Aviary".tr(),
    "Outdoor enclosure".tr(),
    "Indoor enclosure".tr(),
    "Cat tree".tr(),
    "Litter".tr(),
    "Transport container".tr(),
  ];

  List<String> computerEquipmentList = [
    "diagnostic tool".tr(),
    "Mac computer".tr(),
    "Window computer".tr(),
    "linux computer".tr(),
  ];

  String skillsDetail = '';
  String changeSkillsDetail  = '';

  getDescription(value){
    changeSkillsDetail = value;
    notifyListeners();
  }

  Future<void> updataMySkill(
      context,
      skillId,
      skills,
      description,
      equipments,
      engagements,
      ) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoginProgressIndicator();
        });
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/update/skills/$skillId'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': "Bearer $userToken",
      },
      body: jsonEncode(<String, String>{
        'skills': skills,
        'description': description,
        'equipments': equipments,
        'engagments': engagements,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      debugPrint("Skill add api is working");
      Provider.of<CheckProfileCompletionProvider>(context, listen: false)
          .getProfileCompletionData(context);
      Provider.of<JobberCheckSkillsProvider>(context, listen: false).getCheckSkills(context);
      Provider.of<PersonalInformationProvider>(context,listen: false).getProfile(context);
      Provider.of<MySkillsProvider>(context,listen: false).getMySkill(context);
      Navigator.pop(context);
      Navigator.of(context)
          .pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Skill updated',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
      notifyListeners();
    } else {
      Navigator.pop(context);
      debugPrint(response.body);
      debugPrint("skill update api not working ");
    }
    notifyListeners();
  }


}