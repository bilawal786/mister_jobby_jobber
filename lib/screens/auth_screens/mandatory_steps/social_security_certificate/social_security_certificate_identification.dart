import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/routes.dart';
import '../../../../widgets/const_widgets/custom_list_tile.dart';
import '../../../../widgets/const_widgets/custom_button.dart';

import '../../../../../providers/mandatory_steps_provider/social_security/social_security_provider.dart';

class SocialSecurityCertificate extends StatelessWidget {
  const SocialSecurityCertificate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final securityData = Provider.of<SocialSecurityProvider>(context);
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
              if (securityData.vitalCardPicked == false) ...[
                CustomListTile(
                  onPress: () => Navigator.of(context)
                      .pushNamed(MyRoutes.VITALCARDUPLOADEROUTE),
                  leadingIcon: Icons.account_box,
                  title: "Vital card",
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                const Divider(),
              ],
              if (securityData.securityCardPicked == false) ...[
                CustomListTile(
                  onPress: () => Navigator.of(context)
                      .pushNamed(MyRoutes.SECURITYCARDUPLOADEROUTE),
                  leadingIcon: Icons.contact_page,
                  title: "Social security certificate",
                  trailingIcon: Icons.arrow_forward_ios,
                ),
                const Divider(),
              ],
              if (securityData.vitalCardPicked == true ||
                  securityData.securityCardPicked == true) ...[
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                Text(
                  "Completed",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
              ],
              if (securityData.vitalCardPicked == true) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.account_box,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  title: Text(
                    "Vital card",
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
              if (securityData.securityCardPicked == true) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.contact_page,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  title: Text(
                    "Social security certificate",
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: (securityData.vitalCardPicked == true &&
    securityData.securityCardPicked == true) ? BottomAppBar(elevation: 20, child: Padding(padding: const EdgeInsets.all(5),
          child: CustomButton(
            onPress: () {
              securityData.postSecurityCertificates(
                context,
                securityData.vitalCardPick,
                securityData.vitalCardNumber,
                securityData.socialSecurityCardPick,
                securityData.securityCardNumber,
              );
            },
            buttonName: "Confirm",
          ),),): const SizedBox(),
    );
  }
}
