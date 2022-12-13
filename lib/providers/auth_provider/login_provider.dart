import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../models/auth_models/auth_model.dart';
import '../../widgets/const_widgets/progress_indicator.dart';

class LoginProvider with ChangeNotifier {
  bool checkObscure = true;
  void toggleObscure() {
    checkObscure = !checkObscure;
    notifyListeners();
  }

  Future<void> login(BuildContext context, email, password) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoginProgressIndicator();
        });
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
        Navigator.pop(context);
        Navigator.of(context).pushNamedAndRemoveUntil(
          MyRoutes.SPLASHSCREENROUTE,
          (route) => false,
        );
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: const Color(0xFFebf9fe),
            content: Text(
              'Login Successfully'.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            duration: const Duration(
              seconds: 2,
            ),
          ),
        );
        notifyListeners();
      } else if (response.statusCode == 403) {
        Navigator.of(context).pop();
        print("Failed to login. User blocked");
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFebf9fe),
            content: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade200,
                  ),
                  child: const Icon(
                    CupertinoIcons.hand_raised_fill,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Text(
                    'An Administrator has blocked you from running this app',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).tr(),
                ),
              ],
            ),
            duration: const Duration(
              seconds: 2,
            ),
          ),
        );
      } else {
        Navigator.pop(context);
        print("Failed to login.");
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: const Color(0xFFebf9fe),
            content: Text(
              'Incorrect Credentials',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
}
