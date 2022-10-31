import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConstProvider with ChangeNotifier {
  List<String> temp = [];

  void isAdded(value){
    if(temp.contains(value)){
      temp.remove(value);
    }else {
      temp.add(value);
    }
    notifyListeners();
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

}