import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mister_jobby_jobber/providers/accounts_providers/terms_and_condition_provider/terms_and_condition_provider.dart';
import 'package:mister_jobby_jobber/providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import 'package:mister_jobby_jobber/providers/faq_provider.dart';
import 'package:mister_jobby_jobber/providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import 'package:provider/provider.dart';

import '../providers/accounts_providers/about_provider/about_provider.dart';
import '../providers/preferences_provider/preferences_provider.dart';

import '../../../../providers/mandatory_steps_provider/indicate_skills_provider/indicate_skills_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<PreferencesProvider>(context, listen: false).checkToken(context);
      Provider.of<IndicateSkillsProvider>(context).getMainCategories();
      Provider.of<CheckProfileCompletionProvider>(context).getProfileCompletionData();
      Provider.of<PersonalInformationProvider>(context).getProfile();
      Provider.of<FAQProvider>(context).getFAQ();
      Provider.of<AboutProvider>(context).getAbout();
      Provider.of<TermsAndConditonProvider>(context).getTermsAndConditions();
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  "Splash_Heading",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cerebri Sans Bold',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ).tr(),
                SizedBox(
                  height: mediaQuery.size.width / 5,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.handyman_rounded,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Text(
                            "Diy",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ).tr(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width / 40,
                    ),
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.pets,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Text(
                            "Pet_Sitting",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ).tr(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.size.width / 40,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.snowshoeing,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Text(
                            "Gardening",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ).tr(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width / 40,
                    ),
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.format_paint_rounded,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Text(
                            "Housework",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ).tr(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.size.width / 40,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.computer_rounded,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Expanded(
                            child: Text(
                              "Computer_Science",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width / 40,
                    ),
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.child_friendly_rounded,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Text(
                            "Child_Care",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ).tr(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.size.width / 40,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_bag_rounded,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Expanded(
                            child: Text(
                              "Move",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: mediaQuery.size.width / 40,
                    ),
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.history_edu,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Expanded(
                            child: Text(
                              "Private_Lessons",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.size.width / 40,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: mediaQuery.size.width / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.bakery_dining_outlined,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: mediaQuery.size.width / 40,
                          ),
                          Expanded(
                            child: Text(
                              "Home_Help",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.size.width / 40,
                ),
                SizedBox(
                  height: mediaQuery.size.width / 2.5,
                  child: Image.asset(
                    "assets/images/appLogo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
