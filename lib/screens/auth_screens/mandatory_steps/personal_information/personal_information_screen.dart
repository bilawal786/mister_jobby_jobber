import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/const_widgets/outline_selected_button.dart';
import '../../../../../widgets/const_widgets/custom_button.dart';

import '../../../../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {

  final formKey = GlobalKey<FormState>();

  var isInit = true;
  var profileData;
  var extractedData;
  @override
  void didChangeDependencies() {
    if(isInit){
      profileData = Provider.of<PersonalInformationProvider>(context);
      extractedData = profileData.profile;
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void formSubmit() {
    // final updateProfileData = Provider.of<ProfileProvider>(context, listen: false);
    var isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    debugPrint(" first name ${profileData.firstName}");
    debugPrint(profileData.lastName);
    debugPrint(profileData.genderValue.toString());
    debugPrint(profileData.phoneNumber);
    debugPrint(profileData.statusName);
    formKey.currentState!.save();
    // updateProfileData.upDateProfile(context, firstName,lastName, updateProfileData.genderCheckTitle, updateProfileData.selectedDateOfBirth, phoneNumber, updateProfileData.countryDropDownValue, address);
  }

  @override
  Widget build(BuildContext context) {
     // profileData.statusName = extractedData?.professional.toString();
     // profileData.genderValue = extractedData.gender;
     profileData.firstName = extractedData.firstName;
     profileData.lastName = extractedData.lastName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Personal Information", style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(height: MediaQuery.of(context).size.width / 20,),
                Text(
                  "First Name",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Consumer<PersonalInformationProvider>(
                  builder:(_,info,child) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: TextFormField(
                      initialValue: extractedData.firstName,
                      autovalidateMode: AutovalidateMode.always,
                      onSaved: (value) {
                        info.firstName = value;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Text(
                  "Last Name",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Consumer<PersonalInformationProvider>(
                  builder: (_,info,child) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: TextFormField(
                      initialValue: extractedData.lastName,
                      autovalidateMode: AutovalidateMode.always,
                      onSaved: (value){
                        info.lastName = value;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Text(
                  "Sex",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Consumer<PersonalInformationProvider>(
                  builder: (_, genderData, child) => SizedBox(
                    height: 45,
                    child: ListView.builder(
                      itemCount: 2,
                      itemExtent: MediaQuery.of(context).size.width / 2.25,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          OutlineSelectedButton(
                            onTap: () => genderData.genderCheckFunction(index),
                            textTitle: index == 0 ? "Male" : "Female",
                            color: genderData.genderValue - 1 == index
                                ? Colors.blue.shade50
                                : Colors.grey.shade300,
                            border:
                            genderData.genderValue - 1 == index ? true : false,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Text(
                  "Phone number",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Consumer<PersonalInformationProvider>(
                  builder:(_,info,child) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: TextFormField(
                      initialValue: info.profile!.phone,
                      onChanged: (value){
                        info.phoneNumber = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                Text(
                  "Professional status",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Consumer<PersonalInformationProvider>(
                  builder: (_,checkStatus, child) => InkWell(
                    onTap: (){
                      checkStatus.statusPicker(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(checkStatus.statusName, style: Theme.of(context).textTheme.labelLarge,),
                          const Spacer(),
                          const Icon(Icons.arrow_drop_down_rounded, size: 30, color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  dense: true,
                  tileColor: Colors.amber.shade100,
                  leading: const Icon(
                    Icons.circle_notifications,
                    color: Colors.black,
                  ),
                  subtitle: Text(
                    "Your personal information is necessary to guarantee a good level of security. "
                        "They are secure and will never be communicated publicly. ",
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width / 10,),
                const Divider(),
                CustomButton(onPress: (){
                  formSubmit();
                }, buttonName: "Confirm"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
