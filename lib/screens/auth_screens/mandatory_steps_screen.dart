import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';

import '../../providers/mandatory_steps_provider/jobber_check_skills_provider/jobber_check_skills_provider.dart';
import '../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import '../../providers/check_profile_completion_provider/check_profile_completion_provider.dart';

class MandatoryStepsScreen extends StatefulWidget {
  const MandatoryStepsScreen({Key? key}) : super(key: key);

  @override
  State<MandatoryStepsScreen> createState() => _MandatoryStepsScreenState();
}

class _MandatoryStepsScreenState extends State<MandatoryStepsScreen> {
  var isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      Provider.of<PersonalInformationProvider>(context, listen: false)
          .getProfile();
      Provider.of<JobberCheckSkillsProvider>(context, listen: false)
          .getCheckSkills();
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final checkCompleteProfile =
        Provider.of<CheckProfileCompletionProvider>(context);
    final extractedCompleteData = checkCompleteProfile.checkProfileComplete;
    final profileData = Provider.of<PersonalInformationProvider>(context);
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
                  if (extractedCompleteData?.skills1 == null &&
                      extractedCompleteData?.skills2 == null) ...[
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
                  ],
                  if (extractedCompleteData?.monday == null ||
                      extractedCompleteData!.monday.isEmpty ||
                      extractedCompleteData.tuesday == 'null' ||
                      extractedCompleteData.tuesday.isEmpty ||
                      extractedCompleteData.wednesday == 'null' ||
                      extractedCompleteData.wednesday.isEmpty ||
                      extractedCompleteData.thersday == 'null' ||
                      extractedCompleteData.thersday.isEmpty ||
                      extractedCompleteData.friday == 'null' ||
                      extractedCompleteData.friday.isEmpty ||
                      extractedCompleteData.saturday == 'null' ||
                      extractedCompleteData.saturday.isEmpty ||
                      extractedCompleteData.sunday == 'null' ||
                      extractedCompleteData.sunday.isEmpty) ...[
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
                  if (extractedCompleteData?.answer1 == null ||
                      extractedCompleteData?.answer1 == '' ||
                      extractedCompleteData!.answer1.isEmpty ||
                      extractedCompleteData.answer1 == 'null') ...[
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
                  if (extractedCompleteData?.insurance1 == null) ...[
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
                  if (extractedCompleteData?.rules1 == null) ...[
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
                  if (extractedCompleteData?.score == null) ...[
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
                  ],
                  if (profileData.profile?.image == 'main/avatar.png') ...[
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
                  if (profileData.profile?.phone == 'null' ||
                      profileData.profile?.phone == '') ...[
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
                  ],
                  if (extractedCompleteData?.euIdCardFront == null &&
                      extractedCompleteData?.euIdResidencePermitFront ==
                          null) ...[
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
                  if (extractedCompleteData?.vitalCardNumber == null &&
                      extractedCompleteData?.socialSecurityNumber == null) ...[
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
                  if ((extractedCompleteData?.skills1 != null &&
                          extractedCompleteData?.skills2 != null) ||
                      (extractedCompleteData?.monday != null ||
                          extractedCompleteData?.tuesday != null ||
                          extractedCompleteData?.wednesday != null ||
                          extractedCompleteData?.thersday != null ||
                          extractedCompleteData?.friday != null ||
                          extractedCompleteData?.saturday != null ||
                          extractedCompleteData?.sunday != null) ||
                      extractedCompleteData?.answer1 != null ||
                      extractedCompleteData?.insurance1 != null ||
                      extractedCompleteData?.rules1 != null ||
                      profileData.profile?.image != 'main/avatar.png' ||
                      (profileData.profile?.phone != '') ||
                      (extractedCompleteData?.euIdCardFront != null ||
                          extractedCompleteData?.euIdCardFront != "" ||
                          extractedCompleteData?.euIdResidencePermitFront !=
                              null) ||
                      (extractedCompleteData?.vitalCardNumber != null ||
                          extractedCompleteData?.socialSecurityNumber !=
                              null) ||
                      extractedCompleteData?.score != null) ...[
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
                  if (extractedCompleteData?.skills1 != null &&
                      extractedCompleteData?.skills2 != null) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.INDICATESKILLSROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if (extractedCompleteData?.monday != null ||
                      extractedCompleteData?.tuesday != null ||
                      extractedCompleteData?.wednesday != null ||
                      extractedCompleteData?.thersday != null ||
                      extractedCompleteData?.friday != null ||
                      extractedCompleteData?.saturday != null ||
                      extractedCompleteData?.sunday != null) ...[
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
                  if (extractedCompleteData?.answer1 != null) ...[
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
                  if (extractedCompleteData?.insurance1 != null) ...[
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
                  if (extractedCompleteData?.score != null) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.RELIABILITYSCOREROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if (extractedCompleteData?.rules1 != null) ...[
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
                  if (profileData.profile?.image != 'main/avatar.png') ...[
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
                  if (profileData.profile?.phone != '') ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.PERSONALINFORMATIONSCREENROUTE),
                      dense: true,
                      leading: Icon(
                        Icons.check_box,
                        size: 25,
                        color: Colors.green.shade700,
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
                  ],
                  if ((extractedCompleteData?.euIdCardFront != null ||
                          extractedCompleteData?.euIdCardFront != "") ||
                      (extractedCompleteData?.euIdResidencePermitFront !=
                              null ||
                          extractedCompleteData?.euIdResidencePermitFront !=
                              "")) ...[
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
                  if (extractedCompleteData?.vitalCardNumber != null ||
                      extractedCompleteData?.socialSecurityNumber != null) ...[
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
