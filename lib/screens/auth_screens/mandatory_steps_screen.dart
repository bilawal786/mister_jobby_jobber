import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';

import '../../providers/mandatory_steps_provider/european_identity_verification/european_identification.dart';
import '../../providers/mandatory_steps_provider/non_european_identification_provider/non_euro_identification_provider.dart';
import '../../providers/mandatory_steps_provider/profile_image_provider/profile_image_provider.dart';
import '../../providers/mandatory_steps_provider/rules_provider/rules_provider.dart';
import '../../providers/mandatory_steps_provider/social_security/social_security_provider.dart';
import '../../providers/mandatory_steps_provider/time_availability_provider/availability_provider.dart';
import '../../providers/mandatory_steps_provider/service_provider/services_provider.dart';
import '../../providers/mandatory_steps_provider/insurance_provider/insurance_provider.dart';

class MandatoryStepsScreen extends StatelessWidget {
  const MandatoryStepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availabilityData = Provider.of<AvailabilityProvider>(context);
    final servicesData = Provider.of<ServicesProvider>(context);
    final insuranceData = Provider.of<InsuranceProvider>(context);
    final rulesData = Provider.of<RulesProvider>(context);
    final profileImageData = Provider.of<ProfileImageProvider>(context);
    final euroData = Provider.of<EuropeanIdentificationProvider>(context);
    final nonEuroData = Provider.of<NonEuroIdentificationProvider>(context);
    final securityData = Provider.of<SocialSecurityProvider>(context);
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
                  if (availabilityData.availabilityCompleted == false) ...[
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
                  ],
                  if (servicesData.servicesCompleted == false) ...[
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
                  ],
                  if (insuranceData.insuranceCompleted == false) ...[
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
                  ],
                  if (rulesData.rulesCompleted == false) ...[
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
                  ],
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
                  if (profileImageData.profileImageCompleted == false) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.PROFILEPICTUREADDSCREENROUTE),
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
                  ],
                  ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(MyRoutes.PERSONALINFORMATIONSCREENROUTE),
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
                  if (euroData.euroCompleted == false &&
                      nonEuroData.nonEuroCompleted == false) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.VALIDIDENTITYDOCUMENTSCREENROUTE),
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
                  ],
                  if (securityData.securityCompleted == false) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.SOCIALSECURITYCERTIFICATEROUTE),
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
                  if (availabilityData.availabilityCompleted == true ||
                      servicesData.servicesCompleted == true ||
                      insuranceData.insuranceCompleted == true ||
                      rulesData.rulesCompleted == true ||
                      profileImageData.profileImageCompleted == true ||
                      (euroData.euroCompleted == true ||
                          nonEuroData.nonEuroCompleted == true) ||
                      securityData.securityCompleted == true) ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 20,
                    ),
                    Text(
                      "Completed Steps",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 20,
                    ),
                  ],
                  if (availabilityData.availabilityCompleted == true) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.AVAILABILITIESSCREENROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if (servicesData.servicesCompleted == true) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.PROGRESSSERVICESROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if (insuranceData.insuranceCompleted == true) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.INSURANCESCREENROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if (rulesData.rulesCompleted == true) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.LEARNRULESSCREENROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if (profileImageData.profileImageCompleted == true) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.PROFILEPICTUREADDSCREENROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if (euroData.euroCompleted == true ||
                      nonEuroData.nonEuroCompleted == true) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.VALIDIDENTITYDOCUMENTSCREENROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if (securityData.securityCompleted == true) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.SOCIALSECURITYCERTIFICATEROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
