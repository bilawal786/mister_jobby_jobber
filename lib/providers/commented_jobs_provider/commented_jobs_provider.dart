import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/commented_jobs_model/commented_jobs_model.dart';

class CommentedJobsProvider with ChangeNotifier {
  List<CommentedJobsModel>? commentedJobsModel;

  var checkApi = false;
  Future<void> getCommentedJobs(context) async {
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
      checkApi = true;
      notifyListeners();
    }else if(response.statusCode == 401){
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
    }else{
      debugPrint('Commented jobs Api is working');
    checkApi= true;
    notifyListeners();
    }


  }
  
}