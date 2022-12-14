import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import './index_screen.dart';

import '../../screens/chat_screen/message_screen.dart';
import '../../screens/search_screen/search_jobs_screen.dart';
import '../../screens/account_screen/account_screen.dart';

class HomeTabScreen extends StatefulWidget {
  int pageIndex;
  HomeTabScreen({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  String? checkuserToken;
  String? checkUserName;

  sendToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("firebase token: $token");
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");

    if(userToken != null){
      var response = await http.get(
        Uri.parse('${MyRoutes.BASEURL}/save-token/$token'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        var json = response.body;
        debugPrint ("firebase token sent successfully");
        debugPrint(json);
      } else {
        debugPrint("firebase token sent request not working");
      }
    }
  }


  @override
  void initState() {
    super.initState();
    sendToken();

    FirebaseMessaging.onMessage.listen(
      // check if notification is not empty display the notification
            (RemoteMessage message) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if(notification != null && android != null) {

            flutterLocalNotificationsPlugin.show(
              notification.hashCode, //id
              notification.title, //title
              notification.body, //body
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  color: Colors.pink.shade100,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
            );
          }
        });

    // if app is running on background or terminated open notification and show notification in dialog box
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null)
      {
        setState((){
          Navigator.of(context).pushNamed(MyRoutes.NOTIFICATIONSCREENROUTE);
          debugPrint('notification');
        });
      }
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> screenWidgets = const [
    IndexScreen(),
    SearchJobScreen(),
    MessagesScreen(),
    AccountScreen(),
  ];
  Widget currentScreen = const IndexScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: screenWidgets.elementAt(widget.pageIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 25,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomTabBarItem(
                    () {
                  setState(() {
                    widget.pageIndex = 0;
                  });
                },
                CupertinoIcons.house,
                "Home_AppBar_Title",
                0,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                      widget.pageIndex = 1;
                  });
                },
                CupertinoIcons.rectangle_stack_badge_person_crop,
                "Search",
                1,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                    widget.pageIndex = 2;
                  });
                },
                CupertinoIcons.bubble_left_bubble_right,
                "Chat",
                2,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                    widget.pageIndex = 3;
                  });
                },
                CupertinoIcons.person,
                "Account",
                3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
    );
  }
  Widget bottomTabBarItem(
      VoidCallback onTap, IconData iconData, String title, int index) {
    return Expanded(
      child: MaterialButton(
        minWidth: 40,
        onPressed: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 25,
              color: widget.pageIndex == index
                  ? Colors.black
                  : Theme.of(context).iconTheme.color,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
                fontFamily: 'Cerebri Sans Regular',
                color: widget.pageIndex == index
                    ? Colors.black
                    : Theme.of(context).iconTheme.color,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
