import 'package:flutter/material.dart';

import '../../../helper/routes.dart';
import '../../../widgets/const_widgets/custom_button.dart';

class BadgeProScreen extends StatelessWidget {
  const BadgeProScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black45,
          size: 25,
        ),
        title: Text(
          "Badge PRO",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
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
            padding: const EdgeInsets.all(40),
            child: Column(
              children: <Widget>[
                Text(
                  "Go professional with PRO status",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Text(
                  "Activate your PRO badge, win more jobs and unlock new services like automatic invoicing.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 10,
                ),
                CustomButton(
                    onPress: ()=> Navigator.of(context).pushNamed(MyRoutes.GETBADGEPROSCREENROUTE),
                    buttonName: "Continue"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
