import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/notifications_provider/notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationDisplay extends StatelessWidget {
  const NotificationDisplay({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: RefreshIndicator(
            onRefresh: ()async{
              await Provider.of<NotificationsProvider>(context, listen: false).getNotification();
            },
            child: ListView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }
}