import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';

class PreferencesProvider with ChangeNotifier {
  String? token;
  int? id;
  Future<void> checkToken(context) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    int? userId = sharedPrefs.getInt("demandeurId");
    token = userToken.toString();
    id = userId?.toInt();

    token == 'null' ? Navigator.of(context)
        .pushReplacementNamed(MyRoutes.LOGINSCREENROUTE) : Navigator.of(context)
        .pushReplacementNamed(MyRoutes.HOMESCREENROUTE);
    notifyListeners();
  }

  void logOut(BuildContext context) async{
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.SPLASHSCREENROUTE, (route) => false);
    notifyListeners();
  }
}