import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:mister_jobby_jobber/models/job_models/available_jobs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helper/routes.dart';

class EventCalender extends StatefulWidget {
  const EventCalender({Key? key}) : super(key: key);

  @override
  State<EventCalender> createState() => _EventCalenderState();
}

class _EventCalenderState extends State<EventCalender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  AvailableJobsModel? availableJobs;

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Calender".tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),
      body: (checkApi == false)? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
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
              (events) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (ctx) => JobDetailScreen(
                      //         jobsDetail: events['id'])));
                    },
                    child: Container(
                      color: const Color(0xFFebf9fe),
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
                                width: MediaQuery.of(context).size.width / 1.5,
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
                            height:
                            MediaQuery.of(context).size.width /
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
                              if (events['urgent'] ==
                                  1)
                                Container(
                                  padding:
                                  const EdgeInsets.all(5.0),
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
                            events['service_date'],
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
            ),
          ],
        ),
      ),
    );
  }
}
