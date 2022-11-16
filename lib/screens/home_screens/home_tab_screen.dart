import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> screenWidgets = [
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
                Icons.home_rounded,
                "Home_AppBar_Title",
                0,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                      widget.pageIndex = 1;
                  });
                },
                Icons.work_history_outlined,
                "Search",
                1,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                    widget.pageIndex = 2;
                  });
                },
                Icons.mark_as_unread_outlined,
                "Chat",
                2,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                    widget.pageIndex = 3;
                  });
                },
                Icons.person_outline,
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
