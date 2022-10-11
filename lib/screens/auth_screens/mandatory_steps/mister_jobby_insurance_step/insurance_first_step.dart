import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';
import '../../../../widgets/const_widgets/group_radio_tile.dart';

class InsuranceFirstStep extends StatelessWidget {
  const InsuranceFirstStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Questions", style: Theme.of(context).textTheme.titleMedium,),
        SizedBox(height: MediaQuery.of(context).size.width / 20,),
        Text(
          "You break an object at your customer. What's going on?",
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
                "You must reimburse what you have broken.",
                value: 1,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
              GroupRadioTile(
                title:
                "MisterJobby reimburses for you what you have broken.",
                value: 2,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
            ],
          ),
        ),
        const Divider(),
        Text(
          "You come to a client without going through Mister Jobby, are you insured?",
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
                "Yes, I am still insured.",
                value: 1,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
              GroupRadioTile(
                title:
                "No, I can no longer benefit from the insurance",
                value: 2,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
            ],
          ),
        ),
        const Divider(),
        Text(
          "You come with a colleague and he breaks something. Are you covered?",
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
                "No, since it has not been officially booked on Mister Jobby.",
                value: 1,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
              GroupRadioTile(
                title:
                "Yes, the insurance covers everything, all the time.",
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
