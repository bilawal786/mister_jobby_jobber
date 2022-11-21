import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import '../../providers/jobs_providers/available_jobs_provider/available_jobs_provider.dart';
import '../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
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
    final profileData =
        Provider.of<PersonalInformationProvider>(context, listen: true);
    final checkCompleteProfile =
        Provider.of<CheckProfileCompletionProvider>(context);
    final extractedCompleteData = checkCompleteProfile.checkProfileComplete;
    final availableJobsData =
        Provider.of<AvailableJobsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Intervention zone",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Consumer<PersonalInformationProvider>(
                  builder: (_, profileData, child) => SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                      profileData.profile!.address,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(MyRoutes.RADIUSINTERVENTIONSCREENROUTE),
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
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width / 1.2,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38),
              ),
            ),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(profileData.profile!.latitude),
                    double.parse(profileData.profile!.longitude)),
                zoom: 10,
              ),
              onMapCreated: (controller) {
                mapController = controller;
                if (availableJobsData.availableJobs != null){
                  for (int i = 0;
                      i < availableJobsData.availableJobs!.length;
                      i++) {
                    addMarker(
                      "$i",
                      LatLng(
                        double.parse(
                            availableJobsData.availableJobs![i].latitude),
                        double.parse(
                            availableJobsData.availableJobs![i].longitude),
                      ),
                      availableJobsData.availableJobs![i].title,
                      availableJobsData.availableJobs![i].address,
                    );
                  }
                  }
              },
              markers: _markers.values.toSet(),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
          ),
          if ((extractedCompleteData?.skills == "") &&
                  (extractedCompleteData?.monday == "" ||
                      extractedCompleteData!.tuesday == "" ||
                      extractedCompleteData.wednesday == "" ||
                      extractedCompleteData.thersday == "" ||
                      extractedCompleteData.friday == "" ||
                      extractedCompleteData.saturday == "" ||
                      extractedCompleteData.sunday == "") ||
              extractedCompleteData?.answer1 == "" ||
              extractedCompleteData?.insurance1 == "" ||
              extractedCompleteData?.rules1 == "" ||
              profileData.profile?.image == 'main/avatar.png' ||
              (extractedCompleteData?.phone == "") ||
              (extractedCompleteData?.euIdCardFront == "" &&
                  extractedCompleteData?.euIdResidencePermitFront == "") ||
              (extractedCompleteData?.vitalCardNumber == "" ||
                  extractedCompleteData?.socialSecurityNumber == "") ||
              extractedCompleteData?.score == "") ...[
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(MyRoutes.MANDATORYSTEPSSCREENROUTE),
              child: Container(
                color: Colors.amber.shade700,
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.circle_notifications_outlined,
                      size: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 40,
                    ),
                    Text(
                      "Actions required",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 40,
            ),
          ],
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Consumer<AvailableJobsProvider>(
                  builder: (_, jobsData, child) => InkWell(
                    onTap: () {
                      jobsData.setCheckApi();
                      Provider.of<AvailableJobsProvider>(context, listen: false)
                          .getAvailableJobs();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (jobsData.checkApi == false)
                          ? const SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator())
                          : const Icon(
                              Icons.refresh,
                              size: 25,
                              color: Colors.black,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Center(
                    child: Consumer<AvailableJobsProvider>(
                      builder: (_, availableJobs, child) => Text(
                        "${availableJobs.availableJobs?.length} Jobs are available",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Divider(),
          Consumer<AvailableJobsProvider>(
            builder: (_, extractedAvailableJobs, child) => RefreshIndicator(
              onRefresh: () {
                return Provider.of<AvailableJobsProvider>(context,
                        listen: false)
                    .getAvailableJobs();
              },
              child: Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width / 1.3,
                  child: (extractedAvailableJobs.availableJobs!.isNotEmpty)
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: extractedAvailableJobs.availableJobs?.length,
                          itemBuilder: (ctx, index) => Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => JobDetailScreen(
                                          jobsDetail: extractedAvailableJobs
                                              .availableJobs![index])));
                                },
                                child: Container(
                                  color: const Color(0xFFebf9fe),
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
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Icon(
                                              Icons.handyman_rounded,
                                              color: Colors.brown.shade700,
                                              size: 30,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            child: Text(
                                              extractedAvailableJobs
                                                  .availableJobs![index].title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${extractedAvailableJobs.availableJobs![index].estimateBudget} €",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                80,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "${extractedAvailableJobs.availableJobs![index].startTime} - ${extractedAvailableJobs.availableJobs![index].endTime} (${extractedAvailableJobs.availableJobs![index].duration} h)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          const Spacer(),
                                          if (extractedAvailableJobs
                                                  .availableJobs![index].urgent ==
                                              1)
                                            Container(
                                              padding: const EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.red.shade900,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: const FittedBox(
                                                child: Text(
                                                  "Urgent",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Cerebri Sans Bold',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Text(
                                        extractedAvailableJobs
                                            .availableJobs![index].serviceDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView(
                          children: [
                            Column(
                              children: <Widget>[
                                Icon(
                                  Icons.maps_home_work,
                                  size: 150,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  "No Job Found",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ).tr(),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 40,
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addMarker(
      String mId, LatLng location, String title, String description) async {
    var marker = Marker(
      markerId: MarkerId(mId),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: description,
      ),
    );
    _markers[mId] = marker;
    setState(() {});
  }
}
