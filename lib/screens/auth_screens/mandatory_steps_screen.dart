import 'package:flutter/material.dart';

import '../../helper/routes.dart';

class MandatoryStepsScreen extends StatelessWidget {
  const MandatoryStepsScreen({Key? key}) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Welcome,", style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(height: MediaQuery.of(context).size.width / 40,),
                  Text("Here is the list of things you need to do before you can apply for the jobs.",
                  style: Theme.of(context).textTheme.labelMedium,),
                  SizedBox(height: MediaQuery.of(context).size.width / 30,),
                  Text("Mandatory Steps", style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: MediaQuery.of(context).size.width / 30,),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Indicate your skills", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: ()=> Navigator.of(context).pushNamed(MyRoutes.AVAILABILITIESSCREENROUTE),
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Complete your availabilities", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Discover secure payment", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Indicate your skills", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Discover the insurance", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Learn the rules", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Discover the reliability score", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Add your profile picture", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Complete your personal information", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Valid identity documents", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Social security certificate", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
