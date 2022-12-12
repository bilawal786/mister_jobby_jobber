import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helper/routes.dart';
import '../../providers/accounts_providers/subscription/subscription_provider.dart';
import '../../providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import '../../providers/commented_jobs_provider/commented_jobs_provider.dart';
import '../../providers/commented_jobs_provider/current_jobs_offers_provider.dart';
import '../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import '../../widgets/const_widgets/custom_button.dart';
import '../offers_screen/current_offers.dart';
import 'home_tab_screen.dart';
import 'job_info_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List> mySelectedEvents = {};
  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    getScheduleJobs();
    loadPreviousEvents();
  }

  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<CurrentJobsOffersProvider>(context)
          .getCommentedJobs(context);
      Provider.of<CommentedJobsProvider>(context).getCommentedJobs(context);
      Provider.of<PersonalInformationProvider>(context).getProfile(context);
      Provider.of<CheckProfileCompletionProvider>(context)
          .getProfileCompletionData(context);
      Provider.of<SubscriptionProvider>(context)
          .getRetrieveSubscription(context);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  var checkApi = false;

  Future<void> getScheduleJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    var response = await http.get(
      Uri.parse('${MyRoutes.BASEURL}/jobber/schedule/jobs'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken'
      },
    );
    if (response.statusCode == 200) {
      debugPrint('Schedule Jobs Api is working');
      if (!mounted) {
        return;
      }
      setState(() {
        mySelectedEvents = Map<String, List>.from(json.decode(response.body));
        checkApi = true;
      });
      // print(mySelectedEvents);
    } else {
      debugPrint('Schedule Jobs Api is not working');
      if (!mounted) {
        return;
      }
      setState(() {
        checkApi = true;
      });
    }
    // print(response.body);
  }

  loadPreviousEvents() {
    mySelectedEvents;
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentOfferData = Provider.of<CurrentJobsOffersProvider>(context);
    final extractCurrentOfferData = currentOfferData.commentedJobsModel;
    final commentedJobsData = Provider.of<CommentedJobsProvider>(context);
    final extractCommentJobsData = commentedJobsData.commentedJobsModel;
    final checkCompleteProfile =
        Provider.of<CheckProfileCompletionProvider>(context);
    final extractedCompleteData = checkCompleteProfile.checkProfileComplete;
    final profileData = Provider.of<PersonalInformationProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: (commentedJobsData.checkApi == false &&
              currentOfferData.checkApi == false && profileData.profile == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  elevation: 0,
                  expandedHeight: 60,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: Container(
                      // color: Colors.red,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 30),
                      child: Text(
                        "Home_AppBar_Title",
                        style: Theme.of(context).textTheme.titleLarge,
                      ).tr()),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(MyRoutes.EVENTCALENDERSCREENROUTE),
                        icon: const Icon(
                          CupertinoIcons.calendar,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 8.0),
                      child: Stack(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(MyRoutes.NOTIFICATIONSCREENROUTE),
                            icon: const Icon(
                              CupertinoIcons.bell,
                              color: Colors.amber,
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 5,
                            child: Container(
                              height: 7,
                              width: 7,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  centerTitle: false,
                  backgroundColor: Colors.white,
                ),
              ],
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: mediaQuery.size.width / 40,
                    ),
                    if ((extractedCompleteData?.skills == "") ||
                        (extractedCompleteData?.monday == "" ||
                            extractedCompleteData?.tuesday == "" ||
                            extractedCompleteData?.wednesday == "" ||
                            extractedCompleteData?.thersday == "" ||
                            extractedCompleteData?.friday == "" ||
                            extractedCompleteData?.saturday == "" ||
                            extractedCompleteData?.sunday == "") ||
                        extractedCompleteData?.answer1 == "" ||
                        extractedCompleteData?.insurance1 == "" ||
                        extractedCompleteData?.rules1 == "" ||
                        profileData.profile?.image == 'main/avatar.png' ||
                        (profileData.profile?.phone == '') ||
                        (extractedCompleteData?.score == "") ||
                        ((extractedCompleteData?.euIdCardFront == "" &&
                            extractedCompleteData?.euIdDrivingFront == "" &&
                            extractedCompleteData?.euIdPassportFront == "" ) &&
                            extractedCompleteData?.euIdResidencePermitFront ==
                                "") ||
                        (extractedCompleteData?.vitalCardNumber == "" &&
                            extractedCompleteData?.socialSecurityNumber ==
                                "")) ...[
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
                                width: mediaQuery.size.width / 40,
                              ),
                              Text(
                                "Actions required",
                                style: Theme.of(context).textTheme.bodySmall,
                              ).tr(),
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
                        height: mediaQuery.size.width / 40,
                      ),
                    ],
                    if(profileData.profile != null  && profileData.profile!.verified == 1 )... [
                      Container(
                        color: Colors.amber.shade200,
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.circle_notifications_outlined,
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: mediaQuery.size.width / 40,
                            ),
                            Text(
                              "Your profile is under review",
                              style: Theme.of(context).textTheme.bodySmall,
                            ).tr(),
                          ],
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CurrentOffers(),
                              ));
                            },
                            child: Container(
                              width: mediaQuery.size.width / 2.2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.shade50,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        extractCurrentOfferData == null ? "0" : "${extractCurrentOfferData.length}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      SizedBox(
                                        height: mediaQuery.size.width / 80,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.save,
                                            size: 14,
                                            color: Colors.black38,
                                          ),
                                          SizedBox(
                                            width: mediaQuery.size.width / 80,
                                          ),
                                          Text(
                                            "Offers",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ).tr(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CurrentOffers(),
                              ));
                            },
                            child: Container(
                              width: mediaQuery.size.width / 2.2,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.shade50,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        extractCommentJobsData == null ? "0": "${extractCommentJobsData.length}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      SizedBox(
                                        height: mediaQuery.size.width / 80,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.save,
                                            size: 14,
                                            color: Colors.black38,
                                          ),
                                          SizedBox(
                                            width: mediaQuery.size.width / 80,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              "Commented jobs",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ).tr(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    if (checkApi == false) ...[
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ] else ...[
                      if (mySelectedEvents == {} || mySelectedEvents.isEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                color: Theme.of(context).primaryColor,
                                size: 150,
                              ),
                              SizedBox(
                                height: mediaQuery.size.width / 30,
                              ),
                              Text(
                                "No job planned soon",
                                style: Theme.of(context).textTheme.titleMedium,
                              ).tr(),
                              SizedBox(
                                height: mediaQuery.size.width / 40,
                              ),
                              Text(
                                "Go to your job list to find your next job.",
                                style: Theme.of(context).textTheme.labelMedium,
                                textAlign: TextAlign.center,
                              ).tr(),
                              SizedBox(
                                height: mediaQuery.size.width / 20,
                              ),
                              CustomButton(
                                  onPress: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeTabScreen(pageIndex: 1),));
                                  }, buttonName: "Find_Job"),
                            ],
                          ),
                        ),
                      ],
                      if (mySelectedEvents.isNotEmpty) ...[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Schedule ',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      getScheduleJobs();
                                      setState(() {
                                        checkApi = false;
                                      });
                                    },
                                    child: (checkApi == false)
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
                                ],
                              ),
                            ),
                            const Divider(),
                            TableCalendar(
                              locale: 'fr_FR',
                              calendarStyle: const CalendarStyle(
                                canMarkersOverflow: false,
                                todayTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.white),
                              ),
                              firstDay: DateTime(2022),
                              lastDay: DateTime(2030),
                              focusedDay: _focusedDay,
                              calendarFormat: _calendarFormat,
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!isSameDay(_selectedDate, selectedDay)) {
                                  // Call `setState()` when updating the selected day
                                  setState(() {
                                    _selectedDate = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                }
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDate, day);
                              },
                              onFormatChanged: (format) {
                                if (_calendarFormat != format) {
                                  // Call `setState()` when updating calendar format
                                  setState(() {
                                    _calendarFormat = format;
                                  });
                                }
                              },
                              onPageChanged: (focusedDay) {
                                // No need to call `setState()` here
                                _focusedDay = focusedDay;
                              },
                              eventLoader: _listOfDayEvents,
                            ),
                            const Divider(),
                            ..._listOfDayEvents(_selectedDate!).map(
                              (events) => Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => JobInfoScreen(
                                                  id: events['id']
                                                      .toString())));
                                    },
                                    child: Container(
                                      color: events['status'] == 2
                                          ? Colors.green.shade100
                                          : const Color(0xFFebf9fe),
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.brown.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
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
                                                  events['title'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "${events['estimate_budget']} €",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                80,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "${events['start_time']} - ${events['end_time']} (${events['duration']} h)",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                              const Spacer(),
                                              if (events['urgent'] == 1)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  child: const FittedBox(
                                                    child: Text(
                                                      "Urgent",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Cerebri Sans Bold',
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                events['service_date'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              const Spacer(),
                                              Text(
                                                events['status'] == 2
                                                    ? "Complete" : "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
