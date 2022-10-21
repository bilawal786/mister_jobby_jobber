import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ManageNotifications extends StatefulWidget {
  const ManageNotifications({Key? key}) : super(key: key);

  @override
  State<ManageNotifications> createState() => _ManageNotificationsState();
}

class _ManageNotificationsState extends State<ManageNotifications> {
  bool news = false;
  bool tips = false;
  bool receive = false;
  bool assistance = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                'Email',
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Row(
                children: [
                  Text(
                    'News, gifts, good deals',
                    style: Theme.of(context).textTheme.labelLarge,
                  ).tr(),
                  const Spacer(),
                  Switch(
                      value: news,
                      onChanged: (value) {
                        setState(() {
                          news = value;
                        });
                      }),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    'Tips from partners',
                    style: Theme.of(context).textTheme.labelLarge,
                  ).tr(),
                  const Spacer(),
                  Switch(
                      value: tips,
                      onChanged: (value) {
                        setState(() {
                          tips = value;
                        });
                      }),
                ],
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                'SMS',
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
              Row(
                children: [
                  Text(
                    'I received offers for my service',
                    style: Theme.of(context).textTheme.labelLarge,
                  ).tr(),
                  const Spacer(),
                  Switch(
                      value: receive,
                      onChanged: (value) {
                        setState(() {
                          receive = value;
                        });
                      }),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: Text(
                      'Assistance in the event of provider cancellation',
                      style: Theme.of(context).textTheme.labelLarge,
                    ).tr(),
                  ),
                  const Spacer(),
                  Switch(
                      value: assistance,
                      onChanged: (value) {
                        setState(() {
                          assistance = value;
                        });
                      }),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
