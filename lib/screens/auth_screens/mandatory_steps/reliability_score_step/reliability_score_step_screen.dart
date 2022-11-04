import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/const_widgets/custom_button.dart';
import '../../../../widgets/const_widgets/custom_list_tile.dart';

import '../../../../providers/reliability_score_provider/reliability_score_provider.dart';

class ReliabilityScoreScreen extends StatelessWidget {
  const ReliabilityScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reliabilityScoreData = Provider.of<ReliabilityScoreProvider>(context);
    var score = 1;
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
                    "Reliability score.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    "What is that ?",
                    style: Theme.of(context).textTheme.titleSmall,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Text(
                    "The reliability score is an indicator that increases or decreases the level of visibility of your profile with customers.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    "How it works ?",
                    style: Theme.of(context).textTheme.titleSmall,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.arrow_drop_up,
                              size: 25,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                            Text(
                              "You do a job",
                              style: Theme.of(context).textTheme.bodySmall,
                            ).tr(),
                            const Spacer(),
                            const Text(
                              "+10",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 25,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                            Text(
                              "You cancel a job",
                              style: Theme.of(context).textTheme.bodySmall,
                            ).tr(),
                            const Spacer(),
                            const Text(
                              "-100",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  Text(
                    "Your score is calculated over the last 60 days.",
                    style: Theme.of(context).textTheme.labelMedium,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    "The Steps",
                    style: Theme.of(context).textTheme.titleSmall,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Excellent",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ).tr(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 40,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  height:
                                      MediaQuery.of(context).size.width / 8.2,
                                  child: Text(
                                    "You are one of the best jobbers, your profile is strongly highlighted and you will win more jobs.",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 80,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    "100 or more",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 20,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Neutral",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ).tr(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 40,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  height:
                                      MediaQuery.of(context).size.width / 8.2,
                                  child: Text(
                                    "Your profile is placed just behind that of jobbers with a reliability score higher than yours.",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 80,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    "from 0 to 99",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 20,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Weak",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ).tr(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 40,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  height:
                                      MediaQuery.of(context).size.width / 8.2,
                                  child: Text(
                                    "Your profile is not highlighted and you will be suspended for 7 days for each cancellation.",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 80,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    "less than 0",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    "How do I increase my reliability score?",
                    style: Theme.of(context).textTheme.titleSmall,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const CustomListTile(
                      leadingIcon: Icons.date_range,
                      title: "Check that you are available",
                      subTitle:
                          "You apply for dates and times that must be respected. Update your Mister Jobby agenda regularly to make sure you never have to cancel."),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const CustomListTile(
                      leadingIcon: Icons.scatter_plot_outlined,
                      title: "Make sure you have the skills and materials",
                      subTitle:
                          "Before offering your services, read the content of each request carefully to verify that you can perform the mission well."),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const CustomListTile(
                      leadingIcon: Icons.watch_later_outlined,
                      title: "Respect your hourly rate",
                      subTitle:
                          "You choose your hourly pay and validate it online. No packages, no cash, no surprises for you or your client."),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const CustomListTile(
                      leadingIcon: Icons.gps_fixed,
                      title: "Adjust your intervention area",
                      subTitle:
                          "Adjust your area of intervention to find jobs near you."),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const CustomListTile(
                      leadingIcon: Icons.message_rounded,
                      title: "Communicate with your customer",
                      subTitle:
                          "Relationships are essential! Have exemplary behavior, be polite, available and attentive. If you have an unforeseen event, call your client to arrange it with him."),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  CustomButton(onPress: () {
                    reliabilityScoreData.reliabilityScore(context, "1");
                  }, buttonName: "Confirm"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
