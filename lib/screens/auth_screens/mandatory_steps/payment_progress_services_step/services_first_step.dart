import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';
import '../../../../widgets/const_widgets/group_radio_tile.dart';

class ServicesFirstStep extends StatelessWidget {
  const ServicesFirstStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Questions",
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(),
        SizedBox(
          height: MediaQuery.of(context).size.width / 40,
        ),
        Text(
          "How do we ensure the seriousness of the client who reserves you?",
          style: Theme.of(context).textTheme.bodyMedium,
        ).tr(),
        SizedBox(
          height: MediaQuery.of(context).size.width / 20,
        ),
        Consumer<ConstProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                    "He pays the entire mission in advance and online on mister jobby.",
                value: 1,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
              GroupRadioTile(
                title:
                "We don't know, we'll see.",
                value: 2,
                groupValue: questions.questionOneValue,
                onClick: questions.checkQuestionOneGroupValue,
              ),
            ],
          ),
        ),
        const Divider(),
        SizedBox(
          height: MediaQuery.of(context).size.width / 40,
        ),
        Text(
          "What happens if the mission lasts longer than expected?",
          style: Theme.of(context).textTheme.bodyMedium,
        ).tr(),
        SizedBox(
          height: MediaQuery.of(context).size.width / 20,
        ),
        Consumer<ConstProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                "Too bad for you",
                value: 1,
                groupValue: questions.questionTwoValue,
                onClick: questions.checkQuestionTwoGroupValue,
              ),
              GroupRadioTile(
                title:
                "The customer can add overtime on mister jobby.",
                value: 2,
                groupValue: questions.questionTwoValue,
                onClick: questions.checkQuestionTwoGroupValue,
              ),
            ],
          ),
        ),
        const Divider(),
        SizedBox(
          height: MediaQuery.of(context).size.width / 40,
        ),
        Text(
          "What happens if you request cash payment from your customer?",
          style: Theme.of(context).textTheme.bodyMedium,
        ).tr(),
        SizedBox(
          height: MediaQuery.of(context).size.width / 20,
        ),
        Consumer<ConstProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                "There is no consequence.",
                value: 1,
                groupValue: questions.questionThreeValue,
                onClick: questions.checkQuestionThreeGroupValue,
              ),
              GroupRadioTile(
                title:
                "You risk not being paid and being suspended.",
                value: 2,
                groupValue: questions.questionThreeValue,
                onClick: questions.checkQuestionThreeGroupValue,
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
