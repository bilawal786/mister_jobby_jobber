import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/const_provider/const_provider.dart';

class EngagementSelectionStep extends StatelessWidget {
  const EngagementSelectionStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engagementData = Provider.of<ConstProvider>(context, listen: false);
    final extractEngagement = engagementData.engagementList;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "What are your customer commitments?",
            style: Theme.of(context).textTheme.titleMedium,
          ).tr(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 40,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: extractEngagement.length,
            itemBuilder: (ctx, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {
                    engagementData.isAddedEngagements(extractEngagement[index]);
                  },
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    extractEngagement[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ).tr(),
                  trailing: Consumer<ConstProvider>(
                    builder: (_, engagementData, child) => Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.all(0.2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: engagementData.tempEngagement
                                  .contains(extractEngagement[index])
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ),
                        color: engagementData.tempEngagement
                                .contains(extractEngagement[index])
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
