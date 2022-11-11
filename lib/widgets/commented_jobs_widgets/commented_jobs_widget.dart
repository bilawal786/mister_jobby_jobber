import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/commented_jobs_provider/commented_jobs_provider.dart';
import 'package:provider/provider.dart';

class CommentedJobsWidget extends StatelessWidget {
  const CommentedJobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentedJobsData = Provider.of<CommentedJobsProvider>(context);
    final extractData = commentedJobsData.commentedJobsModel;
    return RefreshIndicator(
      onRefresh: ()async{
        await Provider.of<CommentedJobsProvider>(context).getCommentedJobs();
      },
      child: ListView.builder(
        shrinkWrap: true,
        controller: ScrollController(),
        primary: false,
        itemCount: 1,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.person),
          title: Text('IBFT BNP',
            style: Theme.of(context).textTheme.titleSmall,),
          subtitle: Text('25-10-2022',
            style: Theme.of(context).textTheme.bodySmall,),
          trailing: Text('',
            style: Theme.of(context).textTheme.titleSmall,),
        ),),
    );
  }
}
