import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:mister_jobby_jobber/models/notifications_model/notifications_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel>? notificationItems;

  Future<void> getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    var response = await http.get(
      Uri.parse('${MyRoutes.BASEURL}/notification'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken'
      },
    );
    if(response.statusCode == 200) {
      debugPrint('Notifications Api is working');
      notificationItems = notificationModelFromJson(response.body);
    }else{
      debugPrint('Notifications Api is not working');
    }
  }
}
