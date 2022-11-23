import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/notifications_provider/notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationDisplay extends StatefulWidget {
  const NotificationDisplay({Key? key}) : super(key: key);

  @override
  State<NotificationDisplay> createState() => _NotificationDisplayState();
}

class _NotificationDisplayState extends State<NotificationDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NotificationDisplay(
                  // id: message.data['_id'],
                ),
              ),
            );
          }
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);

        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final notificationsData = Provider.of<NotificationsProvider>(context, listen: false);
    final extractNotification = notificationsData.notificationItems;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Notifications".tr(),style: Theme.of(context).textTheme.titleSmall,),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await Provider.of<NotificationsProvider>(context, listen: false).getNotification();
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: extractNotification!.length,
            itemBuilder: (ctx, index) => Column(
              children:<Widget> [
                Container(
                  color: extractNotification[index].status == "1" ? Colors.transparent : Colors.blueGrey.shade50,
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(extractNotification[index].status == "1"?
                        Icons.notifications_none : Icons.notifications,
                          size: 22,
                        ),
                        Text(
                  extractNotification[index].activity,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          extractNotification[index].message,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          extractNotification[index].createdAt,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}