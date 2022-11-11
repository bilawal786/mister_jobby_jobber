import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/commented_jobs_provider/commented_jobs_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/commented_jobs_widgets/commented_jobs_widget.dart';
import '../../widgets/const_widgets/custom_button.dart';
import '../search_screen/jobs_detail_screen.dart';
import 'current_offer_jobs_details_screen.dart';

class CurrentOffers extends StatelessWidget {
  const CurrentOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentedJobsData = Provider.of<CommentedJobsProvider>(context);
    final extractCommentedJobsData = commentedJobsData.commentedJobsModel;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              elevation: 0,
              expandedHeight: 110,
              pinned: true,
              floating: true,
              snap: true,
              title: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 30),
                  child: Text(
                    "jobs tracked",
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr()),
              foregroundColor: Colors.black,
              leading: GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: const Icon(Icons.arrow_back, color: Colors.black,)),
              actions: const [Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.more_vert_rounded, color: Colors.black,),
              )],
              centerTitle: true,
              backgroundColor: Colors.white,
              bottom: TabBar(
                padding: const EdgeInsets.only(left: 10, right: 10),
                indicator: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 0.8),
                  borderRadius: BorderRadius.circular(15), // Creates border
                  color: Colors.grey.shade100,
                ),
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                labelStyle: Theme.of(context).textTheme.bodySmall,
                tabs: [
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.only(top: 3),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: const Text(
                          "Current Offers (0)",
                        ).tr(),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.only(top: 3),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: const Text(
                          "Commented jobs (0)",
                        ).tr(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: extractCommentedJobsData!.length,
                itemBuilder: (context, index) =>
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => SingleJobDetailScreen(
                                    jobsDetail:
                                    extractCommentedJobsData[index].job)));
                          },
                          child: Container(
                            color: const Color(0xFFebf9fe),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.brown.shade300,
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      child: Icon(
                                        Icons.handyman_rounded,
                                        color: Colors.brown.shade700,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          40,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: Text(
                                        extractCommentedJobsData[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${extractCommentedJobsData[index].job.estimateBudget} €",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width /
                                      80,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "${extractCommentedJobsData[index].job.startTime} - ${extractCommentedJobsData[index].job.endTime} (${extractCommentedJobsData[index].job.duration} h)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                    const Spacer(),
                                    if(extractCommentedJobsData[index].status == 2) ...[
                                      Container(
                                      padding:
                                      const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade500,
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                      ),
                                      child: const FittedBox(
                                        child: Text(
                                          "Close",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            'Cerebri Sans Bold',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ) ] else ... [

                                    if (extractCommentedJobsData[index]
                                        .job.urgent ==
                                        1)
                                      Container(
                                        padding:
                                        const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade900,
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                        ),
                                        child: const FittedBox(
                                          child: Text(
                                            "Urgent",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                              'Cerebri Sans Bold',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),],
                                  ],
                                ),
                                Text(
                                  extractCommentedJobsData[index].job.serviceDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium,
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
              SingleChildScrollView(

                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Icon(
                        Icons.content_paste_search,
                        size: 150,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "No current offer",
                        style: Theme.of(context).textTheme.titleSmall,
                      ).tr(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Text(
                        "Here you will find all your current offers",
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ).tr(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
