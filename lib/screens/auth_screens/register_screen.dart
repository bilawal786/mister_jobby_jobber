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
  //   var isValid = formKey.currentState!.validate();
  //   if (!isValid) {
  //     print("isNotValid");
  //   }
  //   formKey.currentState!.save();

    Navigator.of(context).pushNamed(MyRoutes.MANDATORYSTEPSSCREENROUTE);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 7,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                1, 2), // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: .3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Register_Screen_Title",
                              style: Theme.of(context).textTheme.titleLarge,
                            ).tr(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 30,
                          ),
                          const Divider(),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 30,
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
                                  height: MediaQuery.of(context).size.width / 40,
                                ),
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  height: MediaQuery.of(context).size.width / 40,
                                ),
                                Text(
                                  "Last_Name",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ).tr(),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width / 40,
                                ),
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                      return "Please Enter Last Name";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width / 40,
                                ),
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
                                Consumer<RegisterProvider>(
                                  builder: (_,toggle, child) => TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
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
                            height: MediaQuery.of(context).size.width / 40,
                          ),

                          CustomButton(
                              onPress: formSubmit, buttonName: "Register_Screen_Title"),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already_Account_Title".tr(),
                                style:
                                Theme.of(context).textTheme.labelMedium,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 40,
                              ),
                              InkWell(
                                onTap: ()=>Navigator.of(context).pushReplacementNamed(MyRoutes.LOGINSCREENROUTE),
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
