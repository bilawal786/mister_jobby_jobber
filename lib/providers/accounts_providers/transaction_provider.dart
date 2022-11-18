import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/transaction_model/transaction_model.dart';

class TransactionProvider with ChangeNotifier{

  TransactionModel? transactionModel;

  Future<void> getTransaction() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? userToken = sharedPref.getString('token');

    var response = await http.get(Uri.parse('${MyRoutes.BASEURL}/jobber/transactions'),
        headers: <String, String>{
          "Accept":"application/json",
          "Content-Type":"application/json",
          "Authorization":"Bearer $userToken"
        });
    if(response.statusCode == 200){
      debugPrint('Transaction Api is working');
      transactionModel = transactionModelFromJson(response.body);
      notifyListeners();
    }else{
      debugPrint('Transaction Api is not working');
    }

  }

}