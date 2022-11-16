import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../../helper/routes.dart';
import '../../../models/mandatory_steps_model/indicate_skills_model/indicate_skills_model.dart';

class IndicateSkillsProvider with ChangeNotifier {
  List<IndicateSkillsModel>? skills;

  Future<void> getMainCategories(context) async {

    var response = await http.get(
      Uri.parse('${MyRoutes.BASEURL}/categories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if(response.statusCode == 200) {
      debugPrint('Main Categories Api is working perfectly.');
      skills = indicateSkillsModelFromJson(response.body);
      // final extractMainCategories = json.decode();
      notifyListeners();
    }else{
      debugPrint('Main Categories Api is not working correctly');
    }
    // print(response.body);
  }

}