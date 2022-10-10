import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/const_widgets/custom_button.dart';

class MisterJobbyInsuranceScreen extends StatelessWidget {
  const MisterJobbyInsuranceScreen({Key? key}) : super(key: key);

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
                    "Mister Jobby insurance",
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
                      "You are covered against breakage.",
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
                      "You are covered against injury to others.",
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
                      "In the event of a claim, you have nothing to pay because there is no deductible.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width /40,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 1.5,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  CustomButton(onPress: (){}, buttonName: "Skip to quiz"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
