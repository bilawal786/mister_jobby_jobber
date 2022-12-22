import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../widgets/const_widgets/progress_indicator.dart';
import '../check_profile_completion_provider/check_profile_completion_provider.dart';

class ReliabilityScoreProvider  with ChangeNotifier{

  Future<void> reliabilityScore(context,score) async {
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
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
          .getProfileCompletionData(context);
      Navigator.pop(context);
      Navigator.of(context).popUntil(ModalRoute.withName(MyRoutes.MANDATORYSTEPSSCREENROUTE));
      debugPrint("reliability score api is working");
    }
    else if(response.statusCode == 401){
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
      Navigator.pop(context);
      debugPrint("reliability score api is not working");
    }

    notifyListeners();
  }

}