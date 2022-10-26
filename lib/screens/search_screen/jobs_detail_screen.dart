import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../screens/search_screen/comment_screen.dart';

import '../../../models/job_models/available_jobs_model.dart';
import '../../../widgets/const_widgets/custom_button.dart';
import '../../../providers/jobs_providers/job_details_provider.dart';
import '../image_preview_screen.dart';

class JobDetailScreen extends StatefulWidget {
  final AvailableJobsModel jobsDetail;
  const JobDetailScreen({Key? key, required this.jobsDetail}) : super(key: key);

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
        height: MediaQuery.of(context).size.width / 2.3,
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
                  "${widget.jobsDetail.estimateBudget} €",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                (widget.jobsDetail.isApplied == false)
                    ? Expanded(
                        child: Consumer<JobsDetailProvider>(
                          builder: (_, bottomSheet, child) => CustomButton(
                              onPress: () {
                                bottomSheet.postId = widget.jobsDetail.id;
                                bottomSheet.fixedRate =
                                    int.parse(widget.jobsDetail.hours);
                                bottomSheet.hourlyRate =
                                    int.parse(widget.jobsDetail.hours);
                                bottomSheet.hours =
                                    double.parse(widget.jobsDetail.duration);
                                bottomSheet.showBottomSheet(
                                  context,
                                );
                              },
                              buttonName: "To apply"),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.green.shade700,
                          ),
                        ),
                        child: Text(
                          "Already Applied",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cerebri Sans Bold'),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.0,
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
                          widget.jobsDetail.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Text(
                          "${widget.jobsDetail.estimateBudget} €",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 12,
                          foregroundImage: NetworkImage(
                            "${MyRoutes.IMAGEURL}/${widget.jobsDetail.demander.image}",
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: Text(
                            "Posted by ${widget.jobsDetail.demander.firstName} ${widget.jobsDetail.demander.lastName},",
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 40,
                        ),
                        Text(
                          "- ${widget.jobsDetail.createdAt}",
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
                          widget.jobsDetail.serviceDate,
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
                          "${widget.jobsDetail.startTime} to ${widget.jobsDetail.endTime} ( ${widget.jobsDetail.duration} h )",
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
                          "${widget.jobsDetail.hours} € / hours",
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
                          widget.jobsDetail.address,
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
                          "${widget.jobsDetail.jobbers} Jobber ask",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const CommentScreen())),
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
                          "Small Size Furniture",
                          style: Theme.of(context).textTheme.labelMedium,
                        ).tr(),
                        const Spacer(),
                        Text(
                          widget.jobsDetail.small,
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
              if (widget.jobsDetail.detailDescription.isNotEmpty ||
                  widget.jobsDetail.image1 != "" ||
                  widget.jobsDetail.image2 != "" ||
                  widget.jobsDetail.image3 != "") ...[
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
                              widget.jobsDetail.detailDescription,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      if (widget.jobsDetail.image1 != "" ||
                          widget.jobsDetail.image2 != "" ||
                          widget.jobsDetail.image3 != "")
                        Text(
                          "Images",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          (widget.jobsDetail.image1 != "")
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => ImagePreview(
                                                imageUrl:
                                                    "${MyRoutes.IMAGEURL}${widget.jobsDetail.image1}"),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        "${MyRoutes.IMAGEURL}${widget.jobsDetail.image1}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                          (widget.jobsDetail.image2 != "")
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => ImagePreview(
                                                imageUrl:
                                                    "${MyRoutes.IMAGEURL}${widget.jobsDetail.image2}"),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        "${MyRoutes.IMAGEURL}${widget.jobsDetail.image2}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                          (widget.jobsDetail.image3 != "")
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => ImagePreview(
                                                imageUrl:
                                                    "${MyRoutes.IMAGEURL}${widget.jobsDetail.image3}"),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        "${MyRoutes.IMAGEURL}${widget.jobsDetail.image3}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
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
              ],
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
