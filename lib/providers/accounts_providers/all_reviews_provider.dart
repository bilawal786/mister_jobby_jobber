import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/all_reviews_model/all_reviews_model.dart';

class AllReviewsProvider with ChangeNotifier {

  AllReviewsModel? allReviewsModel;

  Future<void> getAllReviews () async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/reviews'),
        headers: <String, String>{
          'Accept':'application/json',
          'Content-Type':'application/json',
          'Authorization':'Bearer $userToken'
        });
    if(response.statusCode == 200){
      debugPrint('All reviews Api is working');
      allReviewsModel = allReviewsModelFromJson(response.body);
      notifyListeners();
    }else{
      debugPrint('All reviews Api is not working');}
  }


}