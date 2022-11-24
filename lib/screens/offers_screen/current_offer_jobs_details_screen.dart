import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mister_jobby_jobber/providers/jobs_providers/available_jobs_provider/available_jobs_provider.dart';
import 'package:provider/provider.dart';
import '../../helper/routes.dart';

import '../../models/commented_jobs_model/current_jobs_offers_model.dart';
import '../../providers/jobs_providers/single_job_comments_provider.dart';
import '../image_preview_screen.dart';

class SingleJobDetailScreen extends StatefulWidget {
  final Job jobsDetail;
  const SingleJobDetailScreen({Key? key, required this.jobsDetail}) : super(key: key);

  @override
  State<SingleJobDetailScreen> createState() => _SingleJobDetailScreenState();
}

class _SingleJobDetailScreenState extends State<SingleJobDetailScreen> {

  var isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit) {
      Provider.of<SingleJobCommentsProvider>(context,
          listen: false).getSingleJobComments(widget.jobsDetail.id.toString());
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void ignoreJobOpenSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.width / 6,
            margin: const EdgeInsets.all(10),
            // padding: const EdgeInsets.all(10,),
            child: InkWell(
              onTap: () {
                Provider.of<AvailableJobsProvider>(context, listen: false).ignoreThisJob(context, widget.jobsDetail.id.toString());
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.blue),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Icon(
                        FontAwesomeIcons.personCircleXmark,
                        color: Colors.red.shade400,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Center(
                        child: Text(
                          "Ignor_Job",
                          style: Theme.of(context).textTheme.bodySmall,
                        ).tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
          Column(
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
                      initialCameraPosition:  CameraPosition(
                        target: LatLng(
                        double.parse(widget.jobsDetail.latitude)
                        , double.parse(widget.jobsDetail.longitude),),
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        mapController = controller;
                        addMarker("test", LatLng(
                          double.parse(widget.jobsDetail.latitude)
                          , double.parse(widget.jobsDetail.longitude),),
                            widget.jobsDetail.title,
                            widget.jobsDetail.address,
                        );
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
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: (){
                        ignoreJobOpenSheet();
                        },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.more_vert_rounded, color: Colors.black,size: 25,),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            widget.jobsDetail.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Text(
                            widget.jobsDetail.address,
                            style: Theme.of(context).textTheme.labelMedium,
                            maxLines: 2,
                          ),
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
                      onTap: () => Navigator.of(context).pushNamed(MyRoutes.COMMENTSCREENROUTE, arguments: {
                        'jobId': widget.jobsDetail.id.toString(),
                      }),
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
                            Consumer<SingleJobCommentsProvider>(
                              builder: (context, data, child) => Text(
                                  (data.singleJobComments?.length == null) ? "(0)" :
                                "(${data.singleJobComments?.length.toString()})",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontFamily: "Cerebri Sans Bold",
                                ),
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
              if (widget.jobsDetail.childcategoryId != null &&
                  (widget.jobsDetail.childcategoryId == 1 ||
                      widget.jobsDetail.childcategoryId == 2 ||
                      widget.jobsDetail.childcategoryId == 19 ||
                      widget.jobsDetail.childcategoryId == 23)) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Small Size",
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
                      if (int.parse(widget.jobsDetail.medium) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Medium Size ",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.medium,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                      if (int.parse(widget.jobsDetail.large) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Large Size ",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.large,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                      if (int.parse(widget.jobsDetail.verylarge) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Very Large Size ",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.verylarge,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                      if (widget.jobsDetail.question.isNotEmpty) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        if (widget.jobsDetail.childcategoryId == 1 ||
                            widget.jobsDetail.childcategoryId == 2)
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(
                                  "Do you want the service provider to clear the boxes ?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.question,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (widget.jobsDetail.childcategoryId == 19)
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(
                                  "Pass two coats?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.question,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                      ],
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 3) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many rods should be installed?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 4) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many Shelves should be fixed?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 5) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many TVs do you need to hang?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 6) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many Shower screens should be installed?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 7) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many paintings should be hung?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 8) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many mirrors should be hung?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  ((widget.jobsDetail.childcategoryId == 9 ||
                      widget.jobsDetail.childcategoryId == 10 ||
                      widget.jobsDetail.childcategoryId == 11 ||
                      widget.jobsDetail.childcategoryId == 12) &&
                      widget.jobsDetail.description.isNotEmpty) ||
                  widget.jobsDetail.childcategoryId == 13) ...[
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
                      if (widget.jobsDetail.description.isNotEmpty) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Text(
                          "What is your need?",
                          style: Theme.of(context).textTheme.labelLarge,
                        ).tr(),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Text(
                          widget.jobsDetail.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      if (widget.jobsDetail.childcategoryId == 13) ...[
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Text(
                                "Do you want the service provider to clear the boxes?",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ]
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

              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 14) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many outlets should be installed?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 15) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many bulbs do you need to change?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 16) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many lamps should be installed?",
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
              if (widget.jobsDetail.childcategoryId != null &&
                  (widget.jobsDetail.childcategoryId == 17 ||
                      widget.jobsDetail.childcategoryId == 20)) ...[
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
                      if (widget.jobsDetail.question.isNotEmpty &&
                          widget.jobsDetail.question != 'null') ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        if (widget.jobsDetail.childcategoryId == 17) ...[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  "Do you want the service provider to clear the boxes?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.question,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  "Equipment(s)?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.question1,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  "Camera?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.question2,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                        if (widget.jobsDetail.childcategoryId == 20) ...[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  "Need to install baseboards?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.question,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  "Does the jobber have to bring his own cutting material?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.question1,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ]
                      ],
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
              if (widget.jobsDetail.childcategoryId != null &&
                  widget.jobsDetail.childcategoryId == 18) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "How many Ac should be installed?",
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
              if (widget.jobsDetail.childcategoryId == 21 ||
                  widget.jobsDetail.childcategoryId == 22) ...[
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
                      if (double.parse(widget.jobsDetail.surface) > 0)
                        Row(
                          children: <Widget>[
                            Text(
                              "Surface to be laid?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.surface,
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
              ],
              if (widget.jobsDetail.childcategoryId == 24) ...[
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
                      if (double.parse(widget.jobsDetail.surface) > 0)
                        Row(
                          children: <Widget>[
                            Text(
                              "Surface to be laid?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.surface,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              "Does the jobber have to bring his own cutting material?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
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
              ],
              if (widget.jobsDetail.childcategoryId != null &&
                  (widget.jobsDetail.childcategoryId == 25 ||
                      widget.jobsDetail.childcategoryId == 26 ||
                      widget.jobsDetail.childcategoryId == 27 ||
                      widget.jobsDetail.childcategoryId == 28 ||
                      widget.jobsDetail.childcategoryId == 29 ||
                      widget.jobsDetail.childcategoryId == 30 ||
                      widget.jobsDetail.childcategoryId == 31)) ...[
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
                      if (int.parse(widget.jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            if (widget.jobsDetail.childcategoryId == 25)
                              Text(
                                "How many leaks need to be repaired ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.childcategoryId == 26)
                              Text(
                                "How many flushes do you need to be change ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.childcategoryId == 27)
                              Text(
                                "How many taps do you need to be change ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.childcategoryId == 28)
                              Text(
                                "How many sinks do you need to be unclog ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.childcategoryId == 29)
                              Text(
                                "How many washing machines should be connected ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.childcategoryId == 30)
                              Text(
                                "How many toilets do you need to fix ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.childcategoryId == 31)
                              Text(
                                "How many plugs do you need to change ?",
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

              if (widget.jobsDetail.subcategoryId == 5 ||
                  widget.jobsDetail.subcategoryId == 8) ...[
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
                      if (double.parse(widget.jobsDetail.surface) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            if (widget.jobsDetail.subcategoryId == 5)
                              Text(
                                "Area to mow?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.subcategoryId == 8)
                              Text(
                                "Area to clear",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.surface,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            if (widget.jobsDetail.subcategoryId == 5)
                              Text(
                                "Should the jobber bring his own mower?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.subcategoryId == 8)
                              Text(
                                "Does the jobber have to bring his own brush?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            if (widget.jobsDetail.subcategoryId == 5)
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  "Does the jobber have to remove waste from your home?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                            if (widget.jobsDetail.subcategoryId == 8)
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  "Does the jobber have to remove waste from your home?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            if (widget.jobsDetail.subcategoryId == 5)
                              Text(
                                "Request frequency?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (widget.jobsDetail.subcategoryId == 8)
                              Text(
                                "Demand frequencies?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question2,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
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
              if (widget.jobsDetail.subcategoryId == 6) ...[
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
                      if (double.parse(widget.jobsDetail.surface) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Number of linear meters?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.surface,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        if (int.parse(widget.jobsDetail.small) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Small size Between 1 and 1.5 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.small,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(widget.jobsDetail.medium) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Medium size Between 1.5 and 2 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.medium,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(widget.jobsDetail.large) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Large size Between 2 and 3 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.large,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(widget.jobsDetail.verylarge) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Very large size more than 3 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.verylarge,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                "Should the jobber bring his own hedge trimmer?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Does the jobber have to remove waste?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
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
              if (widget.jobsDetail.subcategoryId == 7) ...[
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
                      if (double.parse(widget.jobsDetail.surface) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Number of trees to be cut?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.surface,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        if (int.parse(widget.jobsDetail.small) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Small size",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.small,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(widget.jobsDetail.medium) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Medium size ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.medium,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(widget.jobsDetail.large) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Large size ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.large,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(widget.jobsDetail.verylarge) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Very large size more than 3 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                widget.jobsDetail.verylarge,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                "Does the jobber have to bring his material?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Should the jobber remove waste?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
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

              if (widget.jobsDetail.subcategoryId == 9) ...[
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
                      if (double.parse(widget.jobsDetail.surface) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Surface to be weeded?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.surface,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                "Does the jobber have to remove waste?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Demand Frequencies?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              widget.jobsDetail.question1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
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
              if (widget.jobsDetail.subcategoryId == 10 ||
                  widget.jobsDetail.subcategoryId == 11 ||
                  widget.jobsDetail.subcategoryId == 12 ||
                  widget.jobsDetail.subcategoryId == 13) ...[
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
                      Text(
                        "What do you need?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          widget.jobsDetail.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Demand Frequencies?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],

              if (widget.jobsDetail.subcategoryId == 14) ...[
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
                      Text(
                        "Pick-up address?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          widget.jobsDetail.pickupAddress,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "destination address?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          widget.jobsDetail.destinationAddress,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Housing area to move",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.surface,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Does the service provider have to come with his own truck?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 15 ||
                  widget.jobsDetail.subcategoryId == 16) ...[
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
                      Text(
                        "Pick-up address?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          widget.jobsDetail.pickupAddress,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "destination address?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          widget.jobsDetail.destinationAddress,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Number of pieces of furniture",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Does the service provider have to come with his own truck?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question1,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 17 ||
                  widget.jobsDetail.subcategoryId == 18 ||
                  widget.jobsDetail.subcategoryId == 28 ||
                  widget.jobsDetail.subcategoryId == 37 ||
                  widget.jobsDetail.subcategoryId == 38 ||
                  widget.jobsDetail.subcategoryId == 39 ||
                  widget.jobsDetail.subcategoryId == 40 ||
                  widget.jobsDetail.subcategoryId == 41 ||
                  widget.jobsDetail.subcategoryId == 42 ||
                  widget.jobsDetail.subcategoryId == 43 ||
                  widget.jobsDetail.subcategoryId == 44 ||
                  widget.jobsDetail.subcategoryId == 45) ...[
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
                      Text(
                        "What do you need?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          widget.jobsDetail.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.subcategoryId == 17 ||
                              widget.jobsDetail.subcategoryId == 18)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Does the service provider have to come with his own truck?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.subcategoryId == 28 ||
                              widget.jobsDetail.subcategoryId == 37 ||
                              widget.jobsDetail.subcategoryId == 38 ||
                              widget.jobsDetail.subcategoryId == 39 ||
                              widget.jobsDetail.subcategoryId == 40 ||
                              widget.jobsDetail.subcategoryId == 41 ||
                              widget.jobsDetail.subcategoryId == 42 ||
                              widget.jobsDetail.subcategoryId == 43 ||
                              widget.jobsDetail.subcategoryId == 44 ||
                              widget.jobsDetail.subcategoryId == 45)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Request Frequencies",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],

              if (widget.jobsDetail.subcategoryId == 19 ||
                  widget.jobsDetail.subcategoryId == 20 ||
                  widget.jobsDetail.subcategoryId == 21 ||
                  widget.jobsDetail.subcategoryId == 22) ...[
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
                      Text(
                        "Pick-up address",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          widget.jobsDetail.pickupAddress,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        "Destination address",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          widget.jobsDetail.destinationAddress,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Do I have to assemble the furniture",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Number of floor on arrival",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.small,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 23) ...[
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Surface to be cleaned",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.surface,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Window cleaning",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Appliance cleaning",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question1,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Ironing",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question2,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Demand Frequencies",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question3,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 24 ||
                  widget.jobsDetail.subcategoryId == 25 ||
                  widget.jobsDetail.subcategoryId == 27) ...[
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
                          if (widget.jobsDetail.subcategoryId == 24)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Select the number of clothes",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.subcategoryId == 25)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Vehicle type",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.subcategoryId == 27)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Number of windows",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Demand Frequencies",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question1,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 26) ...[
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Select surface",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.surface,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "How often do you want this job to be done ?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 30 ||
                  widget.jobsDetail.subcategoryId == 31 ||
                  widget.jobsDetail.subcategoryId == 32 ||
                  widget.jobsDetail.subcategoryId == 34) ...[
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
                          if (widget.jobsDetail.subcategoryId == 30 ||
                              widget.jobsDetail.subcategoryId == 31 ||
                              widget.jobsDetail.subcategoryId == 32)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Type of gaurd",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.subcategoryId == 34)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Course duration",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 33) ...[
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
                          if (widget.jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Free from I escape disk",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Detection and eradication of viruses and spyware",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Complete checkup",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          const Text(
                            "True",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Installing Update",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question1,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Data backup",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          Text(
                            widget.jobsDetail.question2,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 35) ...[
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
                          if (widget.jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Local via USB cable",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Network (Wifi or bluetooth)",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          const Text(
                            "True",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Cerebri Sans Bold',
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
              ],
              if (widget.jobsDetail.subcategoryId == 36 ||
                  widget.jobsDetail.subcategoryId == 66 ||
                  widget.jobsDetail.subcategoryId == 68 ||
                  widget.jobsDetail.subcategoryId == 69
              ) ...[
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "What you need",
                          style: Theme.of(context).textTheme.labelMedium,
                        ).tr(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          widget.jobsDetail.description,
                          style: Theme.of(context).textTheme.labelMedium,
                        ).tr(),
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

              if (widget.jobsDetail.subcategoryId == 46 ||
                  widget.jobsDetail.subcategoryId == 47 ||
                  widget.jobsDetail.subcategoryId == 48 ||
                  widget.jobsDetail.subcategoryId == 49 ||
                  widget.jobsDetail.subcategoryId == 50 ||
                  widget.jobsDetail.subcategoryId == 51 ||
                  widget.jobsDetail.subcategoryId == 52 ||
                  widget.jobsDetail.subcategoryId == 53 ||
                  widget.jobsDetail.subcategoryId == 54 ||
                  widget.jobsDetail.subcategoryId == 55 ||
                  widget.jobsDetail.subcategoryId == 56 ||
                  widget.jobsDetail.subcategoryId == 57 ||
                  widget.jobsDetail.subcategoryId == 58 ||
                  widget.jobsDetail.subcategoryId == 59 ||
                  widget.jobsDetail.subcategoryId == 60) ...[
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Educational level requested",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Desired course format",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Request Frequency",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question2,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],
              if (widget.jobsDetail.subcategoryId == 61 ||
                  widget.jobsDetail.subcategoryId == 65) ...[
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
                          if (widget.jobsDetail.subcategoryId == 61)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Photo editing?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.subcategoryId == 65)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Does the jobber have to provider the mixing board?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.subcategoryId == 61)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Discount on USB key?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.subcategoryId == 65)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "The jobber must provide the sound system?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],
              if (widget.jobsDetail.subcategoryId == 62) ...[
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Number of restorations",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.small,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Sit-down meal",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "cocktail buffet",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Meal tray",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Text(
                              "true",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Does the jobber have to provide the dishes?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "The jobber must provide the utensils?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question2,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Should the jobber empty the bins?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question3,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],
              if (widget.jobsDetail.subcategoryId == 63) ...[
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Number of prompts",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.small,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Does the jobber have to provide the dishes?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "The jobber must provide the utensils?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Should the jobber empty the bins?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question2,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],
              if (widget.jobsDetail.subcategoryId == 64) ...[
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Number of restorations",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.small,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Sit-down meal",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "cocktail buffet",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Meal tray",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Text(
                              "true",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Should  the jobber empty the bins?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.question1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],
              if (widget.jobsDetail.subcategoryId == 67) ...[
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Number of flyers",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              widget.jobsDetail.surface,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Street marketing",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Letter box",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Windshield",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Text(
                              "true",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],
              if (widget.jobsDetail.subcategoryId == 70) ...[
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "Type of repair",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ).tr(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Drain",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Tires",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Braking",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "4")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Windscreen wipers",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "5")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Candles",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "6")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Battery",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "7")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Air conditioner",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Text(
                              "true",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],
              if (widget.jobsDetail.subcategoryId == 71) ...[
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "Type of repair",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ).tr(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Engine part",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Mechanical piece",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Body",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "4")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Mirror",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "5")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Chest",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "6")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Door",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "7")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Window",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "8")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Lighting",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "9")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Accessories",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Text(
                              "true",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],
              if (widget.jobsDetail.subcategoryId == 72) ...[
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "Item types",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ).tr(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Home appliance",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Vehicle",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Text(
                              "true",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "Material type of repair",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ).tr(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (widget.jobsDetail.question1 == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Mechanical",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (widget.jobsDetail.question1 == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Electric",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Text(
                              "true",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cerebri Sans Bold',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ).tr(),
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
              ],

              // Description
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
                            width: MediaQuery.of(context).size.width / 40,
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
                            width: MediaQuery.of(context).size.width / 40,
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
                // const Divider(
                //   height: 2,
                //   thickness: 10,
                // ),
              ],
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         "Tools",
              //         style: Theme.of(context).textTheme.titleMedium,
              //       ),
              //       SizedBox(
              //         height: MediaQuery.of(context).size.width / 40,
              //       ),
              //       Row(
              //         children: <Widget>[
              //           Icon(
              //             Icons.calendar_month,
              //             size: 25,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //           SizedBox(
              //             width: MediaQuery.of(context).size.width / 40,
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Text(
              //                 "Provisional agenda",
              //                 style: Theme.of(context).textTheme.bodyMedium,
              //               ),
              //               SizedBox(
              //                 height: MediaQuery.of(context).size.width / 40,
              //               ),
              //               SizedBox(
              //                   width: MediaQuery.of(context).size.width / 1.8,
              //                   child: Text(
              //                     "You don't have a job on Saturday October 22, 2022",
              //                     style:
              //                     Theme.of(context).textTheme.labelMedium,
              //                   )),
              //             ],
              //           ),
              //           const Spacer(),
              //           Text(
              //             "See",
              //             style: Theme.of(context).textTheme.bodyLarge,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.width / 40,
              // ),
              // const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  addMarker(String mId, LatLng location, String title, String address) async {
    var marker = Marker(
      markerId: MarkerId(mId),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: address,
      ),
    );
    _markers[mId] = marker;
    setState(() {});
  }
}
