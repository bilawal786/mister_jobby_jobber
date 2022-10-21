import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../providers/jobs_providers/area_of_intervention_provider/area_intervention_provider.dart';
import '../../screens/search_screen/jobs_detail_screen.dart';

class SearchJobScreen extends StatefulWidget {
  const SearchJobScreen({Key? key}) : super(key: key);

  @override
  State<SearchJobScreen> createState() => _SearchJobScreenState();
}


class _SearchJobScreenState extends State<SearchJobScreen> {
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final interventionAreaData = Provider.of<AreaInterventionProvider>(context, listen: true);
    LatLng currentLocation = LatLng(interventionAreaData.latitude, interventionAreaData.longitude);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.location_on, size: 25, color: Theme.of(context).primaryColor,),
            SizedBox(width: MediaQuery.of(context).size.width / 40,),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Intervention zone", style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.7,
                    child: Text(interventionAreaData.completeAddress, style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,)),

              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(MyRoutes.RADIUSINTERVENTIONSCREENROUTE),
            child: Text(
              "Modifier",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontFamily: 'Cerebri Sans Bold',
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.9,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(interventionAreaData.latitude, interventionAreaData.longitude),
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
            Container(
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text("20 Jobs are available"),
              ),
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.6,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const JobDetailScreen()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.brown.shade300,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(
                                    Icons.handyman_rounded,
                                    color: Colors.brown.shade700,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 40,
                                ),
                                Text(
                                  "TV dressing with lights",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Spacer(),
                                Text(
                                  "36 €",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "13:00 to 14:00 (1h)",
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade700,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: const Text(
                                    "Urgent",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cerebri Sans Bold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Today",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
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
