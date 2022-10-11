import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';

class ServicesSecondStep extends StatelessWidget {
  const ServicesSecondStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "In summary to secure your payments:",
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
              "I always go through Mister Jobby for the payment of the job.",
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
              "I do not require cash payment",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
