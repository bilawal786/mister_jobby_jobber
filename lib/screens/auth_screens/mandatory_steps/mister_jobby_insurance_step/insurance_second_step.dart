import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';
import '../../../../providers/mandatory_steps_provider/insurance_provider/insurance_provider.dart';

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
        Consumer<InsuranceProvider>(
          builder:(_,summarySecure, child) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            value: summarySecure.reservedJobsMisterJobby,
            onChanged: summarySecure.checkStatusReserved,
            title: Text(
              "I only work on reserved jobs on Mister Jobby.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        Consumer<InsuranceProvider>(
          builder:(_,summarySecure, child) => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: false,
            value: summarySecure.mustPerformServices,
            onChanged: summarySecure.checkMustPerformServices,
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
