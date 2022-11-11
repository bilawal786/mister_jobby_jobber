import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/commented_jobs_model/current_jobs_offers_model.dart';

class CurrentJobsOffersProvider with ChangeNotifier {
  List <CurrentJobsOffersModel>? commentedJobsModel;
  
  Future<void> getCommentedJobs()async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken =  sharedPref.getString('token');
    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/my/offers'),
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type':'allication/json',
      'Authorization':'Bearer ${userToken}'
    });
    if(response.statusCode == 200){
      debugPrint('Current jobs Api is working');
      commentedJobsModel = commentedJobsModelFromJson(response.body);
      notifyListeners();
    }else{
      debugPrint('Current jobs Api is not working');}
  }
  
}