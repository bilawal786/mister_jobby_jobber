import 'package:flutter/material.dart';

import '../../../../../helper/routes.dart';
import '../../../../../widgets/const_widgets/custom_list_tile.dart';

class EuropeanCitizenIdentificationScreen extends StatelessWidget {
  const EuropeanCitizenIdentificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              CustomListTile(
                onPress: () => Navigator.of(context)
                    .pushNamed(MyRoutes.EUROPEANIDCARDUPLOADROUTE),
                leadingIcon: Icons.account_box,
                title: "European identity card",
                trailingIcon: Icons.arrow_forward_ios,
              ),
              const Divider(),
              CustomListTile(
                onPress: ()=> Navigator.of(context).pushNamed(MyRoutes.FRENCHDRIVINGLICENSEROUTE),
                leadingIcon: Icons.contact_page,
                title: "French driving license",
                trailingIcon: Icons.arrow_forward_ios,
              ),
              const Divider(),
              CustomListTile(
                onPress: ()=> Navigator.of(context).pushNamed(MyRoutes.EUROPEANPASSPORTUPLOADROUTE),
                leadingIcon: Icons.contact_mail_rounded,
                title: "European passport",
                trailingIcon: Icons.arrow_forward_ios,
              ),
              const Divider(),
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
    );
  }
}
