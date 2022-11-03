import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../models/check_profile_completion/check_profile_completion_model.dart';

class CheckProfileCompletionProvider with ChangeNotifier {
  CheckProfileCompletion? checkProfileComplete;

  Future<void> getProfileCompletionData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(
        Uri.parse('${MyRoutes.BASEURL}/jobber/check/profile/completion'),
        headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': 'Bearer $userToken',
        },
    );
    if(response.statusCode == 200) {
      debugPrint("checkProfileCompletion api is working");
      checkProfileComplete = checkProfileCompletionFromJson(response.body);
    }else{
      debugPrint("checkProfileCompletion api is not working");
    }

  }
}