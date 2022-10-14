import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mister_jobby_jobber/providers/jobs_providers/job_details_provider.dart';
import 'package:mister_jobby_jobber/screens/search_screen/comment_screen.dart';
import 'package:mister_jobby_jobber/widgets/const_widgets/custom_button.dart';
import 'package:provider/provider.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

const LatLng currentLocation = LatLng(31.561920, 74.348080);

class _JobDetailScreenState extends State<JobDetailScreen> {
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.width / 2.5,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_alert,
                  size: 30,
                  color: Colors.grey.shade500,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 40,
                ),
                Text(
                  "Already 1 jobber has applied",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const Divider(),
            Text(
              "Client proposal",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Row(
              children: <Widget>[
                Text(
                  "36 €",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Expanded(
                    child: Consumer<JobsDetailProvider>(
                        builder: (_, bottomSheet, child) => CustomButton(
                            onPress: () {
                              bottomSheet.showBottomSheet(context);
                            },
                            buttonName: "To apply"),),),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black38),
                    ),
                  ),
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: currentLocation,
                      zoom: 15,
                    ),
                    onMapCreated: (controller) {
                      mapController = controller;
                      addMarker("test", currentLocation);
                    },
                    markers: _markers.values.toSet(),
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "TV dressing with lights",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        "36 €",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 12,
                        foregroundImage: NetworkImage(
                          "https://img.freepik.com/premium-vector/person-avatar-design_24877-38137.jpg?w=2000",
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "Posted by Guillaume,",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "- Today",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "Saturday October 22",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.watch_later,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "3:00 p.m. to 4:00 p.m. (1h30)",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.wallet,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "18€ / hours",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "90000 Belfort",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "1 Jobber ask",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctxt) => CommentScreen())),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.chat_outlined,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          Text(
                            "See Comments",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontFamily: "Cerebri Sans Bold",
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          Text(
                            "(0)",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontFamily: "Cerebri Sans Bold",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Information",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Need to dispose of waste.",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Spacer(),
                      Text(
                        "Non",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 40,
            ),
            const Divider(
              height: 2,
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          "Need to dispose of waste. Description"
                          "Description"
                          "Description"
                          "Description"
                          "Description"
                          "Description"
                          "Description"
                          "Description"
                          "Description",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 40,
            ),
            const Divider(
              height: 2,
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Tools",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_month,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Provisional agenda",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 40,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(
                                "You don't have a job on Saturday October 22, 2022",
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "See",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 40,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  addMarker(String mId, LatLng location) async {
    var marker = Marker(
      markerId: MarkerId(mId),
      position: location,
      infoWindow: const InfoWindow(
        title: "some text here",
        snippet: 'some description of the place',
      ),
    );
    _markers[mId] = marker;
    setState(() {});
  }
}
