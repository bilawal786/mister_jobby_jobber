import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../models/subscription/retrieve_subscription_model.dart';
import '../../../models/subscription/subscription_model.dart';
import '../../../models/subscription/subscription_payment_model.dart';
import '../../../screens/account_screen/subscription/subscription_details_screen.dart';
import '../../../screens/web_view.dart';
import '../../../widgets/const_widgets/login_progress_indicator.dart';

class SubscriptionProvider with ChangeNotifier {
  List<SubscriptionModel>? subscriptionModel;

  String planId = "";
  int? subId;
  int planValue = 1;
  String plan = "";
  String planDetails = "";
  String planName = "";
  String fee = '';
  String createDate = '';
  String updateDate = '';
  String duration = '';

  void getPlanFunction(index, BuildContext context) {
    planValue = index + 1;
    if (subscriptionModel![index].id == 1) {
      planName = subscriptionModel![index].name.tr();
      planDetails =
          "Offers you can get: 15".tr();
      plan = subscriptionModel![index].price;
      createDate = subscriptionModel![index].createdAt.toString();
      updateDate = subscriptionModel![index].updatedAt.toString();
      fee = subscriptionModel![index].fee;
      duration = '';
    } else if (subscriptionModel![index].id == 2) {
      planName = subscriptionModel![index].name.tr();
      planDetails =
          "You can get unlimited offers".tr();
      plan = subscriptionModel![index].price;
      createDate = subscriptionModel![index].createdAt.toString();
      updateDate = subscriptionModel![index].updatedAt.toString();
      fee = subscriptionModel![index].fee;
      planId = subscriptionModel![index].planId;
      subId = subscriptionModel![index].id;
      duration = 'mo';
    } else {
      planName = subscriptionModel![index].name.tr();
      planDetails =
          "You can get unlimited offers".tr();
      plan = subscriptionModel![index].price;
      createDate = subscriptionModel![index].createdAt.toString();
      updateDate = subscriptionModel![index].updatedAt.toString();
      fee = subscriptionModel![index].fee;
      planId = subscriptionModel![index].planId;
      subId = subscriptionModel![index].id;
      duration = 'yr';
    }
    debugPrint(plan.toString());
    debugPrint(planValue.toString());
    if (planValue == 1) {
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SubscriptionDetails(
          subId: subId!,
          planId: planId,
            details: planDetails,
            name: planName,
            price: plan,
            duration: duration),
      ));
    }
    notifyListeners();
  }

  Future<void> getSubscriptionPlan(context) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(
        Uri.parse('${MyRoutes.BASEURL}/jobber/subscriptions'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken'
        });
    if (response.statusCode == 200) {
      debugPrint('Subscription Api is working');
      subscriptionModel = subscriptionModelFromJson(response.body);
      notifyListeners();
    } else if (response.statusCode == 401) {
      debugPrint('error: 401');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MyRoutes.LOGINSCREENROUTE, (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Session Expired...  Please Log-In',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    } else {
      debugPrint('Subscription Api is not working');
    }
  }

  SubscriptionPaymentModel? subscriptionPaymentModel;


  Future<void> bookSubscriptionPlan(context, planId, uId, subId, title) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(
        Uri.parse(
            '${MyRoutes.BASEURL}/jobber/subscription/payment/$planId/$uId/$subId'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken'
        });
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      debugPrint('book Subscription Api is working');
      subscriptionPaymentModel =
          subscriptionPaymentModelFromJson(response.body);
      notifyListeners();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => WebView(
            url: subscriptionPaymentModel!.url,
            title: title,
          ),
        ),
      );
    } else if (response.statusCode == 401) {
      Navigator.of(context).pop();
      debugPrint('error: 401');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MyRoutes.LOGINSCREENROUTE, (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Session Expired...  Please Log-In',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    } else {
      Navigator.of(context).pop();
      debugPrint('Subscription Payment Api is not working');
    }
  }

  RetrieveSubscription? retrieveSubscription;

  Future<void> getRetrieveSubscription(context) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');
    var response = await http.get(
        Uri.parse(
            '${MyRoutes.BASEURL}/jobber/retrieve/subscription'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken'
        });
    if (response.statusCode == 200) {
      debugPrint('book Subscription Api is working');
      retrieveSubscription =
          retrieveSubscriptionFromJson(response.body);
      notifyListeners();
    } else if (response.statusCode == 401) {
      debugPrint('error: 401');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MyRoutes.LOGINSCREENROUTE, (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Session Expired...  Please Log-In',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    } else {
      debugPrint('Subscription Payment Api is not working');
    }
  }



}
