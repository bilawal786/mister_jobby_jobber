import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../models/single_job_model/single_job_model.dart';


class SingleJobProvider with ChangeNotifier {
  SingleJobModel? jobDetail;
  var checkApi = false;
  Future<void>  getSingleJobDetail(id) async {
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
    } else {
      debugPrint('get Single jobs api not working');
      checkApi = true;
      notifyListeners();
    }
  }


}