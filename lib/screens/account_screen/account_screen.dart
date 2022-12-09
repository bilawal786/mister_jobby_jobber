import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../providers/accounts_providers/transaction_provider.dart';
import '../../providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import '../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import '../../providers/my_skills_provider/my_skills_provider.dart';
import '../../widgets/my_skills/my_skill_item_widget.dart';
import 'reliabiltity_score_screen.dart';
import 'wallet_screens.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<CheckProfileCompletionProvider>(context, listen: false)
          .getProfileCompletionData(context);
      Provider.of<TransactionProvider>(context).getTransaction(context);
      Provider.of<MySkillsProvider>(context).getMySkill(context);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final checkCompleteProfile =
        Provider.of<CheckProfileCompletionProvider>(context, listen: false);
    final extractedCompleteData = checkCompleteProfile.checkProfileComplete;
    final profileData = Provider.of<PersonalInformationProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final transactionData =
        Provider.of<TransactionProvider>(context).transactionModel;
    final mySkillsData = Provider.of<MySkillsProvider>(context, listen: false);
    final extractedSkills = mySkillsData.mySkills;
    return Scaffold(
      body: (profileData.profile == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: mediaQuery.size.width / 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: mediaQuery.size.width / 7,
                        ),
                        SizedBox(
                          width: mediaQuery.size.width / 1.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height:
                                        MediaQuery.of(context).size.width / 3.5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: Image.network(
                                        "${MyRoutes.IMAGEURL}${profileData.profile!.image}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (profileData.profile!.verified == 2)
                                    Positioned(
                                      right: 2,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.verified_user_sharp,
                                          color: Colors.green.shade700,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mediaQuery.size.width / 8,
                          height: mediaQuery.size.width / 3.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(MyRoutes.SETTINGSCREENROUTE),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 8.5,
                                  height:
                                      MediaQuery.of(context).size.width / 8.5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.gear_solid,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${profileData.profile!.firstName} ${profileData.profile!.lastName}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (profileData.profile!.pro == 2) ...[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            padding: const EdgeInsets.only(
                              left: 1,
                              right: 1,
                            ),
                            child: const Text(
                              'PRO',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Cerebri Sans Bold',
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(
                      height: mediaQuery.size.width / 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(MyRoutes.REVIEWSSCREENROUTE);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (profileData.profile!.rating == 0)
                              const Icon(
                                Icons.star,
                                size: 14,
                              ),
                            for (int i = 0;
                                i < profileData.profile!.rating;
                                i++)
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                            SizedBox(
                              width: mediaQuery.size.width / 40,
                            ),
                            Text(
                              "${profileData.profile!.rating}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(
                              width: mediaQuery.size.width / 80,
                            ),
                            Text(
                              "/5",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.size.width / 40,
                    ),
                    Text(
                      "${profileData.profile!.reviews.length} views",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(
                      height: mediaQuery.size.width / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const WalletScreen(),
                              ));
                            },
                            child: Container(
                              width: mediaQuery.size.width / 2.2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.shade50,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.account_balance_wallet_outlined,
                                        size: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        height: mediaQuery.size.width / 80,
                                      ),
                                      Text(
                                        (transactionData?.wallet == null ||
                                                transactionData!.wallet.isEmpty)
                                            ? "0€"
                                            : "${transactionData.wallet}€",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      SizedBox(
                                        height: mediaQuery.size.width / 80,
                                      ),
                                      Text(
                                        "Wallet",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
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
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ScoreScreen(),
                              ));
                            },
                            child: Container(
                              width: mediaQuery.size.width / 2.2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.amber.shade50,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.thumb_up_alt,
                                        size: 20,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        height: mediaQuery.size.width / 80,
                                      ),
                                      Text(
                                        "0",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      SizedBox(
                                        height: mediaQuery.size.width / 80,
                                      ),
                                      Text(
                                        "Reliability score",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.size.width / 20,
                    ),
                    if ((extractedCompleteData?.skills == "") ||
                        (extractedCompleteData?.monday == "" ||
                            extractedCompleteData?.tuesday == "" ||
                            extractedCompleteData?.wednesday == "" ||
                            extractedCompleteData?.thersday == "" ||
                            extractedCompleteData?.friday == "" ||
                            extractedCompleteData?.saturday == "" ||
                            extractedCompleteData?.sunday == "") ||
                        extractedCompleteData?.answer1 == "" ||
                        extractedCompleteData?.insurance1 == "" ||
                        extractedCompleteData?.rules1 == "" ||
                        profileData.profile?.image == 'main/avatar.png' ||
                        (profileData.profile?.phone == '') ||
                        (extractedCompleteData?.score == "") ||
                        ((extractedCompleteData?.euIdCardFront == "" &&
                                extractedCompleteData?.euIdDrivingFront == "" &&
                                extractedCompleteData?.euIdPassportFront ==
                                    "") &&
                            extractedCompleteData?.euIdResidencePermitFront ==
                                "") ||
                        (extractedCompleteData?.vitalCardNumber == "" &&
                            extractedCompleteData?.socialSecurityNumber ==
                                "")) ...[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Action Required (1)",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber.shade100,
                                  ),
                                  child: const Icon(
                                    Icons.circle_notifications,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: mediaQuery.size.width / 40,
                            ),
                            if ((extractedCompleteData?.skills == "") &&
                                    (extractedCompleteData?.monday == "" ||
                                        extractedCompleteData!.tuesday == "" ||
                                        extractedCompleteData.wednesday == "" ||
                                        extractedCompleteData.thersday == "" ||
                                        extractedCompleteData.friday == "" ||
                                        extractedCompleteData.saturday == "" ||
                                        extractedCompleteData.sunday == "") ||
                                extractedCompleteData?.answer1 == "" ||
                                extractedCompleteData?.insurance1 == "" ||
                                extractedCompleteData?.rules1 == "" ||
                                profileData.profile?.image ==
                                    'main/avatar.png' ||
                                (extractedCompleteData?.phone == "") ||
                                (extractedCompleteData?.score == "") ||
                                ((extractedCompleteData?.euIdPassportFront ==
                                            "" &&
                                        extractedCompleteData
                                                ?.euIdDrivingFront ==
                                            "" &&
                                        extractedCompleteData
                                                ?.euIdPassportFront ==
                                            "") &&
                                    extractedCompleteData
                                            ?.euIdResidencePermitFront ==
                                        "") ||
                                (extractedCompleteData?.vitalCardNumber == "" &&
                                    extractedCompleteData
                                            ?.socialSecurityNumber ==
                                        "")) ...[
                              ListTile(
                                onTap: () => Navigator.of(context).pushNamed(
                                    MyRoutes.MANDATORYSTEPSSCREENROUTE),
                                contentPadding: const EdgeInsets.all(10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                dense: true,
                                tileColor: Colors.amber.shade100,
                                leading: const Icon(
                                  Icons.circle_notifications,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  "Incomplete profile",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ).tr(),
                                subtitle: Text(
                                  "Please complete your profile to start offering your services.",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                    if (profileData.profile!.verified == 1) ...[
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.amber.shade200,
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
                              "Your profile is under review",
                              style: Theme.of(context).textTheme.bodySmall,
                            ).tr(),
                          ],
                        ),
                      ),
                    ] else if (profileData.profile!.verified == 2) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                              vertical:
                                  MediaQuery.of(context).size.width * 0.01,
                            ),
                            child: Text(
                              "My Skills",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          extractedSkills == null
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: extractedSkills.length,
                                  itemBuilder: (ctx, index) =>
                                      MySkillsItemWidget(
                                    mySkillsModel: extractedSkills[index],
                                    index: index,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
