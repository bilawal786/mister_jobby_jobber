import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import '../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import '../../widgets/const_widgets/custom_button.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkCompleteProfile =
    Provider.of<CheckProfileCompletionProvider>(context);
    final extractedCompleteData = checkCompleteProfile.checkProfileComplete;
    final profileData = Provider.of<PersonalInformationProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            elevation: 0,
            expandedHeight: 60,
            pinned: true,
            floating: true,
            snap: true,
            title: Container(
                // color: Colors.red,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 30),
                child: Text(
                  "Home_AppBar_Title",
                  style: Theme.of(context).textTheme.titleLarge,
                ).tr()),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pushNamed(MyRoutes.EVENTCALENDERSCREENROUTE),
                  icon: const Icon(
                    Icons.date_range,
                    color: Colors.amber,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 8.0),
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: ()=> Navigator.of(context).pushNamed(MyRoutes.NOTIFICATIONSCREENROUTE),
                      icon: const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.amber,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 5,
                      child: Container(
                        height: 7,
                        width: 7,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            centerTitle: false,
            backgroundColor: Colors.white,
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if ((extractedCompleteData?.skills1 == 'null' &&
                  extractedCompleteData?.skills2 == 'null') ||
                  (extractedCompleteData?.monday == 'null' ||
                      extractedCompleteData?.tuesday == 'null' ||
                      extractedCompleteData?.wednesday == 'null' ||
                      extractedCompleteData?.thersday == 'null' ||
                      extractedCompleteData?.friday == 'null' ||
                      extractedCompleteData?.saturday == 'null' ||
                      extractedCompleteData?.sunday == 'null') ||
                  extractedCompleteData?.answer1 == 'null' ||
                  extractedCompleteData?.insurance1 == 'null' ||
                  extractedCompleteData?.rules1 == 'null' ||
                  profileData.profile?.image == 'main/avatar.png' ||
                  profileData.profile?.phone == 'null' ||
                  (extractedCompleteData?.euIdCardFront == 'null' ||
                      extractedCompleteData?.euIdResidencePermitFront ==
                          'null') ||
                  (extractedCompleteData?.vitalCardNumber == 'null' ||
                      extractedCompleteData?.socialSecurityNumber ==
                          'null') ||
                  extractedCompleteData?.score == 0) ... [
              GestureDetector(
                onTap: ()=> Navigator.of(context).pushNamed(MyRoutes.MANDATORYSTEPSSCREENROUTE),
                child: Container(
                  color: Colors.amber.shade700,
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.circle_notifications_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: mediaQuery.size.width / 40,
                      ),
                      Text(
                        "Actions required",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.size.width / 40,
              ),
              ],
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: mediaQuery.size.width / 2.2,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade50,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "0",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(
                                height: mediaQuery.size.width / 80,
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.save,
                                    size: 14,
                                    color: Colors.black38,
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width / 80,
                                  ),
                                  Text(
                                    "Current Offers",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width / 2.2,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.green.shade700,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "0",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(
                                height: mediaQuery.size.width / 80,
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.save,
                                    size: 14,
                                    color: Colors.black38,
                                  ),
                                  SizedBox(
                                    width: mediaQuery.size.width / 80,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 5,
                                    child: Text(
                                      "Commented jobs",
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.labelMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                height: mediaQuery.size.width / 10,
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Theme.of(context).primaryColor,
                      size: 150,
                    ),
                    SizedBox(
                      height: mediaQuery.size.width / 30,
                    ),
                    Text(
                      "No job planned soon",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: mediaQuery.size.width / 40,
                    ),
                    Text(
                      "Go to your job list to find your next job.",
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: mediaQuery.size.width / 20,
                    ),
                    CustomButton(onPress: (){}, buttonName: "Find_Job"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
