import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:mister_jobby_jobber/models/about_model/about_model.dart';

class AboutProvider with ChangeNotifier{

  AboutModel? about;

  Future <void> getAbout() async{
    var response = await http.get(Uri.parse(
      '${MyRoutes.BASEURL}/about'),
        headers:<String, String> {
      'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
    );
    if(response.statusCode == 200){
      debugPrint('about api is working');
      about = AboutModel.fromJson(json.decode(response.body));
      notifyListeners();
    }
    else{
      debugPrint('about api is not working');
    }
  }
}