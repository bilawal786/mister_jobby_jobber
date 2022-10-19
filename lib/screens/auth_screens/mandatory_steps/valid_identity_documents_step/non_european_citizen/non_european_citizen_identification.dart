import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/widgets/const_widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../../../helper/routes.dart';
import '../../../../../providers/mandatory_steps_provider/non_european_identification_provider/non_euro_identification_provider.dart';
import '../../../../../widgets/const_widgets/custom_list_tile.dart';

class NonEuropeanCitizen extends StatelessWidget {
  const NonEuropeanCitizen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workPermitData = Provider.of<NonEuroIdentificationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Select a type of document to send",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              if (workPermitData.workPermitPicked == false) ...[
                CustomListTile(
                  onPress: () => Navigator.of(context)
                      .pushNamed(MyRoutes.WORKPERMITSCREENROUTE),
                  leadingIcon: Icons.workspace_premium_outlined,
                  title:
                      "Work permit or residence permit with work authorization",
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                const Divider(),
              ],
              if (workPermitData.workPermitPicked == true) ...[
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                Text(
                  "Completed",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.workspace_premium_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  title: Text(
                    "Work permit or residence permit with work authorization",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    Icons.check_box,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                ),
                const Divider(),
              ],
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                dense: true,
                tileColor: Colors.amber.shade100,
                leading: const Icon(
                  Icons.circle_notifications,
                  color: Colors.black,
                ),
                subtitle: Text(
                  "These documents are necessary to validate your identity, your age, and your eligibility to work in the territory. They will never be made public.",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              if (workPermitData.workPermitPicked == true) ...[
                SizedBox(
                  height: MediaQuery.of(context).size.width / 1.2,
                ),
                CustomButton(
                  onPress: () {
                    workPermitData.postEuropeanIdentificationDocuments(
                      context,
                      workPermitData.singleSideWorkPermitPick,
                      workPermitData.backWorkPermitPick,
                    );
                  },
                  buttonName: "Confirm",
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
