import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../screens/account_screen/subscription/subscription_details_screen.dart';

class SubscriptionProvider with ChangeNotifier{
  int planValue = 1;
  String plan = "";
  String planDetails = "";
  String planName = "";

  void getPlanFunction(index, BuildContext context) {
    planValue = index +1;
    if (planValue == 1) {
      planName = "Unlimited".tr();
      planDetails = "You can pay in installment".tr();
      plan = "15.99".tr();
    } else if (planValue == 2)  {
      planName = "Yearly".tr();
      planDetails = "You can pay in installment".tr();
      plan = "10.99".tr();
    }else{
      planName = "Monthly".tr();
      planDetails = "You can pay in installment".tr();
      plan = "5.99".tr();
    }
    debugPrint(plan);
    debugPrint(planValue.toString());
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        SubscriptionDetails(details: planDetails, name: planName, price: plan),));
    notifyListeners();
  }



}