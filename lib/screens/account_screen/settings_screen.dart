import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../widgets/const_widgets/custom_list_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        elevation: 0,
        title: Text("Settings", style: Theme.of(context).textTheme.titleMedium,).tr(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Manage_account",
                    style: Theme.of(context).textTheme.labelLarge,
                  ).tr(),
                  CustomListTile(
                    leadingIcon: Icons.person_outline,
                    title: 'Personal_Information',
                    onPress: () {},
                  ),
                  CustomListTile(
                    leadingIcon:
                    Icons.account_balance_wallet_outlined,
                    title: 'Identity_Documents',
                    onPress: () {},
                  ),
                  CustomListTile(
                    leadingIcon: Icons.all_inbox,
                    title: 'Get_Pro_Badge',
                    onPress: () {},
                  ),
                  CustomListTile(
                      onPress: () {},
                      leadingIcon:
                      Icons.notification_important_outlined,
                      title: 'Manage_My_Notifications'),
                ],
              ),
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Others",
                    style: Theme.of(context).textTheme.labelLarge,
                  ).tr(),
                  CustomListTile(
                    leadingIcon: Icons.question_answer_outlined,
                    title: 'FAQ',
                    onPress: () {},
                  ),
                  CustomListTile(
                    onPress: () {},
                    leadingIcon: Icons.question_mark_rounded,
                    title: "Account_Screen_Help_Center",
                  ),
                  CustomListTile(
                    onPress: () {},
                    leadingIcon: Icons.handshake_outlined,
                    title: "Account_Screen_Insurance",
                  ),
                  CustomListTile(
                    onPress: () {},
                    leadingIcon: Icons.security_outlined,
                    title: "Account_Screen_Trust_security",
                  ),
                  CustomListTile(
                    onPress: () {},
                    leadingIcon: Icons.percent_outlined,
                    title: "Account_Screen_Tax_Credit",
                  ),
                  CustomListTile(
                    onPress: () {},
                    leadingIcon: Icons.fact_check_outlined,
                    title: "Account_Screen_Terms_conditions",
                  ),
                  CustomListTile(
                    onPress: () {},
                    leadingIcon: Icons.info_outline_rounded,
                    title: "About",
                  ),
                  CustomListTile(
                    onPress: () {},
                    leadingIcon: Icons.info_outline_rounded,
                    title: "Test",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
