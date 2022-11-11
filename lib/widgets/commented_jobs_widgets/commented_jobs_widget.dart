import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CommentedJobsWidget extends StatelessWidget {
  const CommentedJobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: ListView.builder(
      shrinkWrap: true,
      controller: ScrollController(),
      primary: false,
      itemCount: 7,
      itemBuilder: (context, index) => ListTile(
        title: Text('IBFT BNP',
          style: Theme.of(context).textTheme.titleSmall,),
        subtitle: Text('25-10-2022',
          style: Theme.of(context).textTheme.bodySmall,),
        trailing: Text('€ 300',
          style: Theme.of(context).textTheme.titleSmall,),
      ),),);
  }
}
