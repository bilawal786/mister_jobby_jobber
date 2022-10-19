import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/routes.dart';
import '../../../../providers/mandatory_steps_provider/time_availability_provider/availability_provider.dart';
import '../../../../widgets/const_widgets/custom_button.dart';
import '../../../../providers/const_provider/const_provider.dart';

class AvailabilitiesScreen extends StatelessWidget {
  const AvailabilitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availabilityData = Provider.of<ConstProvider>(context);
    final timeApi = Provider.of<AvailabilityProvider>(context, listen: false);
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
                  Text(
                    "Fill your availabilities",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  Text(
                    "Mandatory Steps",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  if (availabilityData.mondayValue == 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.MONDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        size: 25,
                        color: Colors.black45,
                      ),
                      title: Text(
                        "Mondays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.tuesdayValue == 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.TUESDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        size: 25,
                        color: Colors.black45,
                      ),
                      title: Text(
                        "Tuesdays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.wednesdayValue == 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.WEDNESDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        size: 25,
                        color: Colors.black45,
                      ),
                      title: Text(
                        "Wednesdays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.thursdayValue == 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.THURSDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        size: 25,
                        color: Colors.black45,
                      ),
                      title: Text(
                        "Thursdays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.fridayValue == 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.FRIDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        size: 25,
                        color: Colors.black45,
                      ),
                      title: Text(
                        "Fridays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.saturdayValue == 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.SATURDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        size: 25,
                        color: Colors.black45,
                      ),
                      title: Text(
                        "Saturdays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.sundayValue == 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.SUNDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        size: 25,
                        color: Colors.black45,
                      ),
                      title: Text(
                        "Sundays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  if (availabilityData.mondayValue != 0 ||
                      availabilityData.tuesdayValue != 0) ...[
                    Text(
                      "Completed Steps",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 20,
                    )
                  ],
                  if (availabilityData.mondayValue != 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.MONDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Mondays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.tuesdayValue != 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.TUESDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Tuesday",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.wednesdayValue != 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.WEDNESDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Wednesdays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.thursdayValue != 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.THURSDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Thursdays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.fridayValue != 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.FRIDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Fridays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.saturdayValue != 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.SATURDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Saturdays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  if (availabilityData.sundayValue != 0) ...[
                    ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyRoutes.SUNDAYTIMEAVAILABILITY),
                      dense: true,
                      leading: Icon(
                        Icons.check_box_outlined,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Sundays",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                    const Divider(),
                  ],
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 5,
                  ),
                  (availabilityData.mondayValue != 0 &&
                          availabilityData.thursdayValue != 0 &&
                          availabilityData.tuesdayValue != 0 &&
                          availabilityData.wednesdayValue != 0 &&
                          availabilityData.fridayValue != 0 &&
                          availabilityData.sundayValue != 0 &&
                          availabilityData.saturdayValue != 0)
                      ? CustomButton(
                          onPress: () {
                            timeApi.postAvailability(
                              context,
                              availabilityData.mondayValue.toString(),
                              availabilityData.tuesdayValue.toString(),
                              availabilityData.wednesdayValue.toString(),
                              availabilityData.thursdayValue.toString(),
                              availabilityData.fridayValue.toString(),
                              availabilityData.saturdayValue.toString(),
                              availabilityData.sundayValue.toString(),
                            );
                          },
                          buttonName: "Confirm")
                      : ListTile(
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
