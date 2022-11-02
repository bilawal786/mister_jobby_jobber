import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../helper/routes.dart';
import '../../providers/auth_provider/login_provider.dart';
import '../../widgets/const_widgets/custom_button.dart';
import 'forget_password_screens/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      multiLine: false);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void formSubmit() {
    final loginData = Provider.of<LoginProvider>(context, listen: false);
    var isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    loginData.login(context, emailController.text, passwordController.text,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebf9fe),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width/1.4,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/login.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "EmailText",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ).tr(),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width / 40,
                                ),
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: "EmailText".tr(),
                                    isDense: true,
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall,
                                  enabled: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Email Address";
                                    }else if (!regExp.hasMatch(value)) {
                                      return 'Please Enter Valid Email Address';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width / 40,
                                ),
                                Text(
                                  "PasswordText",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ).tr(),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width / 40,
                                ),
                                Consumer<LoginProvider>(
                                  builder: (_,toggle, child) => TextFormField(
                                    enableSuggestions: false,
                                    controller: passwordController,
                                    obscureText: toggle.checkObscure,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: "PasswordText".tr(),
                                      isDense: true,
                                      suffixIcon: GestureDetector(
                                        onTap: toggle.toggleObscure,
                                          child: Icon(toggle.checkObscure == false ? Icons.visibility_off: Icons.visibility),),
                                    ),
                                    style: Theme.of(context).textTheme.bodySmall,
                                    enabled: true,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Please Enter the password';
                                      }else if(value.length < 5) {
                                        return 'Must be more than 5 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 25,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
                              ));
                            },
                            child: Text(
                              "Forgot_Button_Text".tr(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 25,
                          ),
                          CustomButton(
                              onPress: formSubmit, buttonName: "Login_Screen_Title"),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't_Have_Account_Title".tr(),
                                style:
                                    Theme.of(context).textTheme.labelMedium,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 40,
                              ),
                              InkWell(
                                onTap: () => Navigator.of(context).pushReplacementNamed(MyRoutes.REGISTERROUTE),
                                child: Text(
                                  "Register_Screen_Title".tr(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                    fontFamily: 'Cerebri Sans Bold',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 25,
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
