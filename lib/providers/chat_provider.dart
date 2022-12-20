import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/routes.dart';
import '../models/chat_list_model.dart';
import 'package:http/http.dart'as http;

class ChatProvider with ChangeNotifier{

  Future<void> postChatList(BuildContext context, receiverId ) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    try {
      var response = await http.post(
        Uri.parse('${MyRoutes.BASEURL}/create/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode(<String, String>{
          'id': receiverId.toString(),
        }),
      );
      if (response.statusCode == 200) {
        print("post Chat list api is working");
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: const Color(0xFFebf9fe),
            content: Text(
              'Post Chat List APi is working',
              style: Theme.of(context).textTheme.bodyMedium,
            ).tr(),
            duration: const Duration(
              seconds: 2,
            ),
          ),
        );
        notifyListeners();
      } else {
        Navigator.of(context).pop();
        print("Failed to login.");
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFebf9fe),
            content: Text(
              'postChatList Api is not Working',
              style: Theme.of(context).textTheme.bodyMedium,
            ).tr(),
            duration: const Duration(
              seconds: 2,
            ),
          ),
        );
      }
      // print(response.body.toString());
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  List<ChatListModel>? chatList;

  Future<void> getChatList() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.get(
      Uri.parse('${MyRoutes.BASEURL}/chats'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );
    if (response.statusCode == 200) {
      debugPrint('get Chats api is working');
      chatList = chatListModelFromJson(response.body);
      notifyListeners();
    } else {
      debugPrint('Get Chats Api is not working correctly');
    }
    // print(response.body);
  }

}