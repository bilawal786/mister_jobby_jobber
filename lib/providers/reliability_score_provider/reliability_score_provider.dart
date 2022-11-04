import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../widgets/const_widgets/progress_indicator.dart';
import '../check_profile_completion_provider/check_profile_completion_provider.dart';

class ReliabilityScoreProvider  with ChangeNotifier{

  Future<void> reliabilityScore(context,score) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/score'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': "Bearer $userToken",
      },
      body: jsonEncode(<String, String>{
        'score': score,
      }),
    );
    if(response.statusCode == 200){
      Provider.of<CheckProfileCompletionProvider>(context, listen: false)
          .getProfileCompletionData();
      Navigator.pop(context);
      Navigator.of(context).popUntil(ModalRoute.withName(MyRoutes.MANDATORYSTEPSSCREENROUTE));
      debugPrint("reliability score api is working");
    }else{
      Navigator.pop(context);
      debugPrint("reliability score api is not working");
    }

    notifyListeners();
  }

}