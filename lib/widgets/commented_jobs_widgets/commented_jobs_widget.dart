import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CommentedJobsWidget extends StatelessWidget {
  const CommentedJobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => Column(children: <Widget>[
      Text(''),
      Text(''),
      Text(''),
    ],),);
  }
}
