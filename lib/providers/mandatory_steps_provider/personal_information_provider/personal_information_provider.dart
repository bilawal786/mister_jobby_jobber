import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInformationProvider with ChangeNotifier {
  int genderValue = 0;
  String gender = "";

  void checkGenderValue(int index) {
    genderValue = index + 1;
    if (genderValue == 1) {
      gender = "Yes".tr();
    } else {
      gender = "No".tr();
    }
    notifyListeners();
  }

  int status = 1;
  String statusName = "Entrepreneur";

  void checkStatusValue(BuildContext context ,int? value) {
    status = value!;
    if(status == 1){
      statusName = "Entrepreneur";
    } else if (status == 2){
      statusName = "Student";
    }
    else if (status == 3){
      statusName = "Retirement";
    }
    else if (status == 4){
      statusName = "Employee";
    }
    else if (status == 5){
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
              builder: (_,statusCheck, child) => Column(
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
                    onChanged: (v) {statusCheck.checkStatusValue(context, v);},
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
                    onChanged: (v) {statusCheck.checkStatusValue(context, v);},
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
                    onChanged: (v) {statusCheck.checkStatusValue(context, v);},
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
                    onChanged:(v) {statusCheck.checkStatusValue(context, v);},
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
                    onChanged: (v) {statusCheck.checkStatusValue(context, v);},
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
}
