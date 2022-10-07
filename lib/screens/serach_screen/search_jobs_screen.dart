import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchJobScreen extends StatefulWidget {
  const SearchJobScreen({Key? key}) : super(key: key);

  @override
  State<SearchJobScreen> createState() => _SearchJobScreenState();
}

const LatLng currentLocation = LatLng(31.561920, 74.348080);

class _SearchJobScreenState extends State<SearchJobScreen> {
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Container(
            padding: const EdgeInsets.all(20),
            child: const Center(
              child: Text("20 Jobs are availble"),
            ),
          ),
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.4,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) => const ListTile(
                title: Text("Text here"),
              ),
            ),
          ),
        ],
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
