import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:mister_jobby_jobber/providers/commented_jobs_provider/commented_jobs_provider.dart';
import 'package:provider/provider.dart';

import '../../screens/home_screens/job_info_screen.dart';

class CommentedJobsWidget extends StatelessWidget {
  const CommentedJobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentedJobsData = Provider.of<CommentedJobsProvider>(context);
    final extractData = commentedJobsData.commentedJobsModel;
    return RefreshIndicator(
      onRefresh: ()async{
        await Provider.of<CommentedJobsProvider>(context, listen: false).getCommentedJobs();
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        controller: ScrollController(),
        primary: false,
        itemCount: extractData!.length,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              title: Text(extractData[index].message,
                style: Theme.of(context).textTheme.bodySmall,),
              subtitle: Text(extractData[index].date,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => JobInfoScreen(
                        id: extractData[index].jobId.toString())));
              },
            ),
            const Divider(),
          ],
        ),),
    );
  }
}
