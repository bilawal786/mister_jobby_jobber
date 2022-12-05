import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../helper/routes.dart';
import '../../../../../widgets/const_widgets/custom_list_tile.dart';
import '../../../../../widgets/const_widgets/custom_button.dart';
import '../../../../../providers/mandatory_steps_provider/european_identity_verification/european_identification.dart';

class EuropeanCitizenIdentificationScreen extends StatelessWidget {
  const EuropeanCitizenIdentificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final euoIdCardData = Provider.of<EuropeanIdentificationProvider>(context);
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
              if (euoIdCardData.idCardPicked == false) ...[
                CustomListTile(
                  onPress: () => Navigator.of(context)
                      .pushNamed(MyRoutes.EUROPEANIDCARDUPLOADROUTE),
                  leadingIcon: Icons.account_box,
                  title: "European identity card",
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                const Divider(),
              ],
              if (euoIdCardData.licensePicked == false) ...[
                CustomListTile(
                  onPress: () => Navigator.of(context)
                      .pushNamed(MyRoutes.FRENCHDRIVINGLICENSEROUTE),
                  leadingIcon: Icons.contact_page,
                  title: "French driving license",
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                const Divider(),
              ],
              if (euoIdCardData.passportPicked == false) ...[
                CustomListTile(
                  onPress: () => Navigator.of(context)
                      .pushNamed(MyRoutes.EUROPEANPASSPORTUPLOADROUTE),
                  leadingIcon: Icons.contact_mail_rounded,
                  title: "European passport",
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                const Divider(),
              ],
              if (euoIdCardData.idCardPicked == true ||
                  euoIdCardData.passportPicked == true) ...[
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
              ],
              if (euoIdCardData.idCardPicked == true) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.account_box,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  title: Text(
                    "European identity card",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: Icon(
                    Icons.check_box,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                ),
                const Divider(),
              ],
              if (euoIdCardData.licensePicked == true) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.contact_page,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  title: Text(
                    "French driving license",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: Icon(
                    Icons.check_box,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                ),
                const Divider(),
              ],
              if (euoIdCardData.passportPicked == true) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.contact_mail_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  title: Text(
                    "European passport",
                    style: Theme.of(context).textTheme.bodyLarge,
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
              SizedBox(
                height: MediaQuery.of(context).size.width / 2.2,
              ),
              if (euoIdCardData.licensePicked == true ||
                  euoIdCardData.passportPicked == true ||
                  euoIdCardData.idCardPicked == true)
                CustomButton(
                  onPress: () {
                    euoIdCardData.postEuropeanIdentificationDocuments(
                      context,
                      euoIdCardData.singleSideIdCardPick,
                      euoIdCardData.backIdCardPick,
                      euoIdCardData.singleSideLicensePick,
                      euoIdCardData.backLicensePick,
                      euoIdCardData.singleSidePassportPick,
                    );
                  },
                  buttonName: "Confirm",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
