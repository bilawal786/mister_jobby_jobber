import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider/forget_password_provider.dart';
import '../../../widgets/const_widgets/custom_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      multiLine: false);
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  void formSubmitEmail() {
    final verifyEmailData =
    Provider.of<ForgetPasswordProvider>(context, listen: false);
    var isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    verifyEmailData.verifyEmail(context, emailController.text);
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmPassword(email: emailController.text.toString()),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebf9fe),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
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
                      'Please enter your email',
                      // "EmailText",
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
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please Enter Valid Email Address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 25,
                    ),
                    CustomButton(
                        onPress: formSubmitEmail,
                        // ()=>
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmPassword(),),),
                        buttonName: "Confirm Email"),
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
