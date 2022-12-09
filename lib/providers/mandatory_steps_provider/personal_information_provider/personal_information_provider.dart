import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';

import '../../../models/mandatory_steps_model/jobber_profile_model/jobber_profile_model.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';
import '../../check_profile_completion_provider/check_profile_completion_provider.dart';

class PersonalInformationProvider with ChangeNotifier {
  int genderValue = 0;
  String gender = "";

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? changeFName;
  String? changeLName;
  String? changePhoneNumber;
  String? changeDescription;



  getFirstName(value){
    changeFName = value;
    notifyListeners();
  }
  getLastName(value){
    changeLName = value;
    notifyListeners();
  }
  getPhoneNumber(value){
    changePhoneNumber = value;
    notifyListeners();
  }
  getDescription(value){
    changeDescription = value;
    notifyListeners();
  }


  void genderCheckFunction(index, getGender) {
    genderValue = getGender;
    genderValue = index + 1;
    if (genderValue == 1) {
      gender = "Male".tr();
    } else {
      gender = "Female".tr();
    }
    debugPrint(gender);
    debugPrint(genderValue.toString());
    notifyListeners();
  }
  int status = 1;
  String statusName = "";

  void checkStatusValue(
    BuildContext context,
    int? value,
  ) {
    status = value!;
    if (status == 1) {
      statusName = "Entrepreneur";
    } else if (status == 2) {
      statusName = "Student";
    } else if (status == 3) {
      statusName = "Retirement";
    } else if (status == 4) {
      statusName = "Employee";
    } else if (status == 5) {
      statusName = "Un Employed";
    }
    notifyListeners();
    Navigator.of(context).pop();
  }

  statusPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(10),
            child: Consumer<PersonalInformationProvider>(
              builder: (_, statusCheck, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose your status",
                    style: Theme.of(context).textTheme.titleSmall,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  RadioListTile(
                    dense: true,
                    value: 1,
                    groupValue: statusCheck.status,
                    onChanged: (v) {
                      statusCheck.checkStatusValue(context, v);
                    },
                    title: Text(
                      "Entrepreneur",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Divider(),
                  RadioListTile(
                    dense: true,
                    value: 2,
                    groupValue: statusCheck.status,
                    onChanged: (v) {
                      statusCheck.checkStatusValue(context, v);
                    },
                    title: Text(
                      "Students",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Divider(),
                  RadioListTile(
                    dense: true,
                    value: 3,
                    groupValue: statusCheck.status,
                    onChanged: (v) {
                      statusCheck.checkStatusValue(context, v);
                    },
                    title: Text(
                      "Retirement",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Divider(),
                  RadioListTile(
                    dense: true,
                    value: 4,
                    groupValue: statusCheck.status,
                    onChanged: (v) {
                      statusCheck.checkStatusValue(context, v);
                    },
                    title: Text(
                      "Employee",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Divider(),
                  RadioListTile(
                    dense: true,
                    value: 5,
                    groupValue: statusCheck.status,
                    onChanged: (v) {
                      statusCheck.checkStatusValue(context, v);
                    },
                    title: Text(
                      "Un Employed",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  JobberProfileModel? profile;

  Future<void> getProfile(context) async {

    final SharedPreferences sharePref = await SharedPreferences.getInstance();
    String? token = sharePref.getString('token');
    int? id = sharePref.getInt('jobberId');
    debugPrint(id.toString());
    var response = await http.get(
        Uri.parse('${MyRoutes.BASEURL}/jobber/profile/$id'),
        headers: <String, String>{
          'Accept': "application/json",
          'Content-Type': "application/json",
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      debugPrint('get profile successfully');
      profile = JobberProfileModel.fromJson(jsonDecode(response.body));
      notifyListeners();
    }else if(response.statusCode == 401){
      debugPrint('error: 401');
      Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.LOGINSCREENROUTE, (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content:  Text(
            'Session Expired...  Please Log-In',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    }
    else{
      Navigator.of(context).pushNamed(MyRoutes.ERRORSCREENROUTE);
      debugPrint('get profile api not working');
    }
  }

  Future<void> updateProfile(
    context,
    fName,
    lName,
    gender,
    number,
    prof,
      description,
  ) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/profile/update'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode(<String, String>{
        'firstName': fName.toString(),
        'lastName': lName.toString(),
        'phone': number.toString(),
        'gender': gender.toString(),
        'professional': prof.toString(),
        'description': description.toString(),
      }),
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Provider.of<PersonalInformationProvider>(context,listen: false).getProfile(context);
      Provider.of<CheckProfileCompletionProvider>(context, listen: false).getProfileCompletionData(context);
      debugPrint("Profile Updated");
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Profile Updated Successfully',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    } else if(response.statusCode == 401){
      debugPrint('error: 401');
      Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.LOGINSCREENROUTE, (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content:  Text(
            'Session Expired...  Please Log-In',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    }
    else{
      Navigator.pop(context);
      debugPrint("Profile Not Updated");
    }
  }
}
