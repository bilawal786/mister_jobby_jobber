import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../helper/routes.dart';

class MandatoryStepsScreen extends StatelessWidget {
  const MandatoryStepsScreen({Key? key}) : super(key: key);

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
                    "Welcome,",
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Text(
                    "Here is the list of things you need to do before you can apply for the jobs.",
                    style: Theme.of(context).textTheme.labelMedium,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  Text(
                    "Mandatory Steps",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(MyRoutes.INDICATESKILLSROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Indicate your skills",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(MyRoutes.AVAILABILITIESSCREENROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Complete your availabilities",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(MyRoutes.PROGRESSSERVICESROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Discover secure payment",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(MyRoutes.INSURANCESCREENROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Discover the insurance",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(MyRoutes.LEARNRULESSCREENROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Learn the rules",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(MyRoutes.RELIABILITYSCOREROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Discover the reliability score",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.of(context).pushNamed(MyRoutes.PROFILEPICTUREADDSCREENROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Add your profile picture",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () => Navigator.of(context).pushNamed(MyRoutes.PERSONALINFORMATIONSCREENROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Complete your personal information",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: ()=> Navigator.of(context).pushNamed(MyRoutes.VALIDIDENTITYDOCUMENTSCREENROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Valid identity documents",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: ()=> Navigator.of(context).pushNamed(MyRoutes.SOCIALSECURITYCERTIFICATEROUTE),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      "Social security certificate",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
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
