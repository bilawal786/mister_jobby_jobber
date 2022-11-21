import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/commented_jobs_provider/commented_jobs_provider.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../screens/home_screens/job_info_screen.dart';

class CommentedJobsWidget extends StatelessWidget {
  const CommentedJobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentedJobsData = Provider.of<CommentedJobsProvider>(context);
    final extractData = commentedJobsData.commentedJobsModel;
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<CommentedJobsProvider>(context, listen: false)
            .getCommentedJobs();
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: ScrollController(),
        primary: false,
        itemCount: extractData!.length,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              leading: Container(
                width: MediaQuery.of(context).size.width / 7,
                height: MediaQuery.of(context).size.width / 7,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "${MyRoutes.IMAGEURL}${extractData[index].image}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      extractData[index].name,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    extractData[index].date,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              subtitle: Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Text(
                      extractData[index].message,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Text(
                    "See job...",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cerebri Sans Regular',
                    ),
                  ).tr(),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => JobInfoScreen(
                        id: extractData[index].jobId.toString())));
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
