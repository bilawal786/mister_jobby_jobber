import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../widgets/const_widgets/login_progress_indicator.dart';
import '../check_profile_completion_provider/check_profile_completion_provider.dart';

class ConstProvider with ChangeNotifier {
  List<String> temp = [];
  List<String> tempSubCategory = [];

  void isAddedSubCategories(String value) {
    if (tempSubCategory.contains(value)) {
      tempSubCategory.remove(value);
    } else {
      tempSubCategory.add(value);
    }
    notifyListeners();
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
    "Pick-up (2 to 3 m²)".tr(),
    "Van (3 to 6 m²)".tr(),
    "Small van (7 to 9 m²)".tr(),
    "Big van (10 to 12 m²)".tr(),
    "Small truck (20 to 22 m²)".tr(),
    "Big truck (+30 m²)".tr(),
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
    tempSubCategory.clear();
    tempEngagement.clear();
    tempEquipment.clear();
    diploma = 0;
    diplomaName = "";
    experience = 0;
    experienceTitle= "";
    skillsDetail = "";
  }

  String availableTimeMonday = '';
  String availableTimeTuesday = '';
  String availableTimeWednesday = '';
  String availableTimeThursday = '';
  String availableTimeFriday = '';
  String availableTimeSaturday = '';
  String availableTimeSunday = '';

  int mondayValue = 0;
  int tuesdayValue = 0;
  int wednesdayValue = 0;
  int thursdayValue = 0;
  int fridayValue = 0;
  int saturdayValue = 0;
  int sundayValue = 0;

  void checkMondayValue(int? value, BuildContext context) {
    mondayValue = value!;
    if(mondayValue == 1) {
      availableTimeMonday = "07:00 - 21:00";
    }else if(mondayValue == 2){
      availableTimeMonday = "07:00 - 13:00";
    }else if(mondayValue == 3){
      availableTimeMonday = "13:00 - 18:00";
    }else if(mondayValue == 4){
      availableTimeMonday = "18:00 - 21:00";
    }else if(mondayValue == 5){
      availableTimeMonday = "I am Not Available";
    }
    Navigator.pop(context);
    notifyListeners();
  }

  void checkTuesdayValue(int? value, BuildContext context) {
    tuesdayValue = value!;
    if(tuesdayValue == 1) {
      availableTimeTuesday = "07:00 - 21:00";
    }else if(tuesdayValue == 2){
      availableTimeTuesday = "07:00 - 13:00";
    }else if(tuesdayValue == 3){
      availableTimeTuesday = "13:00 - 18:00";
    }else if(tuesdayValue == 4){
      availableTimeTuesday = "18:00 - 21:00";
    }else if(tuesdayValue == 5){
      availableTimeTuesday = "I am Not Available";
    }
    Navigator.pop(context);
    notifyListeners();
  }

  void checkWednesdayValue(int? value, BuildContext context) {
    wednesdayValue = value!;
    if(wednesdayValue == 1) {
      availableTimeWednesday = "07:00 - 21:00";
    }else if(wednesdayValue == 2){
      availableTimeWednesday = "07:00 - 13:00";
    }else if(wednesdayValue == 3){
      availableTimeWednesday = "13:00 - 18:00";
    }else if(wednesdayValue == 4){
      availableTimeWednesday = "18:00 - 21:00";
    }else if(wednesdayValue == 5){
      availableTimeWednesday = "I am Not Available";
    }
    Navigator.pop(context);
    notifyListeners();
  }

  void checkThursdayValue(int? value, BuildContext context) {
    thursdayValue = value!;
    if(thursdayValue == 1) {
      availableTimeThursday = "07:00 - 21:00";
    }else if(thursdayValue == 2){
      availableTimeThursday = "07:00 - 13:00";
    }else if(thursdayValue == 3){
      availableTimeThursday = "13:00 - 18:00";
    }else if(thursdayValue == 4){
      availableTimeThursday = "18:00 - 21:00";
    }else if(thursdayValue == 5){
      availableTimeThursday = "I am Not Available";
    }
    Navigator.pop(context);
    notifyListeners();
  }

  void checkFridayValue(int? value, BuildContext context) {
    fridayValue = value!;
    if(fridayValue == 1) {
      availableTimeFriday = "07:00 - 21:00";
    }else if(fridayValue == 2){
      availableTimeFriday = "07:00 - 13:00";
    }else if(fridayValue == 3){
      availableTimeFriday = "13:00 - 18:00";
    }else if(fridayValue == 4){
      availableTimeFriday = "18:00 - 21:00";
    }else if(fridayValue == 5){
      availableTimeFriday = "I am Not Available";
    }
    Navigator.pop(context);
    notifyListeners();
  }

  void checkSaturdayValue(int? value, BuildContext context) {
    saturdayValue = value!;
    if(saturdayValue == 1) {
      availableTimeSaturday = "07:00 - 21:00";
    }else if(saturdayValue == 2){
      availableTimeSaturday = "07:00 - 13:00";
    }else if(saturdayValue == 3){
      availableTimeSaturday = "13:00 - 18:00";
    }else if(saturdayValue == 4){
      availableTimeSaturday = "18:00 - 21:00";
    }else if(saturdayValue == 5){
      availableTimeSaturday = "I am Not Available";
    }
    Navigator.pop(context);
    notifyListeners();
  }

  void checkSundayValue(int? value, BuildContext context) {
    sundayValue = value!;
    if(sundayValue == 1) {
      availableTimeSunday = "07:00 - 21:00";
    }else if(sundayValue == 2){
      availableTimeSunday = "07:00 - 13:00";
    }else if(sundayValue == 3){
      availableTimeSunday = "13:00 - 18:00";
    }else if(sundayValue == 4){
      availableTimeSunday = "18:00 - 21:00";
    }else if(sundayValue == 5){
      availableTimeSunday = "I am Not Available";
    }
    Navigator.pop(context);
    notifyListeners();
  }

  String answerOne = "";
  String answerTwo = "";
  String answerThree = "";
  int questionOneValue = 0;
  int questionTwoValue = 0;
  int questionThreeValue = 0;

  void checkQuestionOneGroupValue(int? value) {
    questionOneValue = value!;
    if(questionOneValue == 1) {
      answerOne = "He pays the entire mission in advance and online on mister jobby.".tr();
    }else if(questionOneValue == 2) {
      answerOne = "We don't know, we'll see.".tr();
    }
    notifyListeners();
  }

  void checkQuestionTwoGroupValue(int? value) {
    questionTwoValue = value!;
    if(questionTwoValue == 1) {
      answerTwo = "Too bad for you.".tr();
    }else if(questionTwoValue == 2) {
      answerTwo = "The customer can add overtime on mister jobby.".tr();
    }
    notifyListeners();
  }

  void checkQuestionThreeGroupValue(int? value) {
    questionThreeValue = value!;
    if(questionThreeValue == 1) {
      answerThree = "There is no consequence.".tr();
    }else if(questionThreeValue == 2) {
      answerThree = "You risk not being paid and being suspended.".tr();
    }
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
      Provider.of<CheckProfileCompletionProvider>(context, listen: false)
          .getProfileCompletionData();
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
