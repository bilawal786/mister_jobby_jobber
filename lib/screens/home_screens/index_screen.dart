import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helper/routes.dart';
import '../../providers/check_profile_completion_provider/check_profile_completion_provider.dart';
import '../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import '../../widgets/const_widgets/custom_button.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
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
      setState(() {
        mySelectedEvents = Map<String,List>.from(json.decode(response.body));
        checkApi = true;
      });
      // print(mySelectedEvents);
    } else {
      debugPrint('Schedule Jobs Api is not working');
      setState((){
        checkApi = true;
      });
    }
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
    final checkCompleteProfile =
        Provider.of<CheckProfileCompletionProvider>(context);
    final extractedCompleteData = checkCompleteProfile.checkProfileComplete;
    final profileData = Provider.of<PersonalInformationProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: NestedScrollView(
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
                    Icons.date_range,
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
                        Icons.notifications_none_outlined,
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
              if ((extractedCompleteData?.skills == "" )  &&
                  (extractedCompleteData?.monday == "" ||
                      extractedCompleteData!.tuesday == "" ||
                      extractedCompleteData.wednesday == "" ||
                      extractedCompleteData.thersday == "" ||
                      extractedCompleteData.friday == "" ||
                      extractedCompleteData.saturday == "" ||
                      extractedCompleteData.sunday == "" ) ||
                  extractedCompleteData?.answer1 == "" ||
                  extractedCompleteData?.insurance1 == "" ||
                  extractedCompleteData?.rules1 == "" ||
                  profileData.profile?.image == 'main/avatar.png' ||
                  (extractedCompleteData?.phone == "" )||
                  (extractedCompleteData?.euIdCardFront == "" &&
                      extractedCompleteData?.euIdResidencePermitFront ==
                          "") ||
                  (extractedCompleteData?.vitalCardNumber == "" ||
                      extractedCompleteData?.socialSecurityNumber ==
                          "") ||
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
                          width: mediaQuery.size.width / 40,
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
                  height: mediaQuery.size.width / 40,
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: mediaQuery.size.width / 2.2,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade50,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "0",
                                style: Theme.of(context).textTheme.titleMedium,
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
                                    "Current Offers",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
                    Container(
                      width: mediaQuery.size.width / 2.2,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade50,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "0",
                                style: Theme.of(context).textTheme.titleMedium,
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
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: Text(
                                      "Commented jobs",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
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
                  ],
                ),
              ),
              const Divider(),
              if(mySelectedEvents == null) ...[
                SizedBox(
                  height: mediaQuery.size.width / 10,
                ),
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
                      ),
                      SizedBox(
                        height: mediaQuery.size.width / 40,
                      ),
                      Text(
                        "Go to your job list to find your next job.",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: mediaQuery.size.width / 20,
                      ),
                      CustomButton(onPress: () {}, buttonName: "Find_Job"),
                    ],
                  ),
                ),
              ],
              checkApi == false ? const Center(child: CircularProgressIndicator(),) :
              Column(
                children: <Widget>[
                  TableCalendar(
                    locale: 'fr_FR',
                    calendarStyle: const CalendarStyle(
                      canMarkersOverflow: false,
                      todayTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2023),
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
                        (events) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${events['service_date']}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 40,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${events['title']}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Cerebri Sans Bold',
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: Text(
                                        "${events['detail_description']}",
                                        style:
                                        Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
