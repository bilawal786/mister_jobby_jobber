import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';
import '../../../../providers/mandatory_steps_provider/insurance_provider/insurance_provider.dart';
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
        Consumer<InsuranceProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                "You must reimburse what you have broken.",
                value: 1,
                groupValue: questions.insuranceQuestion1,
                onClick: questions.checkInsurance1Answer,
              ),
              GroupRadioTile(
                title:
                "MisterJobby reimburses for you what you have broken.",
                value: 2,
                groupValue: questions.insuranceQuestion1,
                onClick: questions.checkInsurance1Answer,
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
        Consumer<InsuranceProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                "Yes, I am still insured.",
                value: 1,
                groupValue: questions.insuranceQuestion2,
                onClick: questions.checkInsurance2Answer,
              ),
              GroupRadioTile(
                title:
                "No, I can no longer benefit from the insurance",
                value: 2,
                groupValue: questions.insuranceQuestion2,
                onClick: questions.checkInsurance2Answer,
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
        Consumer<InsuranceProvider>(
          builder: (_, questions, child) => Column(
            children: [
              GroupRadioTile(
                title:
                "No, since it has not been officially booked on Mister Jobby.",
                value: 1,
                groupValue: questions.insuranceQuestion3,
                onClick: questions.checkInsurance3Answer,
              ),
              GroupRadioTile(
                title:
                "Yes, the insurance covers everything, all the time.",
                value: 2,
                groupValue: questions.insuranceQuestion3,
                onClick: questions.checkInsurance3Answer,
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
