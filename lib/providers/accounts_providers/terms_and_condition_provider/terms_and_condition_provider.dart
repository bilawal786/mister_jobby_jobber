import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:mister_jobby_jobber/models/terms_and_condition_model/term_and_condition_model.dart';
import 'package:http/http.dart' as http;
class TermsAndConditonProvider with ChangeNotifier{

   TermsAndConditionModel? termsAndCondition;

  Future<void> getTermsAndConditions ()async{
    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/terms/and/privacy'),
      headers: <String, String>{
      'Accept':'application/json',
        'Content-Type' : 'application/json',
      }
      ,);

    if(response.statusCode == 200){
      debugPrint('Terms and conditions API is working');
      termsAndCondition = TermsAndConditionModel.fromJson(json.decode(response.body));
      notifyListeners();
    }
    else{
      debugPrint('Terms and conditions API is not working');
    }

  }
}