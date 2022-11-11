import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/commented_jobs_model/commented_jobs_model.dart';

class CommentedJobsProvider with ChangeNotifier {
  List<CommentedJobsModel>? commentedJobsModel;
  
  Future<void> getCommentedJobs() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/my/comments'),
    headers: <String, String>{
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'Bearer $userToken'
    });
    if(response.statusCode == 200){
      debugPrint('Commented jobs Api is working');
      commentedJobsModel = commentedJobsModelFromJson(response.body);
      notifyListeners();
    }else{
      debugPrint('Commented jobs Api is working');}


  }
  
}