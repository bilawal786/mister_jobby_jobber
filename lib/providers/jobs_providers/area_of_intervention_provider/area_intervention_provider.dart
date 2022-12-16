import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../screens/home_screens/home_tab_screen.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';
import '../../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import '../available_jobs_provider/available_jobs_provider.dart';

class AreaInterventionProvider with ChangeNotifier {
  double interventionArea = 1;

  radiusOfIntervention(double newValue) {
    interventionArea = newValue;
    notifyListeners();
  }

  String completeAddress = "";
  double longitude = 0;
  double latitude = 0;

  void getAddress(address, long, lat) {
    completeAddress = address;
    longitude = long;
    latitude = lat;
    notifyListeners();
  }

  Future<void> setAreaIntervention(
      context, lati, longi, radius, address) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoginProgressIndicator();
        });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/update/radius'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode(<String, String>{
        'latitude': lati.toString(),
        'longitude': longi.toString(),
        'radius': radius.toString(),
        'address': address.toString(),
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("Area of Intervention api working");
      Provider.of<PersonalInformationProvider>(context, listen: false)
          .getProfile(context);
      Provider.of<AvailableJobsProvider>(context, listen: false)
          .getAvailableJobs(context);
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => HomeTabScreen(
                    pageIndex: 0,
                  )),
          (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Area of Intervention set Successfully'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );

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
            'Session Expired...  Please Log-In'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
      debugPrint("Area Intervention api not working");
    }
  }
}
