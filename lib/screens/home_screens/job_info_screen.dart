import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../helper/routes.dart';

import '../../providers/commented_jobs_provider/commented_jobs_provider.dart';
import '../../providers/jobs_providers/single_job_comments_provider.dart';
import '../../providers/single_job_provider/single_job_provider.dart';
import '../image_preview_screen.dart';
import '../search_screen/jobee_profile.dart';

class JobInfoScreen extends StatefulWidget {
  final String id;
  const JobInfoScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<JobInfoScreen> createState() => _JobInfoScreenState();
}
class _JobInfoScreenState extends State<JobInfoScreen> {
  var jobsDetail;

  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};

  var isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit) {
      Provider.of<SingleJobProvider>(context).getSingleJobDetail(
          widget.id.toString());
      Provider.of<SingleJobCommentsProvider>(context, listen: false).getSingleJobComments(widget.id.toString());
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int commentedJobs = Provider.of<CommentedJobsProvider>(context).commentedJobsModel!.length;
    final singleJobData = Provider.of<SingleJobProvider>(context, listen: true);
    jobsDetail = singleJobData.jobDetail;
    return (singleJobData.checkApi != true) ? const Scaffold(body: Center(child: CircularProgressIndicator(),),)
        : Scaffold(
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
                      initialCameraPosition:  CameraPosition(
                        target: LatLng(
                            double.parse(singleJobData.jobDetail!.latitude),
                            double.parse(singleJobData.jobDetail!.longitude),
                        ),
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        mapController = controller;
                        addMarker("test", LatLng(
                          double.parse(singleJobData.jobDetail!.latitude),
                          double.parse(singleJobData.jobDetail!.longitude),
                        ),
                        singleJobData.jobDetail!.title,
                          singleJobData.jobDetail!.address,
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
                            jobsDetail.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${jobsDetail.estimateBudget} €",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => JobbyProfile(
                              demanderImgUrl: jobsDetail.demander.image,
                              demanderLName: jobsDetail.demander.lastName,
                              demanderName: jobsDetail.demander.firstName,
                              memberSince: jobsDetail.demander.memberSince,
                              demands: jobsDetail.demander.activeJobs.toString(),
                              reservations: jobsDetail.demander.totalHireJobber.toString(),
                              evaluations: jobsDetail.demander.rating.toString(),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 12,
                            foregroundImage: NetworkImage(
                              "${MyRoutes.IMAGEURL}/${jobsDetail.demander.image}",
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: Text(
                              "Posted by ${jobsDetail.demander.firstName} ${jobsDetail.demander.lastName},",
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          Text(
                            "- ${jobsDetail.createdAt}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
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
                          jobsDetail.serviceDate,
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
                          "${jobsDetail.startTime} to ${jobsDetail.endTime} ( ${jobsDetail.duration} h )",
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
                          "${jobsDetail.hours} € / hours",
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
                            jobsDetail.address,
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
                          "${jobsDetail.jobbers} Jobber ask",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(MyRoutes.COMMENTSCREENROUTE, arguments: {
                        'jobId': jobsDetail.id.toString(),
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
                            )
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
              if (jobsDetail.childcategoryId != null &&
                  (jobsDetail.childcategoryId == 1 ||
                      jobsDetail.childcategoryId == 2 ||
                      jobsDetail.childcategoryId == 19 ||
                      jobsDetail.childcategoryId == 23)) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                      if (int.parse(jobsDetail.medium) > 0) ...[
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
                              jobsDetail.medium,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                      if (int.parse(jobsDetail.large) > 0) ...[
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
                              jobsDetail.large,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                      if (int.parse(jobsDetail.verylarge) > 0) ...[
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
                              jobsDetail.verylarge,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                      if (jobsDetail.question.isNotEmpty) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        if (jobsDetail.childcategoryId == 1 ||
                            jobsDetail.childcategoryId == 2)
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
                                jobsDetail.question,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (jobsDetail.childcategoryId == 19)
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
                                jobsDetail.question,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 3) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 4) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 5) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 6) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 7) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 8) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  ((jobsDetail.childcategoryId == 9 ||
                      jobsDetail.childcategoryId == 10 ||
                      jobsDetail.childcategoryId == 11 ||
                      jobsDetail.childcategoryId == 12) &&
                      jobsDetail.description.isNotEmpty) ||
                  jobsDetail.childcategoryId == 13) ...[
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
                      if (jobsDetail.description.isNotEmpty) ...[
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
                          jobsDetail.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      if (jobsDetail.childcategoryId == 13) ...[
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
                              jobsDetail.question,
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

              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 14) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 15) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 16) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId != null &&
                  (jobsDetail.childcategoryId == 17 ||
                      jobsDetail.childcategoryId == 20)) ...[
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
                      if (jobsDetail.question.isNotEmpty &&
                          jobsDetail.question != 'null') ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        if (jobsDetail.childcategoryId == 17) ...[
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
                                jobsDetail.question,
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
                                jobsDetail.question1,
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
                                jobsDetail.question2,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                        if (jobsDetail.childcategoryId == 20) ...[
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
                                jobsDetail.question,
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
                                jobsDetail.question1,
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
              if (jobsDetail.childcategoryId != null &&
                  jobsDetail.childcategoryId == 18) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
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
                              jobsDetail.small,
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
              if (jobsDetail.childcategoryId == 21 ||
                  jobsDetail.childcategoryId == 22) ...[
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
                      if (double.parse(jobsDetail.surface) > 0)
                        Row(
                          children: <Widget>[
                            Text(
                              "Surface to be laid?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              jobsDetail.surface,
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
              if (jobsDetail.childcategoryId == 24) ...[
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
                      if (double.parse(jobsDetail.surface) > 0)
                        Row(
                          children: <Widget>[
                            Text(
                              "Surface to be laid?",
                              style: Theme.of(context).textTheme.labelMedium,
                            ).tr(),
                            const Spacer(),
                            Text(
                              jobsDetail.surface,
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
                            jobsDetail.question,
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
              if (jobsDetail.childcategoryId != null &&
                  (jobsDetail.childcategoryId == 25 ||
                      jobsDetail.childcategoryId == 26 ||
                      jobsDetail.childcategoryId == 27 ||
                      jobsDetail.childcategoryId == 28 ||
                      jobsDetail.childcategoryId == 29 ||
                      jobsDetail.childcategoryId == 30 ||
                      jobsDetail.childcategoryId == 31)) ...[
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
                      if (int.parse(jobsDetail.small) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            if (jobsDetail.childcategoryId == 25)
                              Text(
                                "How many leaks need to be repaired ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (jobsDetail.childcategoryId == 26)
                              Text(
                                "How many flushes do you need to be change ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (jobsDetail.childcategoryId == 27)
                              Text(
                                "How many taps do you need to be change ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (jobsDetail.childcategoryId == 28)
                              Text(
                                "How many sinks do you need to be unclog ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (jobsDetail.childcategoryId == 29)
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  "How many washing machines should be connected ?",
                                  style: Theme.of(context).textTheme.labelMedium,
                                  maxLines: 3,
                                ).tr(),
                              ),
                            if (jobsDetail.childcategoryId == 30)
                              Text(
                                "How many toilets do you need to fix ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (jobsDetail.childcategoryId == 31)
                              Text(
                                "How many plugs do you need to change ?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            const Spacer(),
                            Text(
                              jobsDetail.small,
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

              if (jobsDetail.subcategoryId == 5 ||
                  jobsDetail.subcategoryId == 8) ...[
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
                      if (double.parse(jobsDetail.surface) > 0) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Row(
                          children: <Widget>[
                            if (jobsDetail.subcategoryId == 5)
                              Text(
                                "Area to mow?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (jobsDetail.subcategoryId == 8)
                              Text(
                                "Area to clear",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            const Spacer(),
                            Text(
                              jobsDetail.surface,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            if (jobsDetail.subcategoryId == 5)
                              Text(
                                "Should the jobber bring his own mower?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (jobsDetail.subcategoryId == 8)
                              Text(
                                "Does the jobber have to bring his own brush?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            const Spacer(),
                            Text(
                              jobsDetail.question,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            if (jobsDetail.subcategoryId == 5)
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  "Does the jobber have to remove waste from your home?",
                                  style:
                                  Theme.of(context).textTheme.labelMedium,
                                ).tr(),
                              ),
                            if (jobsDetail.subcategoryId == 8)
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
                              jobsDetail.question1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            if (jobsDetail.subcategoryId == 5)
                              Text(
                                "Request frequency?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            if (jobsDetail.subcategoryId == 8)
                              Text(
                                "Demand frequencies?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            const Spacer(),
                            Text(
                              jobsDetail.question2,
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
              if (jobsDetail.subcategoryId == 6) ...[
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
                      if (double.parse(jobsDetail.surface) > 0) ...[
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
                              jobsDetail.surface,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        if (int.parse(jobsDetail.small) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Small size Between 1 and 1.5 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                jobsDetail.small,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(jobsDetail.medium) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Medium size Between 1.5 and 2 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                jobsDetail.medium,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(jobsDetail.large) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Large size Between 2 and 3 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                jobsDetail.large,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(jobsDetail.verylarge) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Very large size more than 3 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                jobsDetail.verylarge,
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
                              jobsDetail.question,
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
                              jobsDetail.question1,
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
              if (jobsDetail.subcategoryId == 7) ...[
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
                      if (double.parse(jobsDetail.surface) > 0) ...[
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
                              jobsDetail.surface,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        if (int.parse(jobsDetail.small) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Small size",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                jobsDetail.small,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(jobsDetail.medium) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Medium size ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                jobsDetail.medium,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(jobsDetail.large) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Large size ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                jobsDetail.large,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        if (int.parse(jobsDetail.verylarge) > 0)
                          Row(
                            children: <Widget>[
                              Text(
                                "Very large size more than 3 meters",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                              const Spacer(),
                              Text(
                                jobsDetail.verylarge,
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
                              jobsDetail.question,
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
                              jobsDetail.question1,
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

              if (jobsDetail.subcategoryId == 9) ...[
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
                      if (double.parse(jobsDetail.surface) > 0) ...[
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
                              jobsDetail.surface,
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
                              jobsDetail.question,
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
                              jobsDetail.question1,
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
              if (jobsDetail.subcategoryId == 10 ||
                  jobsDetail.subcategoryId == 11 ||
                  jobsDetail.subcategoryId == 12 ||
                  jobsDetail.subcategoryId == 13) ...[
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
                          jobsDetail.description,
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
                            jobsDetail.question,
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

              if (jobsDetail.subcategoryId == 14) ...[
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
                          jobsDetail.pickupAddress,
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
                          jobsDetail.destinationAddress,
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
                            jobsDetail.surface,
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
                            jobsDetail.question,
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
              if (jobsDetail.subcategoryId == 15 ||
                  jobsDetail.subcategoryId == 16) ...[
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
                          jobsDetail.pickupAddress,
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
                          jobsDetail.destinationAddress,
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
                            jobsDetail.question,
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
                            jobsDetail.question1,
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
              if (jobsDetail.subcategoryId == 17 ||
                  jobsDetail.subcategoryId == 18 ||
                  jobsDetail.subcategoryId == 28 ||
                  jobsDetail.subcategoryId == 37 ||
                  jobsDetail.subcategoryId == 38 ||
                  jobsDetail.subcategoryId == 39 ||
                  jobsDetail.subcategoryId == 40 ||
                  jobsDetail.subcategoryId == 41 ||
                  jobsDetail.subcategoryId == 42 ||
                  jobsDetail.subcategoryId == 43 ||
                  jobsDetail.subcategoryId == 44 ||
                  jobsDetail.subcategoryId == 45) ...[
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
                          jobsDetail.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          if (jobsDetail.subcategoryId == 17 ||
                              jobsDetail.subcategoryId == 18)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Does the service provider have to come with his own truck?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.subcategoryId == 28 ||
                              jobsDetail.subcategoryId == 37 ||
                              jobsDetail.subcategoryId == 38 ||
                              jobsDetail.subcategoryId == 39 ||
                              jobsDetail.subcategoryId == 40 ||
                              jobsDetail.subcategoryId == 41 ||
                              jobsDetail.subcategoryId == 42 ||
                              jobsDetail.subcategoryId == 43 ||
                              jobsDetail.subcategoryId == 44 ||
                              jobsDetail.subcategoryId == 45)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Request Frequencies",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          Text(
                            jobsDetail.question,
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

              if (jobsDetail.subcategoryId == 19 ||
                  jobsDetail.subcategoryId == 20 ||
                  jobsDetail.subcategoryId == 21 ||
                  jobsDetail.subcategoryId == 22) ...[
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
                          jobsDetail.pickupAddress,
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
                          jobsDetail.destinationAddress,
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
                            jobsDetail.question,
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
                            jobsDetail.small,
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
              if (jobsDetail.subcategoryId == 23) ...[
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
                            jobsDetail.surface,
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
                            jobsDetail.question,
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
                            jobsDetail.question1,
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
                            jobsDetail.question2,
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
                            jobsDetail.question3,
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
              if (jobsDetail.subcategoryId == 24 ||
                  jobsDetail.subcategoryId == 25 ||
                  jobsDetail.subcategoryId == 27) ...[
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
                          if (jobsDetail.subcategoryId == 24)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Select the number of clothes",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.subcategoryId == 25)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Vehicle type",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.subcategoryId == 27)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Number of windows",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          Text(
                            jobsDetail.question,
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
                            jobsDetail.question1,
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
              if (jobsDetail.subcategoryId == 26) ...[
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
                            jobsDetail.surface,
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
                            jobsDetail.question,
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
              if (jobsDetail.subcategoryId == 30 ||
                  jobsDetail.subcategoryId == 31 ||
                  jobsDetail.subcategoryId == 32 ||
                  jobsDetail.subcategoryId == 34) ...[
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
                          if (jobsDetail.subcategoryId == 30 ||
                              jobsDetail.subcategoryId == 31 ||
                              jobsDetail.subcategoryId == 32)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Type of gaurd",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.subcategoryId == 34)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Course duration",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          const Spacer(),
                          Text(
                            jobsDetail.question,
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
              if (jobsDetail.subcategoryId == 33) ...[
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
                          if (jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Free from I escape disk",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Detection and eradication of viruses and spyware",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "3")
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
                            jobsDetail.question1,
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
                            jobsDetail.question2,
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
              if (jobsDetail.subcategoryId == 35) ...[
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
                          if (jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Local via USB cable",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "2")
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
              if (jobsDetail.subcategoryId == 36 ||
                  jobsDetail.subcategoryId == 66 ||
                  jobsDetail.subcategoryId == 68 ||
                  jobsDetail.subcategoryId == 69
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
                          jobsDetail.description,
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

              if (jobsDetail.subcategoryId == 46 ||
                  jobsDetail.subcategoryId == 47 ||
                  jobsDetail.subcategoryId == 48 ||
                  jobsDetail.subcategoryId == 49 ||
                  jobsDetail.subcategoryId == 50 ||
                  jobsDetail.subcategoryId == 51 ||
                  jobsDetail.subcategoryId == 52 ||
                  jobsDetail.subcategoryId == 53 ||
                  jobsDetail.subcategoryId == 54 ||
                  jobsDetail.subcategoryId == 55 ||
                  jobsDetail.subcategoryId == 56 ||
                  jobsDetail.subcategoryId == 57 ||
                  jobsDetail.subcategoryId == 58 ||
                  jobsDetail.subcategoryId == 59 ||
                  jobsDetail.subcategoryId == 60) ...[
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
                              jobsDetail.question,
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
                              jobsDetail.question1,
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
                              jobsDetail.question2,
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
              if (jobsDetail.subcategoryId == 61 ||
                  jobsDetail.subcategoryId == 65) ...[
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
                          if (jobsDetail.subcategoryId == 61)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Photo editing?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.subcategoryId == 65)
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
                              jobsDetail.question,
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
                          if (jobsDetail.subcategoryId == 61)
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Discount on USB key?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.subcategoryId == 65)
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
                              jobsDetail.question1,
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
              if (jobsDetail.subcategoryId == 62) ...[
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
                              jobsDetail.small,
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
                          if (jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Sit-down meal",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "cocktail buffet",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "3")
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
                              jobsDetail.question1,
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
                              jobsDetail.question2,
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
                              jobsDetail.question3,
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
              if (jobsDetail.subcategoryId == 63) ...[
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
                              jobsDetail.small,
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
                              jobsDetail.question,
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
                              jobsDetail.question1,
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
                              jobsDetail.question2,
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
              if (jobsDetail.subcategoryId == 64) ...[
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
                              jobsDetail.small,
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
                          if (jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Sit-down meal",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "cocktail buffet",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "3")
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
                              jobsDetail.question1,
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
              if (jobsDetail.subcategoryId == 67) ...[
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
                              jobsDetail.surface,
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
                          if (jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Street marketing",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Letter box",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "3")
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
              if (jobsDetail.subcategoryId == 70) ...[
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
                          if (jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Drain",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Tires",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Braking",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "4")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Windscreen wipers",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "5")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Candles",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "6")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Battery",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "7")
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
              if (jobsDetail.subcategoryId == 71) ...[
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
                          if (jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Engine part",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "2")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Mechanical piece",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Body",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "4")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Mirror",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "5")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Chest",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "6")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Door",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "7")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Window",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "8")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Lighting",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "9")
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
              if (jobsDetail.subcategoryId == 72) ...[
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
                          if (jobsDetail.question == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Home appliance",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question == "2")
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
                          if (jobsDetail.question1 == "1")
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Mechanical",
                                style: Theme.of(context).textTheme.labelMedium,
                              ).tr(),
                            ),
                          if (jobsDetail.question1 == "2")
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
              if (jobsDetail.detailDescription.isNotEmpty ||
                  jobsDetail.image1 != "" ||
                  jobsDetail.image2 != "" ||
                  jobsDetail.image3 != "") ...[
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
                              jobsDetail.detailDescription,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      if (jobsDetail.image1 != "" ||
                          jobsDetail.image2 != "" ||
                          jobsDetail.image3 != "")
                        Text(
                          "Images",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 40,
                      ),
                      Row(
                        children: <Widget>[
                          (jobsDetail.image1 != "")
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
                                          "${MyRoutes.IMAGEURL}${jobsDetail.image1}"),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  "${MyRoutes.IMAGEURL}${jobsDetail.image1}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                              : const SizedBox(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          (jobsDetail.image2 != "")
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
                                          "${MyRoutes.IMAGEURL}${jobsDetail.image2}"),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  "${MyRoutes.IMAGEURL}${jobsDetail.image2}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                              : const SizedBox(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          (jobsDetail.image3 != "")
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
                                          "${MyRoutes.IMAGEURL}${jobsDetail.image3}"),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  "${MyRoutes.IMAGEURL}${jobsDetail.image3}",
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
