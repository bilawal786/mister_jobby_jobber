import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:mister_jobby_jobber/screens/account_screen/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/const_widgets/login_progress_indicator.dart';

class GetBadgesProvider with ChangeNotifier {

  int vtaRegime = 0;
  String regimeName = '';
  getRegime(int? v ){
    vtaRegime = v!;
    if(vtaRegime == 1){
      regimeName = 'Micro-enterprise scheme';

    }else if(vtaRegime == 2){
      regimeName = 'Sole proprietorship scheme';
    }
    notifyListeners();
  }

  bool switchValue = false;
  switchOn (value){
    switchValue = !switchValue;
    notifyListeners();
  }
  
  Future<void> getBadges(BuildContext context, companyName, vatType, companyAddress, siret) async {
    showDialog(context: context, builder: (BuildContext context) {
      return const LoginProgressIndicator();
    });
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.post(Uri.parse('${MyRoutes.BASEURL}/jobber/get/pro/badge'),
    headers: <String, String>{
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'Bearer $userToken',
    },body: jsonEncode(<String, String>{
      'company_name':companyName,
          'vat_type':vatType,
          'company_address':companyAddress,
          'siret':siret,
        })
    );
    if(response.statusCode == 200){
      debugPrint('Get badge Api is working');
      Navigator.of(context).pop();
      Navigator.of(context).popUntil(ModalRoute.withName(MyRoutes.SETTINGSCREENROUTE));
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SettingScreen(),),(route) => false,);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Applied for PRO Badges',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      notifyListeners();
    }else{
      debugPrint('Get badge Api is not working');
    }
    
    
  }
  
  
}