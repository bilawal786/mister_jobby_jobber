import 'package:flutter/material.dart';

class AvailabilitiesScreen extends StatelessWidget {
  const AvailabilitiesScreen({Key? key}) : super(key: key);

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
                  Text("Fill your availabilities", style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(height: MediaQuery.of(context).size.width / 30,),
                  Text("Mandatory Steps", style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: MediaQuery.of(context).size.width / 30,),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Mondays", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Tuesdays", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Wednesdays", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Thursdays", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Fridays", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Saturdays", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: (){},
                    dense: true,
                    leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                    title: Text("Sundays", style: Theme.of(context).textTheme.bodySmall,),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                  ),
                  const Divider(),
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
                    title: Text(
                      "Incomplete profile",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      "These are your basic schedules, you can modify them later.",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
