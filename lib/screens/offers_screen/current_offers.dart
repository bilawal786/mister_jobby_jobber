import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/commented_jobs_provider/current_jobs_offers_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/commented_jobs_widgets/commented_jobs_widget.dart';
import '../../widgets/commented_jobs_widgets/current_jobs_widget.dart';
import '../../widgets/const_widgets/custom_button.dart';
import '../search_screen/jobs_detail_screen.dart';
import 'current_offer_jobs_details_screen.dart';

class CurrentOffers extends StatelessWidget {
  const CurrentOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
