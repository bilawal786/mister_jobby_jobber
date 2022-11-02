import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/routes.dart';
import '../../models/auth_models/forget_password_model.dart';
import '../../widgets/const_widgets/login_progress_indicator.dart';

class ForgetPasswordProvider with ChangeNotifier{
  bool checkObscure = true;
  void toggleObscure() {
    checkObscure = !checkObscure;
    notifyListeners();
  }

  Future<void> forgetPassword(BuildContext context, email, password)async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    var response = await http.post(Uri.parse('${MyRoutes.BASEURL}/forget/password'),
    headers: <String, String>{
      'Accept':'application/json',
      'Content-Type':'application/json'
    },
    body: jsonEncode(<String, String>{
      'email':email.toString(),
      'password':password.toString(),
          'role':1.toString()
        })
    );
    if(response.statusCode == 200){
      final forgetPassword = ForgetPasswordModel.fromJson(jsonDecode(response.body));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', forgetPassword.success.token);
      await prefs.setInt('jobberId', forgetPassword.success.id);
      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil(
        MyRoutes.SPLASHSCREENROUTE,
            (route) => false,
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Password Changed Successfully',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      debugPrint('Forget Password Api is working');
      notifyListeners();
    }else{
    debugPrint('Forget Password Api is not working');
    }
  }
}