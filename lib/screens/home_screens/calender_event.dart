import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mister_jobby_jobber/models/job_models/available_jobs_model.dart';
import 'package:table_calendar/table_calendar.dart';

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
    loadPreviousEvents();
    print(loadPreviousEvents());
    print(_listOfDayEvents(_selectedDate!));
  }

  loadPreviousEvents() {
    mySelectedEvents = {
      "2022-11-17": [
        {
          "eventDescp": "Small sized furniture assemble with clean boxes",
          "eventTitle": "Furniture Assemble"
        },
      ],
      "2022-11-17": [
        {
          "eventDescp": "Small sized furniture assemble with clean boxes",
          "eventTitle": "Furniture Assemble 333333"
        },
      ],
      "2022-11-17": [
        {
          "eventDescp": "Small sized furniture assemble with clean boxes",
          "eventTitle": "Furniture Assemble 4444"
        },
      ],
    };
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
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
                      DateFormat.yMMMMEEEEd().format(_selectedDate!),
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
                                "${events['eventTitle']}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Cerebri Sans Bold',
                                  color: Colors.blue[700],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  "${events['eventDescp']}",
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
      ),
    );
  }
}
