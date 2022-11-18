import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/routes.dart';
import '../../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import '../../../widgets/const_widgets/custom_button.dart';

class BadgeProScreen extends StatelessWidget {
  const BadgeProScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileData =
    Provider.of<PersonalInformationProvider>(context, listen: false);
    int value = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        title: Text(
          "Badge PRO",
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Image.asset(
                "assets/images/get-badges.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 40,
            ),
            Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if(profileData.profile!.pro == 1) ...[
                    Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),
                            color: Colors.grey.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20,left: 10),
                            child: Text(
                              "Waiting for Approval",
                              style: Theme.of(context).textTheme.bodyMedium,

                            ).tr(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 10,right: 10),
                          child: Text(
                            "Your request is waiting for administrator approval. Please check back later",
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.justify,
                          ).tr(),
                        ),
                      ],),
                  ),]
                  else ...[
                    Text(
                      "Go professional with PRO status",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ).tr(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Text(
                      "Activate your PRO badge, win more jobs and unlock new services like automatic invoicing.",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ).tr(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 10,
                    ),
                    CustomButton(
                        onPress: ()=> Navigator.of(context).pushNamed(MyRoutes.GETBADGEPROSCREENROUTE),
                        buttonName: "Continue"),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
