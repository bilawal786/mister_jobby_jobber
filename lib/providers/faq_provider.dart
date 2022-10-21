import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../helper/routes.dart';
import '../models/faq_model.dart';


class FAQProvider with ChangeNotifier{
  List<int> expansion = [];

 void expansionFunction(index){
    if (expansion.contains(index)) {
      expansion.remove(index);
    } else {
      expansion.add(index);
    }
    notifyListeners();
  }


  List<FaqModel>? myFAQ;

  Future<void> getFAQ() async {

    var response = await http.get(
      Uri.parse('${MyRoutes.BASEURL}/faq'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if(response.statusCode == 200) {
      print('FAQ Api is working perfectly.');
      myFAQ = faqModelFromJson(response.body);
      print(myFAQ);
      notifyListeners();
    }else{
      print('FAQ Api is not working correctly');
    }
    // print(response.body);
  }

}