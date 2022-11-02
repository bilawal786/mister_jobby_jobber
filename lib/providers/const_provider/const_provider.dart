import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../widgets/const_widgets/login_progress_indicator.dart';

class ConstProvider with ChangeNotifier {
  List<String> temp = [];

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

  void isAddedEquipments(String value) {
    if (tempEquipment.contains(value)) {
      tempEquipment.remove(value);
    } else {
      tempEquipment.add(value);
    }
    notifyListeners();
  }

  int diploma = 0;
  String haveDiploma = "";
  String diplomaName = "";
  void diplomaCheck(int index) {
    diploma = index + 1;
    if (diploma == 1) {
      haveDiploma = "Yes".tr();
    } else {
      haveDiploma = "No".tr();
      diplomaName = "";
    }
    notifyListeners();
  }

  int experience = 0;
  String experienceTitle = "";

  void experienceFunction(int index) {
    experience = index + 1;
    if (experience == 1) {
      experienceTitle = "None".tr();
    } else if (experience == 2) {
      experienceTitle = "Less than a year".tr();
    } else if (experience == 3) {
      experienceTitle = "2 to 4 years old".tr();
    } else if (experience == 4) {
      experienceTitle = "5 to 9 years old".tr();
    } else if (experience == 5) {
      experienceTitle = "+10 years".tr();
    }
    notifyListeners();
  }

  String skillsDetail = '';

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

  void isAddedEngagements(String value) {
    if (tempEngagement.contains(value)) {
      tempEngagement.remove(value);
    } else {
      tempEngagement.add(value);
    }
    notifyListeners();
  }

  clearData(){
    temp.clear();
    tempEngagement.clear();
    tempEquipment.clear();
    diploma = 0;
    diplomaName = "";
    experience = 0;
    experienceTitle= "";
    skillsDetail = "";
  }

  int mondayValue = 0;
  int tuesdayValue = 0;
  int wednesdayValue = 0;
  int thursdayValue = 0;
  int fridayValue = 0;
  int saturdayValue = 0;
  int sundayValue = 0;

  void checkMondayValue(int? value, BuildContext context) {
    mondayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkTuesdayValue(int? value, BuildContext context) {
    tuesdayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkWednesdayValue(int? value, BuildContext context) {
    wednesdayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkThursdayValue(int? value, BuildContext context) {
    thursdayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkFridayValue(int? value, BuildContext context) {
    fridayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkSaturdayValue(int? value, BuildContext context) {
    saturdayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkSundayValue(int? value, BuildContext context) {
    sundayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  int questionOneValue = 0;
  int questionTwoValue = 0;
  int questionThreeValue = 0;

  void checkQuestionOneGroupValue(int? value) {
    questionOneValue = value!;
    notifyListeners();
  }

  void checkQuestionTwoGroupValue(int? value) {
    questionTwoValue = value!;
    notifyListeners();
  }

  void checkQuestionThreeGroupValue(int? value) {
    questionThreeValue = value!;
    notifyListeners();
  }

  bool trustMisterJobby = false;
  bool cashNotRequired = false;

  void checkStatusTrust(value) {
    trustMisterJobby = value;
    notifyListeners();
  }

  void checkCashRequiredStatus(value) {
    cashNotRequired = value;
    notifyListeners();
  }

  int europeanCitizen = 0;
  String isEuropeanCitizen = "";

  void europeanCitizenFunction(int index) {
    europeanCitizen = index + 1;
    if (europeanCitizen == 1) {
      isEuropeanCitizen = "Yes".tr();
    } else {
      isEuropeanCitizen = "No".tr();
    }
    notifyListeners();
  }

  List? skillsId;
  @override
  void notifyListeners() {
    skillsId;
    super.notifyListeners();
  }

  bool skillAdded = false;

  Future<void> postJobberSkills(
    context,
    mainCatId,
    subCatId,
    skills,
    diploma,
    diplomaName,
    experience,
    description,
    equipments,
    engagements,
  ) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoginProgressIndicator();
        });
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/skills'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': "Bearer $userToken",
      },
      body: jsonEncode(<String, String>{
        'main_category': mainCatId.toString(),
        'sub_category': subCatId.toString(),
        'skills': skills,
        'diploma': diploma.toString(),
        'diploma_name': diplomaName.toString(),
        'experience': experience.toString(),
        'description': description.toString(),
        'equipments': equipments,
        'engagments': engagements,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      clearData();
      debugPrint("Skill add api is working");
      Navigator.pop(context);
      Navigator.of(context)
          .pushReplacementNamed(MyRoutes.MANDATORYSTEPSSCREENROUTE);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Skill added',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      skillAdded = true;
      notifyListeners();
    } else {
      Navigator.pop(context);
      debugPrint(response.body);
      debugPrint("skill add api not working ");
    }
    notifyListeners();
  }
}
