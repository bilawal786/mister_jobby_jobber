import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../helper/routes.dart';
import '../../../../widgets/const_widgets/custom_button.dart';

class ProgressServices extends StatelessWidget {
  const ProgressServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 25),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Progress of a service",
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      "The customer prepaid the amount of the service on a secure Mister Jobby account when booking.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "2",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      "Once the job is done, the client confirms the payment.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "3",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      "The amount of the benefit arrives on your wallet in 72 hours.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
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
                      Icons.watch_later_outlined,
                      color: Colors.black,
                    ),
                    subtitle: Text(
                      "If you worked overtime, your client could pay for it directly online.",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        child: Padding(padding: const EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
        child:CustomButton(onPress: () => Navigator.of(context).pushNamed(MyRoutes.SERVICESSTEPSCREENROUTE,), buttonName: "Skip to quiz"),
          ),),
    );
  }
}
