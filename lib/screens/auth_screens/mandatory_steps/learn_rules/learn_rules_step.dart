import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../helper/routes.dart';
import '../../../../widgets/const_widgets/custom_button.dart';

class LearnRulesStepScreen extends StatelessWidget {
  const LearnRulesStepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "The 3 rules to respect.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      "I respect the date and time requested by the client.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "2",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      "I respect the hourly rate on which I have committed.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "3",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      "I do not cancel the services on which I have committed.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 1.2,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  CustomButton(onPress: ()=> Navigator.of(context).pushNamed(MyRoutes.RULESSTEPSCREENROUTE), buttonName: "Skip to quiz"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
