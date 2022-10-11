import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';
import '../../../../widgets/const_widgets/group_radio_tile.dart';

class RulesFirstStep extends StatelessWidget {
  const RulesFirstStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Questions", style: Theme.of(context).textTheme.titleMedium,),
        SizedBox(height: MediaQuery.of(context).size.width / 20,),
        Text(
          "When I apply for an offer:",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 20,
        ),
        Consumer<ConstProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                "I check that I am available on the date and at the time requested by the client.",
                value: 1,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
              GroupRadioTile(
                title:
                "I apply regardless of my schedule. At worst I will be late or I will postpone the job",
                value: 2,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
            ],
          ),
        ),
        const Divider(),
        Text(
          "When I offer my services for a job:",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 20,
        ),
        Consumer<ConstProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                "I apply for the lowest hourly rate but I will ask for a supplement on the spot.",
                value: 1,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
              GroupRadioTile(
                title:
                "I apply an hourly rate that corresponds to my skills and my equipment",
                value: 2,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
            ],
          ),
        ),
        const Divider(),
        Text(
          "To avoid cancellations:",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 20,
        ),
        Consumer<ConstProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                "I ask my client to shift the job according to my schedule.",
                value: 1,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
              GroupRadioTile(
                title:
                "I apply only to jobs for which I am available and competent",
                value: 2,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
