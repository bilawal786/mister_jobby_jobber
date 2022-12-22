import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/routes.dart';
import '../../models/auth_models/forget_password_model.dart';
import '../../screens/auth_screens/forget_password_screens/confirm_password_screen.dart';
import '../../screens/auth_screens/forget_password_screens/otp_verifiey_screen.dart';
import '../../widgets/const_widgets/login_progress_indicator.dart';

class ForgetPasswordProvider with ChangeNotifier {
  bool checkObscure = true;
  void toggleObscure() {
    checkObscure = !checkObscure;
    notifyListeners();
  }
  Future<void> verifyOtp(BuildContext context, email, otp) async {
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const LoginProgressIndicator();
    });
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/otp/verify'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(
          <String, String>{'email': email.toString(), 'otp': otp.toString()}),
    );
    if (response.statusCode == 200) {
      debugPrint('Verify OTP Api is working');
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmPassword(email: email),
        ),
      );
      notifyListeners();
    } else if (response.statusCode == 404) {
      debugPrint('Verify OTP incorrect');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding : const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Incorrect OTP',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
      notifyListeners();
    } else {
      debugPrint('Verify OTP Api not is working');
    }
  }

  Future<void> verifyEmail(BuildContext context, email) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoginProgressIndicator();
        });
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/send/otp'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': email.toString(),
      }),
    );
    if (response.statusCode == 200) {
      debugPrint('Verify email Api is working');
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OtpVerify(email: email),
        ),
      );
      notifyListeners();
    } else if (response.statusCode == 404) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'User not exits',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
      debugPrint('Verify email not exits');
    } else {
      debugPrint('Verify email Api is not working');
    }
  }

  Future<void> forgetPassword(BuildContext context, email, password) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoginProgressIndicator();
        });
    var response = await http.post(
        Uri.parse('${MyRoutes.BASEURL}/forget/password'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'email': email.toString(),
          'password': password.toString(),
          'role': 1.toString()
        }));
    if (response.statusCode == 200) {
      final forgetPassword =
      ForgetPasswordModel.fromJson(jsonDecode(response.body));
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
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Password Changed Successfully',
            style:Theme.of(context).textTheme.bodyMedium,
          ),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
      debugPrint('Change Password Api is working');
      notifyListeners();
    } else {
      debugPrint('Change Password Api is not working');
      Navigator.pop(context);
    }
  }
}