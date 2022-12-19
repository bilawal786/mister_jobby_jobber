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
      Provider.of<PersonalInformationProvider>(context)
          .getProfile(context);
      Provider.of<JobberCheckSkillsProvider>(context)
          .getCheckSkills(context);
      Provider.of<CheckProfileCompletionProvider>(context)
          .getProfileCompletionData(context);
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final checkCompleteProfile =
        Provider.of<CheckProfileCompletionProvider>(context, listen: true);
    final extractedCompleteData = checkCompleteProfile.checkProfileComplete;
    final profileData = Provider.of<PersonalInformationProvider>(context, listen: false);
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
                  if (extractedCompleteData?.skills == "") ...[
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
                  if (extractedCompleteData?.monday == "" ||
                      extractedCompleteData?.tuesday == "" ||
                      extractedCompleteData?.wednesday == "" ||
                      extractedCompleteData?.thersday == "" ||
                      extractedCompleteData?.friday == "" ||
                      extractedCompleteData?.saturday == "" ||
                      extractedCompleteData?.sunday == "" ) ...[
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
                  if (extractedCompleteData?.answer1 == "") ...[
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
                  if (extractedCompleteData?.insurance1 == "" ) ...[
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
                  if (extractedCompleteData?.rules1 == "" ) ...[
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
                  if (extractedCompleteData?.score == "" ) ...[
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
                  if (profileData.profile!.image == 'main/avatar.png') ...[
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
                  if (extractedCompleteData?.phone == "") ...[
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
                  if ((extractedCompleteData?.euIdCardFront == "" && extractedCompleteData?.euIdDrivingFront == "" && extractedCompleteData?.euIdPassportFront == "" )&&
                      extractedCompleteData?.euIdResidencePermitFront ==
                          "" ) ...[
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
                  if (extractedCompleteData?.vitalCardNumber == ""  &&
                      extractedCompleteData?.socialSecurityNumber == "" ) ...[
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
                  if ((extractedCompleteData?.skills != "" )  ||
                      (extractedCompleteData?.monday != "" ||
                          extractedCompleteData!.tuesday != "" ||
                          extractedCompleteData.wednesday != "" ||
                          extractedCompleteData.thersday != "" ||
                          extractedCompleteData.friday != "" ||
                          extractedCompleteData.saturday != "" ||
                          extractedCompleteData.sunday != "" ) ||
                      extractedCompleteData.answer1 != "" ||
                      extractedCompleteData.insurance1 != "" ||
                      extractedCompleteData.rules1 != "" ||
                      profileData.profile!.image != 'main/avatar.png' ||
                      (extractedCompleteData.phone != "" )||
                      ((extractedCompleteData.euIdCardFront != "" && extractedCompleteData.euIdDrivingFront != "" && extractedCompleteData.euIdPassportFront != "" ) &&
                          extractedCompleteData.euIdResidencePermitFront !=
                              "" ) ||
                      (extractedCompleteData.vitalCardNumber != "" ||
                          extractedCompleteData.socialSecurityNumber !=
                              "") ||
                      extractedCompleteData.score != "") ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 20,
                    ),
                    Text(
                      "Completed Steps",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ).tr(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 20,
                    ),
                  ],
                  if (extractedCompleteData?.skills != "" ) ...[
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
                  if (extractedCompleteData?.monday != "" ||
                      extractedCompleteData?.tuesday != "" ||
                      extractedCompleteData?.wednesday != "" ||
                      extractedCompleteData?.thersday != "" ||
                      extractedCompleteData?.friday != ""  ||
                      extractedCompleteData?.saturday != "" ||
                      extractedCompleteData?.sunday != "" ) ...[
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
                  if (extractedCompleteData?.answer1 != "" ) ...[
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
                  if (extractedCompleteData?.insurance1 != "" ) ...[
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
                  if (extractedCompleteData?.score != "") ...[
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
                  if (extractedCompleteData?.rules1 != "" ) ...[
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
                  if (profileData.profile!.image != 'main/avatar.png') ...[
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
                  if (profileData.profile!.phone != '') ...[
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
                  if ((extractedCompleteData?.euIdCardFront != "" || extractedCompleteData?.euIdDrivingFront != "" || extractedCompleteData?.euIdPassportFront != "" ) ||
                      extractedCompleteData?.euIdResidencePermitFront !=
                          "" ) ...[
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
                  if (extractedCompleteData?.vitalCardNumber != "" ||
                      extractedCompleteData?.socialSecurityNumber != "" ) ...[
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
