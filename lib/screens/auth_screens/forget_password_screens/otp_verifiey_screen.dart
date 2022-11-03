import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider/forget_password_provider.dart';
import '../../../widgets/const_widgets/custom_button.dart';

class OtpVerify extends StatefulWidget {
  final String email;
  const OtpVerify({Key? key, required this.email,}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}
class _OtpVerifyState extends State<OtpVerify> {
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    super.dispose();
  }

  void formSubmitOtp() {
    final verifyOtpData = Provider.of<ForgetPasswordProvider>(context, listen: false);
    var isValid = formKey.currentState!.validate();

    if (!isValid) {
      return ;
    }
    formKey.currentState!.save();
    print('${otp1.text}${otp2.text}${otp3.text}${otp4.text}');
    verifyOtpData.verifyOtp(context, widget.email, '${otp1.text}${otp2.text}${otp3.text}${otp4.text}');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify OTP',
                // "EmailText",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                'We heve sent verification code to',
                // "EmailText",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.email,
                  isDense: true,
                ),
                style: Theme.of(context).textTheme.bodySmall,
                enabled: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 70,
                    width: 50,
                    child: TextFormField(
                      controller: otp1,
                      onChanged: (value) {
                        if(value.length == 1){
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      inputFormatters: [LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly],
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border:  OutlineInputBorder(),
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                      enabled: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 50,
                    child: TextFormField(
                      controller: otp2,
                      onChanged: (value) {
                        if(value.length == 1){
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      inputFormatters: [LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly],
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border:  OutlineInputBorder(),
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                      enabled: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 50,
                    child: TextFormField(
                      controller: otp3,
                      onChanged: (value) {
                        if(value.length == 1){
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      inputFormatters: [LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly],
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border:  OutlineInputBorder(),
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                      enabled: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 50,
                    child: TextFormField(
                      controller: otp4,
                      onChanged: (value) {
                        if(value.length == 1){
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      inputFormatters: [LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly],
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        border:  OutlineInputBorder(),
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                      enabled: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              CustomButton(onPress: formSubmitOtp,buttonName: "Submit",),
            ],
          ),
        ),
      ),
    );
  }
}
