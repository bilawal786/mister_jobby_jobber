import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/commented_jobs_provider/current_jobs_offers_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/commented_jobs_provider/commented_jobs_provider.dart';
import '../../widgets/commented_jobs_widgets/commented_jobs_widget.dart';
import '../../widgets/commented_jobs_widgets/current_jobs_widget.dart';

class CurrentOffers extends StatelessWidget {
  const CurrentOffers({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentOffer = Provider.of<CurrentJobsOffersProvider>(context).commentedJobsModel!.length;
    int commentedJobs = Provider.of<CommentedJobsProvider>(context).commentedJobsModel!.length;

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
                    textAlign: TextAlign.left,
                  ).tr()),
              foregroundColor: Colors.black,
              leading: GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: const Icon(Icons.arrow_back, color: Colors.black,)),
              backgroundColor: Colors.white,
              bottom: TabBar(
                padding: const EdgeInsets.only(left: 10, right: 10),
                indicator: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 0.8),
                  borderRadius: BorderRadius.circular(5), // Creates border
                  color: Colors.blue.shade50,
                ),
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                labelStyle: Theme.of(context).textTheme.bodySmall,
                tabs: [
                  Tab(
                    child: Center(
                      child: Text(
                        "Offers ($currentOffer)",
                      ).tr(),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Text(
                        "Commented jobs ($commentedJobs)",
                      ).tr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
          body: const TabBarView(
            children:  <Widget>[
               CurrentJobsWidget(),
               CommentedJobsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
