import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../models/auth_models/auth_model.dart';

class LoginProvider with ChangeNotifier {
  bool checkObscure = true;
  void toggleObscure() {
    checkObscure = !checkObscure;
    notifyListeners();
  }

  Future<void> login(BuildContext context, email, password) async {
    try {
      var response = await http.post(
        Uri.parse('${MyRoutes.BASEURL}/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'email': email.toString(),
          'password': password.toString(),
          'role': 1.toString(),
        }),
      );
      if (response.statusCode == 200) {
        final login = AuthModel.fromJson(jsonDecode(response.body));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', login.success.token);
        await prefs.setInt('jobberId', login.success.id);
        Navigator.of(context).pushNamedAndRemoveUntil(
          MyRoutes.HOMESCREENROUTE,
              (route) => false,
        );
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Login Successfully',
              // textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
        notifyListeners();
      } else {
        print("Failed to login.");
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Incorrect Credentials',
              // textAlign: TextAlign.center,
            ),
            duration: Duration(
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

}
