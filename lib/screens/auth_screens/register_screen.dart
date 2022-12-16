import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../providers/auth_provider/register_provider.dart';
import '../../widgets/const_widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      multiLine: false);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void formSubmit() {
    final registerData = Provider.of<RegisterProvider>(context, listen: false);
    var isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    registerData.registration(
      context,
      firstNameController.text,
      lastNameController.text,
      emailController.text,
      passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebf9fe),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.width/1.2,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset('assets/images/mr-jobber-logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First_Name",
                                style: Theme.of(context).textTheme.titleSmall,
                              ).tr(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width / 40,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: firstNameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "First_Name".tr(),
                                  isDense: true,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                                enabled: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter First Name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width / 40,
                              ),
                              Text(
                                "Last_Name",
                                style: Theme.of(context).textTheme.titleSmall,
                              ).tr(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width / 40,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: lastNameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "Last_Name".tr(),
                                  isDense: true,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                                enabled: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Last Name".tr();
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width / 40,
                              ),
                              Text(
                                "EmailText",
                                style: Theme.of(context).textTheme.titleSmall,
                              ).tr(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width / 40,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "EmailText".tr(),
                                  isDense: true,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                                enabled: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Email Address".tr();
                                  } else if (!regExp.hasMatch(value)) {
                                    return 'Please Enter Valid Email Address'.tr();
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width / 40,
                              ),
                              Text(
                                "PasswordText",
                                style: Theme.of(context).textTheme.titleSmall,
                              ).tr(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width / 40,
                              ),
                              Consumer<RegisterProvider>(
                                builder: (_, toggle, child) => TextFormField(
                                  enableSuggestions: false,
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: toggle.checkObscure,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: "PasswordText".tr(),
                                    isDense: true,
                                    suffixIcon: GestureDetector(
                                      onTap: toggle.toggleObscure,
                                      child: Icon(toggle.checkObscure == false
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                  ),
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                  enabled: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter the password'.tr();
                                    } else if (value.length < 5) {
                                      return 'Must be more than 5 characters'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        CustomButton(
                            onPress: formSubmit,
                            buttonName: "Register_Screen_Title"),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already_Account_Title".tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context)
                                  .pushReplacementNamed(
                                      MyRoutes.LOGINSCREENROUTE),
                              child: Text(
                                "Login_Screen_Title".tr(),
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
