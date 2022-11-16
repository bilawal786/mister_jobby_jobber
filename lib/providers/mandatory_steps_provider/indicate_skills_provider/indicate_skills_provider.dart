import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';

import '../../../helper/routes.dart';
import '../../../models/mandatory_steps_model/indicate_skills_model/indicate_skills_model.dart';
import '../personal_information_provider/personal_information_provider.dart';

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
      print('Main Categories Api is working perfectly.');
      Provider.of<PersonalInformationProvider>(context,listen: false).getProfile();
      // final extractMainCategories = json.decode();
      skills = indicateSkillsModelFromJson(response.body);
      notifyListeners();
    }else{
      print('Main Categories Api is not working correctly');
    }
    // print(response.body);
  }

}