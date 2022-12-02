import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mister_jobby_jobber/screens/search_screen/search_jobs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../models/job_models/available_jobs_model.dart';
import '../../../widgets/const_widgets/login_progress_indicator.dart';

class AvailableJobsProvider with ChangeNotifier {
  List<AvailableJobsModel>? availableJobs;

  bool? checkApi;

  setCheckApi(){
    checkApi = false;
    notifyListeners();
  }

  Future<void> ignoreThisJob(context, jobId) async{
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? token = sharedPref.getString('token');
    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/job/ignore/$jobId'),
    headers: <String, String> {
      'Accept':'application/json',
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        });
    if(response.statusCode == 200){
      debugPrint('Ignore job Api is working');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Ignored this Job Successfully',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SearchJobScreen(),
      ),);

      notifyListeners();
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
    else{debugPrint('Ignore job Api is not working');
    }
  }
  Future<void> getAvailableJobs(context) async {
    checkApi = false;
    final SharedPreferences sharePref = await SharedPreferences.getInstance();
    String? token = sharePref.getString('token');
    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/jobs'),
        headers: <String, String>{
          'Accept': "application/json",
          'Content-Type': "application/json",
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      debugPrint('get available jobs successfully');
      availableJobs = availableJobsModelFromJson(response.body);
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
      checkApi = true;
    }
    else {
      debugPrint('get available jobs api not working');
      checkApi = true;
      notifyListeners();
    }
    notifyListeners();
  }
}
