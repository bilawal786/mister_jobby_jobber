import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';

class RulesSecondStep extends StatelessWidget {
  const RulesSecondStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "In summary to be a good service provider",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 20,
        ),
        Consumer<ConstProvider>(
          builder:(_,summarySecure, child) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            value: summarySecure.trustMisterJobby,
            onChanged: summarySecure.checkStatusTrust,
            title: Text(
              "I apply only to jobs for which I am available and competent.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        Consumer<ConstProvider>(
          builder:(_,summarySecure, child) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: false,
            value: summarySecure.cashNotRequired,
            onChanged: summarySecure.checkCashRequiredStatus,
            title: Text(
              "I do my best to get good reviews.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        Consumer<ConstProvider>(
          builder:(_,summarySecure, child) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: false,
            value: summarySecure.cashNotRequired,
            onChanged: summarySecure.checkCashRequiredStatus,
            title: Text(
              "I do not cancel a service on which I have been reserved.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
