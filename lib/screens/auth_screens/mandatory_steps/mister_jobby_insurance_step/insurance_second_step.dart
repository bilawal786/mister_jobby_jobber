import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';

class InsuranceSecondStep extends StatelessWidget {
  const InsuranceSecondStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "In summary, to benefit from Mister Jobby insurance",
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
              "I only work on reserved jobs on Mister Jobby.",
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
              "It is I who must perform the service.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
