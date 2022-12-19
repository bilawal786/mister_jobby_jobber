import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';
import '../../../../providers/mandatory_steps_provider/rules_provider/rules_provider.dart';

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
        ).tr(),
        SizedBox(
          height: MediaQuery.of(context).size.width / 20,
        ),
        Consumer<RulesProvider>(
          builder:(_,summarySecure, child) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            value: summarySecure.reservedJobsMisterJobby,
            onChanged: summarySecure.checkStatusReserved,
            title: Text(
              "I apply only to jobs for which I am available and competent.",
              style: Theme.of(context).textTheme.bodySmall,
            ).tr(),
          ),
        ),
        Consumer<RulesProvider>(
          builder:(_,summarySecure, child) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: false,
            value: summarySecure.mustPerformServices,
            onChanged: summarySecure.checkMustPerformServices,
            title: Text(
              "I do my best to get good reviews.",
              style: Theme.of(context).textTheme.bodySmall,
            ).tr(),
          ),
        ),
        Consumer<RulesProvider>(
          builder:(_,summarySecure, child) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: false,
            value: summarySecure.cashNotRequired,
            onChanged: summarySecure.checkCashRequiredStatus,
            title: Text(
              "I do not cancel a service on which I have been reserved.",
              style: Theme.of(context).textTheme.bodySmall,
            ).tr(),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
