import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationDisplay extends StatefulWidget {
  const NotificationDisplay({Key? key}) : super(key: key);

  @override
  State<NotificationDisplay> createState() => _NotificationDisplayState();
}

class _NotificationDisplayState extends State<NotificationDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Notifications".tr(),style: Theme.of(context).textTheme.titleSmall,),
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (ctx, index) => Column(
              children:<Widget> [
                ListTile(
                  title: Text(
                    "7 days ago",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  subtitle: Text(
                    "your job 'Assembly of IKEA furniture' has been closed",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
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