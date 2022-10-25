
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../models/job_models/available_jobs_model.dart';

class AvailableJobsProvider with ChangeNotifier {
  List<AvailableJobsModel>? availableJobs;

  Future<void> getAvailableJobs() async {
    final SharedPreferences sharePref = await SharedPreferences.getInstance();
    String? token = sharePref.getString('token');
    var response = await http.get(
        Uri.parse('${MyRoutes.BASEURL}/jobber/jobs'),
        headers: <String, String>{
          'Accept': "application/json",
          'Content-Type': "application/json",
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      debugPrint('get available jobs successfully');
      availableJobs = availableJobsModelFromJson(response.body);
      notifyListeners();
    } else {
      debugPrint('get available jobs api not working');
    }
  }
}