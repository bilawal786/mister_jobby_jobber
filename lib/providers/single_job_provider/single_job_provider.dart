import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../models/single_job_model/single_job_model.dart';


class SingleJobProvider with ChangeNotifier {
  SingleJobModel? jobDetail;
  bool? checkApi;
  Future<void>  getSingleJobDetail(context, id) async {
    checkApi = false;
    final SharedPreferences sharePref = await SharedPreferences.getInstance();
    String? token = sharePref.getString('token');
    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/single/job/$id'),
        headers: <String, String>{
          'Accept': "application/json",
          'Content-Type': "application/json",
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      debugPrint('get Single jobs successfully');
      jobDetail = singleJobModelFromJson(response.body);
      checkApi = true;
      notifyListeners();
    } else if(response.statusCode == 401){
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
    } else {
      debugPrint('get Single jobs api not working');
      checkApi = true;
      notifyListeners();
    }
    notifyListeners();
  }

  List<String> temp = [];

  void addTempData () {
    var check = jobDetail!.question.split(',');
    temp = check;
  }
  List<String> tempDoB = [];

  void addTempDobData () {
    var checkDob = jobDetail!.question1.split(',');
    tempDoB = checkDob;
  }


}