import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider/forget_password_provider.dart';
import '../../../widgets/const_widgets/custom_button.dart';

class ConfirmPassword extends StatefulWidget {
  final String email ;
  const ConfirmPassword({Key? key,required this.email}) : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void formSubmit() {
    final forgetPasswordData = Provider.of<ForgetPasswordProvider>(context, listen: false);
    var isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    formKey.currentState!.save();

    forgetPasswordData.forgetPassword(
      context,
      widget.email,
      passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFebf9fe),elevation: 0,foregroundColor: Colors.black),
      backgroundColor: const Color(0xFFebf9fe),
      body: SingleChildScrollView(
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Email",
                      style: Theme.of(context).textTheme.titleSmall,
                    ).tr(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    TextFormField(
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: widget.email,
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                      enabled: false,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Text(
                      "New Password",
                      style: Theme.of(context).textTheme.titleSmall,
                    ).tr(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Consumer<ForgetPasswordProvider>(
                      builder: (_, toggle, child) => TextFormField(
                        enableSuggestions: false,
                        controller: passwordController,
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
                        style: Theme.of(context).textTheme.bodySmall,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter the password';
                          } else if (value.length < 5) {
                            return 'Must be more than 5 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Text(
                      "Confirm New Password",
                      style: Theme.of(context).textTheme.titleSmall,
                    ).tr(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Consumer<ForgetPasswordProvider>(
                      builder: (_, toggle, child) => TextFormField(
                        enableSuggestions: false,
                        controller: confirmPasswordController,
                        obscureText: toggle.checkObscure,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Confirm Password".tr(),
                          isDense: true,
                          suffixIcon: GestureDetector(
                            onTap: toggle.toggleObscure,
                            child: Icon(toggle.checkObscure == false
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter the password';
                          } else if (value.length < 5) {
                            return 'Must be more than 5 characters';
                          }else if(value != passwordController.text){
                            return 'Password not matched';

                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 25,
                    ),
                    CustomButton(onPress: formSubmit, buttonName: "Continue"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
