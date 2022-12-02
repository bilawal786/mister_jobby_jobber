import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../models/subscription/subscription_model.dart';
import '../../../screens/account_screen/subscription/subscription_details_screen.dart';

class SubscriptionProvider with ChangeNotifier{

   List<SubscriptionModel>? subscriptionModel;

  int planValue = 1;
  String plan = "";
  String planDetails = "";
  String planName = "";
  String fee = '';
  String createDate = '';
  String updateDate = '';
  String duration = '';

  void getPlanFunction(index, BuildContext context) {
    planValue = index +1;
    if (subscriptionModel![index].id == 1) {
      planName = subscriptionModel![index].name.tr();
      planDetails = "Offers you can get:${subscriptionModel![index].offers}".tr();
      plan = subscriptionModel![index].price;
      createDate = subscriptionModel![index].createdAt.toString();
      updateDate = subscriptionModel![index].updatedAt.toString();
      fee = subscriptionModel![index].fee;
      duration = '';
    } else if (subscriptionModel![index].id == 2)  {
      planName = subscriptionModel![index].name.tr();
      planDetails = "You can get ${subscriptionModel![index].offers} offers".tr();
      plan = subscriptionModel![index].price;
      createDate = subscriptionModel![index].createdAt.toString();
      updateDate = subscriptionModel![index].updatedAt.toString();
      fee = subscriptionModel![index].fee;
      duration = 'mo';
    }else{
      planName = subscriptionModel![index].name.tr();
      planDetails = "You can get ${subscriptionModel![index].offers} offers".tr();
      plan = subscriptionModel![index].price;
      createDate = subscriptionModel![index].createdAt.toString();
      updateDate = subscriptionModel![index].updatedAt.toString();
      fee = subscriptionModel![index].fee;
      duration = 'yr';
    }
    debugPrint(plan.toString());
    debugPrint(planValue.toString());
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        SubscriptionDetails(details: planDetails, name: planName, price: plan, duration: duration),));
    notifyListeners();
  }
  
  Future<void> getSubscriptionPlan (context) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/subscriptions'),
    headers: <String, String>{
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'Bearer $userToken'
    });
    if(response.statusCode == 200){
      debugPrint('Subscription Api is working');
      subscriptionModel = subscriptionModelFromJson(response.body);
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
      debugPrint('Subscription Api is not working');}
  }

   Future<void> getSubscriptionIntent (context) async {
     SharedPreferences sharedPref = await SharedPreferences.getInstance();
     String? userToken = sharedPref.getString('token');
     var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/get/subscription/intent'),
         headers: <String, String>{
           'Accept':'application/json',
           'Content-Type':'application/json',
           'Authorization':'Bearer $userToken'
         });
     if(response.statusCode == 200){
       debugPrint('Subscription Intent Api is working');
       // subscriptionModel = subscriptionModelFromJson(response.body);
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
     }else{
       debugPrint('Subscription Intent Api is not working');}
   }



}