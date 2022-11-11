import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/commented_jobs_provider/current_jobs_offers_provider.dart';
import '../../screens/offers_screen/current_offer_jobs_details_screen.dart';

class CurrentJobsWidget extends StatelessWidget {
  const CurrentJobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CurrentJobsOffersProvider>(context, listen: false).getCommentedJobs();
    final commentedJobsData = Provider.of<CurrentJobsOffersProvider>(context);
    final extractCommentedJobsData = commentedJobsData.commentedJobsModel;
    return ListView.builder(
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
    );
  }
}
