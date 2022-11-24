import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mister_jobby_jobber/screens/account_screen/subscription/subscription_screen.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../providers/preferences_provider/preferences_provider.dart';
import '../auth_screens/forget_password_screens/change_password.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefData = Provider.of<PreferencesProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        elevation: 0,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () => Navigator.of(context).pushNamed(MyRoutes.PERSONALINFORMATIONSCREENROUTE),
                    leading: Icon(
                      Icons.person_outline,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Personal_Information",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () => Navigator.of(context)
                        .pushNamed(MyRoutes.BADGEPROSCREENROUTE),
                    leading: Icon(
                      Icons.all_inbox,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Get_Pro_Badge",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .push(MaterialPageRoute(builder:(context) => const Subscription(),)),
                    leading: Icon(
                      Icons.subscriptions,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Subscription",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.REVIEWSSCREENROUTE),
                    leading: Icon(
                      Icons.reviews_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "My Reviews",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.MANAGENOTIFICATIONSSCREENROUTE),
                    leading: Icon(
                      Icons.notification_important_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Manage_My_Notifications",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .push(MaterialPageRoute(builder:(context) => const ChangePassword(),)),
                    leading: Icon(
                      Icons.key,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Change Password",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),

                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Others",
                    style: Theme.of(context).textTheme.labelLarge,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.FAQSCREENROUTE),
                    leading: Icon(
                      Icons.question_answer_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "FAQ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.HELPCENTERSCREENROUTE),
                    leading: Icon(
                      Icons.question_mark_rounded,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Account_Screen_Help_Center",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.INSURANCESETTINGSCREENROUTE),
                    leading: Icon(
                      Icons.handshake_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Account_Screen_Insurance",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.TRUSTANDSECURITYSCREENROUTE),
                    leading: Icon(
                      Icons.security_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Account_Screen_Trust_security",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.TAXCREDITSCREENROUTE),
                    leading: Icon(
                      Icons.percent_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Account_Screen_Tax_Credit",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.TERMSANDCONDITIONSSCREENROUTE),
                    leading: Icon(
                      Icons.fact_check_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "Account_Screen_Terms_conditions",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () =>Navigator.of(context)
                        .pushNamed(MyRoutes.ABOUTUSSCREENROUTE),
                    leading: Icon(
                      Icons.info_outline_rounded,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      "About",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  prefData.token == 'null'
                      ? const SizedBox()
                      : ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () => prefData.logOut(context),
                          leading: Icon(
                            Icons.exit_to_app_outlined,
                            size: 30,
                            color: Colors.red.shade700,
                          ),
                          title: Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ).tr(),
                        ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
